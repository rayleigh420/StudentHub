import 'package:boilerplate/domain/entity/techStack/teachStack.dart';

class Experience {
  int? id;
  int? studentId;
  String? title;
  DateTime? startMonth;
  DateTime? endMonth;
  String? description;
  List<TechStack>? techStacks;

  Experience({
    this.id,
    this.studentId,
    this.title,
    this.startMonth,
    this.endMonth,
    this.description,
    this.techStacks,
  });

  factory Experience.fromMap(Map<String, dynamic> json) => Experience(
        id: json["id"],
        studentId: json["studentId"],
        title: json["title"],
        startMonth: DateTime.parse(json["startMonth"]),
        endMonth: DateTime.parse(json["endMonth"]),
        description: json["description"],
        techStacks: json["techStacks"] != null
            ? List<TechStack>.from(
                json["techStacks"].map((x) => TechStack.fromMap(x)))
            : [],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "studentId": studentId,
        "title": title,
        "startMonth": startMonth!.toIso8601String(),
        "endMonth": endMonth!.toIso8601String(),
        "description": description,
        "techStacks": techStacks != null
            ? List<dynamic>.from(techStacks!.map((x) => x.toMap()))
            : [],
      };
}
