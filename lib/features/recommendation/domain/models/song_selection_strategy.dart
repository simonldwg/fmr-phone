enum SongSelectionStrategy {
  shortest('Kürzester Song'),
  median('Median (nach Länge)'),
  bestMatch('Passendster Song');

  const SongSelectionStrategy(this.label);

  final String label;
}
