import 'package:fitness_music_recommender/features/library/ui/pages/album_detail_page.dart';
import 'package:fitness_music_recommender/features/settings/ui/pages/select_genre_filters_page.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/widgets/scaffold_with_nav_bar.dart';
import '../features/exercise/ui/exercise_page.dart';
import '../features/library/domain/models/song.dart';
import '../features/library/ui/library_page.dart';
import '../features/library/ui/pages/song_detail_page.dart';
import '../features/library/ui/pages/song_upload_page.dart';
import '../features/settings/data/settings_controller_provider.dart';
import '../features/settings/ui/pages/calculate_hr_page.dart';
import '../features/settings/ui/pages/set_api_url_page.dart';
import '../features/settings/ui/settings_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final _exerciseNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'exercise');
final _libraryNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'library');
final _settingsNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'settings');

final routerProvider = Provider<GoRouter>((ref) {
  final settingsController = ref.read(settingsControllerProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/exercise/overview',
    refreshListenable: settingsController,
    redirect: (context, state) {
      final loc = state.matchedLocation;
      final onOnboardingRoute = loc.startsWith('/onboarding');

      if (settingsController.isLoading) return null;
      if (settingsController.needsOnboarding && !onOnboardingRoute) {
        return '/onboarding/api-url';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/onboarding/api-url',
        builder: (context, state) => const SetApiUrlPage(isOnboarding: true),
      ),
      GoRoute(
        path: '/onboarding/calculate-hr',
        builder: (context, state) => CalculateHrPage(
          isOnboarding: true,
          apiUrlFromOnboarding: state.extra as String?,
        ),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            ScaffoldWithNavBar(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            navigatorKey: _exerciseNavigatorKey,
            routes: [
              GoRoute(
                path: '/exercise/overview',
                builder: (context, state) => const ExerciseOverviewPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _libraryNavigatorKey,
            routes: [
              GoRoute(
                path: '/library',
                builder: (context, state) => const LibraryPage(),
                routes: [
                  GoRoute(
                    path: '/songs/upload',
                    builder: (context, state) => const SongUploadPage(),
                  ),
                  GoRoute(
                    path: '/song',
                    builder: (context, state) {
                      final song = state.extra as Song;
                      return SongDetailPage(song: song);
                    },
                  ),
                  GoRoute(
                    path: '/albums/:albumId',
                    builder: (context, state) {
                      final albumId = state.pathParameters['albumId']!;
                      return AlbumDetailPage(albumId: albumId);
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _settingsNavigatorKey,
            routes: [
              GoRoute(
                path: '/settings',
                builder: (context, state) => const SettingsPage(),
              ),
              GoRoute(
                path: '/settings/api-url',
                builder: (context, state) => const SetApiUrlPage(),
              ),
              GoRoute(
                path: '/settings/calculate-hr',
                builder: (context, state) => CalculateHrPage(),
              ),
              GoRoute(
                path: '/settings/select-genre-filters',
                builder: (context, state) => SelectGenreFiltersPage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
