class ApiResponse {
  const ApiResponse({
    required this.success,
    required this.message,
  });

  final bool success;
  final String message;
}
