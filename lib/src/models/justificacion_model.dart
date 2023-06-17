import 'dart:convert';

class JustificacionModel {
    int id;
    String identificador;
    DateTime fechaInicio;
    DateTime fechaFin;
    String motivo;
    int profesorId;
    int alumnoId;
    DateTime createdAt;
    DateTime updatedAt;
    UserModel? profesor;
    UserModel? alumno;

    JustificacionModel({
        required this.id,
        required this.identificador,
        required this.fechaInicio,
        required this.fechaFin,
        required this.motivo,
        required this.profesorId,
        required this.alumnoId,
        required this.createdAt,
        required this.updatedAt,
        this.profesor,
        this.alumno
    });

    factory JustificacionModel.fromJson(Map<String, dynamic> json) => JustificacionModel(
        id: json["id"],
        identificador: json["identificador"],
        fechaInicio: DateTime.parse(json["fecha_inicio"]),
        fechaFin: DateTime.parse(json["fecha_fin"]),
        motivo: json["motivo"],
        profesorId: json["profesor_id"],
        alumnoId: json["alumno_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        profesor: json['profesor'] == null ? null : UserModel.fromJson(json["profesor"]),
        alumno: json['alumno'] == null ? null : UserModel.fromJson(json["alumno"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "identificador": identificador,
        "fecha_inicio": "${fechaInicio.year.toString().padLeft(4, '0')}-${fechaInicio.month.toString().padLeft(2, '0')}-${fechaInicio.day.toString().padLeft(2, '0')}",
        "fecha_fin": "${fechaFin.year.toString().padLeft(4, '0')}-${fechaFin.month.toString().padLeft(2, '0')}-${fechaFin.day.toString().padLeft(2, '0')}",
        "motivo": motivo,
        "profesor_id": profesorId,
        "alumno_id": alumnoId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "profesor": profesor?.toJson(),
        "alumno": alumno?.toJson()
    };
}

class UserModel {
    int id;
    String nombre;
    String apellidoPaterno;
    String apellidoMaterno;
    String? numeroControl;
    String email;
    dynamic emailVerifiedAt;
    DateTime createdAt;
    DateTime updatedAt;

    UserModel({
        required this.id,
        required this.nombre,
        required this.apellidoPaterno,
        required this.apellidoMaterno,
        this.numeroControl,
        required this.email,
        this.emailVerifiedAt,
        required this.createdAt,
        required this.updatedAt,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        nombre: json["nombre"],
        apellidoPaterno: json["apellido_paterno"],
        apellidoMaterno: json["apellido_materno"],
        numeroControl: json["numero_control"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "apellido_paterno": apellidoPaterno,
        "apellido_materno": apellidoMaterno,
        "numero_control": numeroControl,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
