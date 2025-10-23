class HttpExceptions implements Exception{
  final String message;
  final int statusCode;

  const HttpExceptions({required this.message, required this.statusCode});

}