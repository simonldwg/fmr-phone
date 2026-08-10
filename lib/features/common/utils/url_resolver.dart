String resolveUrl(String baseUrl, String path) {
  if (path.isEmpty) return path;

  final uri = Uri.tryParse(path);
  if (uri == null) return path;
  if (uri.hasScheme) return path;

  final base = Uri.tryParse(baseUrl);
  if (base == null) return path;

  return base.resolve(path).toString();
}
