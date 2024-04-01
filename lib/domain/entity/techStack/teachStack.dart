class TechStack {
  int? id;
  String? name;

  TechStack({this.id, this.name});

  factory TechStack.fromMap(Map<String, dynamic> json) => TechStack(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}
