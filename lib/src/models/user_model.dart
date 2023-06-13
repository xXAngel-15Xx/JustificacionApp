
class UserModel {
  int id;
  String nombres;
  String apellidoPaterno;
  String apellidoMaterno;
  String email;
  String password;
  String role;
  String? numeroControl;
  String? carrera;
  String? semestre;

  UserModel({
   required this.id,
   required this.nombres,
   required this.apellidoPaterno,
   required this.apellidoMaterno,
   required this.email,
   required this.password,
   required this.role,
   this.semestre,
   this.carrera,
   this.numeroControl
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'],
    nombres: json['nombres'],
    apellidoPaterno: json['apellido_paterno'],
    apellidoMaterno: json['apellido_materno'],
    email: json['email'],
    password: json['password'],
    role: json['role'],
    numeroControl: json['numero_control'],
    carrera: json['carrera'],
    semestre: json['semestre'] 
  );

  Map<String, dynamic> toJson() => {
    'id'    : id,
    'nombres': nombres,
    'apellido_paterno': apellidoPaterno,
    'apellido_materno': apellidoMaterno,
    'email': email,
    'password': password,
    'role': role,
    'numeroControl': numeroControl,
    'carrera': carrera,
    'semestre': semestre 
  };

  Map<String, dynamic> tpJsonCreate() => {
    'nombres': nombres,
    'apellido_paterno': apellidoPaterno,
    'apellido_materno': apellidoMaterno,
    'email': email,
    'password': password,
    'role': role,
    'numeroControl': numeroControl,
    'carrera': carrera,
    'semestre': semestre 
  };
}