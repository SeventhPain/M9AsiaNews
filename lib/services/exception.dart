class NewsException implements Exception {
  final String message;

  NewsException(this.message);

  @override
  String toString() => 'NewsException: $message';
}
