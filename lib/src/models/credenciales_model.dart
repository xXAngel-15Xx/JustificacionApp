
class CredencialesModel {
  String email;
  String password;

  CredencialesModel({required this.email, required this.password});

  factory CredencialesModel.fromJson(Map<String, dynamic> json) => CredencialesModel(
    email: json['email'], 
    password: json['password']
  );
  
  Map<String, dynamic> toJson() => {
    'email' : email,
    'password': password
  };
}