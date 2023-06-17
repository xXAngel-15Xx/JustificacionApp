
class StorageModel {
  String key;
  String value;

  StorageModel({required this.key, required this.value});

  factory StorageModel.fromJson(Map<String, dynamic> json) => StorageModel(
    key: json['key'], 
    value: json['value']
  );

  Map<String, dynamic> toJson() => {
    'key' : key,
    'value': value
  };
}