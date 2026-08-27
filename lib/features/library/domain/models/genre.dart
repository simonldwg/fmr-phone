import 'package:json_annotation/json_annotation.dart';

@JsonEnum(valueField: 'label')
enum Genre {
  rock('Rock'),
  pop('Pop'),
  alternative('Alternative'),
  indie('Indie'),
  electronic('Electronic'),
  dance('Dance'),
  alternativeRock('Alternative Rock'),
  jazz('Jazz'),
  metal('Metal'),
  chillout('Chillout'),
  classicRock('Classic Rock'),
  soul('Soul'),
  indieRock('Indie Rock'),
  electronica('Electronica'),
  folk('Folk'),
  chill('Chill'),
  instrumental('Instrumental'),
  punk('Punk'),
  blues('Blues'),
  hardRock('Hard Rock'),
  ambient('Ambient'),
  acoustic('Acoustic'),
  experimental('Experimental'),
  hipHop('Hip-Hop'),
  country('Country'),
  easyListening('Easy Listening'),
  funk('Funk'),
  electro('Electro'),
  heavyMetal('Heavy Metal'),
  progressiveRock('Progressive Rock'),
  rnb('RnB'),
  indiePop('Indie Pop'),
  house('House');

  const Genre(this.label);

  final String label;
}
