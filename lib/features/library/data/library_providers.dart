import 'package:fitness_music_recommender/features/library/data/remote/library_api_client_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/data/remote/api_base_providers.dart';
import '../domain/models/album_short.dart';
import 'library_repository.dart';

final libraryRepositoryProvider = Provider<LibraryRepository>((ref) {
  final client = ref.watch(libraryApiClientProvider);
  final baseUrl = ref.watch(apiUrlProvider);
  return LibraryRepository(client, baseUrl);
});

final allAlbumsProvider = FutureProvider<List<AlbumShort>>((ref) {
  return ref.watch(libraryRepositoryProvider).getAllAlbums();
});
