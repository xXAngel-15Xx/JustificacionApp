class UserModel {
    int id;
    String nombre;
    String apellidoPaterno;
    String apellidoMaterno;
    String? numeroControl;
    String email;
    dynamic emailVerifiedAt;
    DateTime? createdAt;
    DateTime? updatedAt;

    UserModel({
        required this.id,
        required this.nombre,
        required this.apellidoPaterno,
        required this.apellidoMaterno,
        this.numeroControl,
        required this.email,
        this.emailVerifiedAt,
        this.createdAt,
        this.updatedAt,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        nombre: json["nombre"],
        apellidoPaterno: json["apellido_paterno"],
        apellidoMaterno: json["apellido_materno"],
        numeroControl: json["numero_control"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["created_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "apellido_paterno": apellidoPaterno,
        "apellido_materno": apellidoMaterno,
        "numero_control": numeroControl,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
