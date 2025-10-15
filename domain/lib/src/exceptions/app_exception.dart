class AppException implements Exception {

  const AppException(this.message);

  const AppException.unknown() : message = 'Unknown Error!';
  final String message;

  @override
  String toString() => message;
}
