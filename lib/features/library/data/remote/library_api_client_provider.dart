import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitness_music_recommender/features/common/data/remote/api_base_providers.dart';

import 'library_api_client.dart';

final libraryApiClientProvider = Provider<LibraryApiClient>((ref) {
  final dio = ref.watch(dioProvider);
  return LibraryApiClient(dio);
});
