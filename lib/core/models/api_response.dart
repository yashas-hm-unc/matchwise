class ApiResponse {
  final bool success;

  final String message;

  final Map<String, dynamic>? args;

  const ApiResponse({
    this.success = false,
    this.message = 'Oops! Unexpected error occurred. Please try again later.',
    this.args,
  });
}
