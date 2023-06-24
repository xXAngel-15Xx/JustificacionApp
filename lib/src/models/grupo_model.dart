import 'package:justificacion_app/src/models/user_model.dart';

class GruposModel {
    int id;
    String nombre;
    String semestre;
    String carrera;
    String aula;
    DateTime createdAt;
    DateTime updatedAt;
    List<UserModel>? users;

    GruposModel({
        required this.id,
        required this.nombre,
        required this.semestre,
        required this.carrera,
        required this.aula,
        required this.createdAt,
        required this.updatedAt,
        this.users,
    });

    factory GruposModel.fromJson(Map<String, dynamic> json) => GruposModel(
        id: json["id"],
        nombre: json["nombre"],
        semestre: json["semestre"],
        carrera: json["carrera"],
        aula: json["aula"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        users: json['users'] == null ? null : List<UserModel>.from(json['users'].map((x) => UserModel.fromJson(x)))
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "semestre": semestre,
        "carrera": carrera,
        "aula": aula,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "users": users
    };
}
