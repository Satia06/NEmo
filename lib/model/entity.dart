class Entity {
  final String? name;
  final String? description;
  final List<String>? qualities;

  Entity({
    this.name,
    this.description,
    this.qualities,
  });
  factory Entity.fromJson(Map<String, dynamic> json) {
    return Entity(
        name: json['name'] ?? "",
        description: json['desc'] ?? "No description",
        qualities: json[" qualities"] ?? []);
  }
  //Entity en1;
  //en1.toJson()
  Map<String, dynamic> toJson() => _entityToJson(this);
  Map<String, dynamic> _entityToJson(Entity instance) => <String, dynamic>{
        'name': instance.name,
        'desc': instance.description,
        'qualities': instance.qualities,
      };
}
