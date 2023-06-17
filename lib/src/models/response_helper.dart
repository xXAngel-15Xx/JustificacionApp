
class ResponseHelper {
  bool success;
  String message;

  ResponseHelper({required this.success, required this.message});

  factory ResponseHelper.fromJson(Map<String, dynamic> json) => ResponseHelper(
    success: json['success'], 
    message: json['message']
  );

  Map<String, dynamic> toJson() => {
    'success' : success,
    'message': message
  };
}