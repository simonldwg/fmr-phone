import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../settings/data/settings_controller_provider.dart';

final apiUrlProvider = Provider<String>((ref) {
  return ref.watch(
    settingsControllerProvider.select((c) => c.settings?.apiUrl ?? ''),
  );
});

final dioProvider = Provider<Dio>((ref) {
  final baseUrl = ref.watch(apiUrlProvider);

  final dio = Dio(
    BaseOptions(baseUrl: baseUrl, connectTimeout: const Duration(seconds: 5)),
  );
  return dio;
});
