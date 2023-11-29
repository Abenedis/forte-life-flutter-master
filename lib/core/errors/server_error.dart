class ServerError implements Exception {
  ServerError(this.message);

  factory ServerError.fromJson(Map<String, dynamic> json) {
    return ServerError(
      json['error'] as String,
    );
  }

  final String message;

  @override
  String toString() => message;
}
