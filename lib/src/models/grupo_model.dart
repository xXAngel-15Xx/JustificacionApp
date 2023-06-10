
class GrupoModel {
  int id;
  String nombre;

  GrupoModel({
   required this.id,
   required this.nombre 
  });

  factory GrupoModel.fromJson(Map<String, dynamic> json) => GrupoModel(
    id: json['id'],
    nombre: json['nombre']
  );

  Map<String, dynamic> toJson() => {
    'id'    : id,
    'nombre': nombre
  };

  Map<String, dynamic> tpJsonCreate() => {
    'nombre': nombre
  };
}