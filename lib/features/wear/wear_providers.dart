import 'package:fitness_music_recommender/features/wear/data/wear_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final wearRepositoryProvider = Provider<WearRepository>(
  (ref) => WearRepository(),
);
