// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song_genres.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SongGenres _$SongGenresFromJson(Map<String, dynamic> json) => SongGenres(
  (json['top3_genres'] as Map<String, dynamic>).map(
    (k, e) => MapEntry($enumDecode(_$GenreEnumMap, k), (e as num).toDouble()),
  ),
  (json['all_genres'] as Map<String, dynamic>).map(
    (k, e) => MapEntry($enumDecode(_$GenreEnumMap, k), (e as num).toDouble()),
  ),
);

Map<String, dynamic> _$SongGenresToJson(SongGenres instance) =>
    <String, dynamic>{
      'top3_genres': instance.top3Genres.map(
        (k, e) => MapEntry(_$GenreEnumMap[k]!, e),
      ),
      'all_genres': instance.allGenres.map(
        (k, e) => MapEntry(_$GenreEnumMap[k]!, e),
      ),
    };

const _$GenreEnumMap = {
  Genre.rock: 'Rock',
  Genre.pop: 'Pop',
  Genre.alternative: 'Alternative',
  Genre.indie: 'Indie',
  Genre.electronic: 'Electronic',
  Genre.dance: 'Dance',
  Genre.alternativeRock: 'Alternative Rock',
  Genre.jazz: 'Jazz',
  Genre.metal: 'Metal',
  Genre.chillout: 'Chillout',
  Genre.classicRock: 'Classic Rock',
  Genre.soul: 'Soul',
  Genre.indieRock: 'Indie Rock',
  Genre.electronica: 'Electronica',
  Genre.folk: 'Folk',
  Genre.chill: 'Chill',
  Genre.instrumental: 'Instrumental',
  Genre.punk: 'Punk',
  Genre.blues: 'Blues',
  Genre.hardRock: 'Hard Rock',
  Genre.ambient: 'Ambient',
  Genre.acoustic: 'Acoustic',
  Genre.experimental: 'Experimental',
  Genre.hipHop: 'Hip-Hop',
  Genre.country: 'Country',
  Genre.easyListening: 'Easy Listening',
  Genre.funk: 'Funk',
  Genre.electro: 'Electro',
  Genre.heavyMetal: 'Heavy Metal',
  Genre.progressiveRock: 'Progressive Rock',
  Genre.rnb: 'RnB',
  Genre.indiePop: 'Indie Pop',
  Genre.house: 'House',
};
