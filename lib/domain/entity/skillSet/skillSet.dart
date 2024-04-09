class SkillSet {
  int? id;
  String? name;

  SkillSet({this.id, this.name});

  factory SkillSet.fromMap(Map<String, dynamic> json) => SkillSet(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}
