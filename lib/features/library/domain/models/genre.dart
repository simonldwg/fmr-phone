import 'package:json_annotation/json_annotation.dart';

enum Genre {
  @JsonValue('Rock')
  rock,
  @JsonValue('Pop')
  pop,
  @JsonValue('Alternative')
  alternative,
  @JsonValue('Indie')
  indie,
  @JsonValue('Electronic')
  electronic,
  @JsonValue('Dance')
  dance,
  @JsonValue('Alternative Rock')
  alternativeRock,
  @JsonValue('Jazz')
  jazz,
  @JsonValue('Metal')
  metal,
  @JsonValue('Chillout')
  chillout,
  @JsonValue('Classic Rock')
  classicRock,
  @JsonValue('Soul')
  soul,
  @JsonValue('Indie Rock')
  indieRock,
  @JsonValue('Electronica')
  electronica,
  @JsonValue('Folk')
  folk,
  @JsonValue('Chill')
  chill,
  @JsonValue('Instrumental')
  instrumental,
  @JsonValue('Punk')
  punk,
  @JsonValue('Blues')
  blues,
  @JsonValue('Hard Rock')
  hardRock,
  @JsonValue('Ambient')
  ambient,
  @JsonValue('Acoustic')
  acoustic,
  @JsonValue('Experimental')
  experimental,
  @JsonValue('Hip-Hop')
  hipHop,
  @JsonValue('Country')
  country,
  @JsonValue('Easy Listening')
  easyListening,
  @JsonValue('Funk')
  funk,
  @JsonValue('Electro')
  electro,
  @JsonValue('Heavy Metal')
  heavyMetal,
  @JsonValue('Progressive Rock')
  progressiveRock,
  @JsonValue('RnB')
  rnb,
  @JsonValue('Indie Pop')
  indiePop,
  @JsonValue('House')
  house;

  String get label => switch (this) {
    Genre.rock => 'Rock',
    Genre.pop => 'Pop',
    Genre.alternative => 'Alternative',
    Genre.indie => 'Indie',
    Genre.electronic => 'Electronic',
    Genre.dance => 'Dance',
    Genre.alternativeRock => 'Alternative Rock',
    Genre.jazz => 'Jazz',
    Genre.metal => 'Metal',
    Genre.chillout => 'Chillout',
    Genre.classicRock => 'Classic Rock',
    Genre.soul => 'Soul',
    Genre.indieRock => 'Indie Rock',
    Genre.electronica => 'Electronica',
    Genre.folk => 'Folk',
    Genre.chill => 'Chill',
    Genre.instrumental => 'Instrumental',
    Genre.punk => 'Punk',
    Genre.blues => 'Blues',
    Genre.hardRock => 'Hard Rock',
    Genre.ambient => 'Ambient',
    Genre.acoustic => 'Acoustic',
    Genre.experimental => 'Experimental',
    Genre.hipHop => 'Hip-Hop',
    Genre.country => 'Country',
    Genre.easyListening => 'Easy Listening',
    Genre.funk => 'Funk',
    Genre.electro => 'Electro',
    Genre.heavyMetal => 'Heavy Metal',
    Genre.progressiveRock => 'Progressive Rock',
    Genre.rnb => 'RnB',
    Genre.indiePop => 'Indie Pop',
    Genre.house => 'House',
  };
}
