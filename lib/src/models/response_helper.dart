
class ResponseHelper {
  bool success;
  String message;
  dynamic helperData;

  ResponseHelper({required this.success, required this.message, this.helperData });

  factory ResponseHelper.fromJson(Map<String, dynamic> json) => ResponseHelper(
    success: json['success'], 
    message: json['message'],
    helperData: json['helper_data']
  );

  Map<String, dynamic> toJson() => {
    'success' : success,
    'message': message,
    'helper_data': helperData
  };
}