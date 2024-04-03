import 'package:boilerplate/domain/entity/skillSet/skillSet.dart';
import 'package:boilerplate/domain/entity/techStack/teachStack.dart';

class Experience {
  int? id;
  int? studentId;
  String? title;
  DateTime? startMonth;
  DateTime? endMonth;
  String? description;
  List<SkillSet>? skillSets;

  Experience({
    this.id,
    this.studentId,
    this.title,
    this.startMonth,
    this.endMonth,
    this.description,
    this.skillSets,
  });

  factory Experience.fromMap(Map<String, dynamic> json) => Experience(
        id: json["id"],
        studentId: json["studentId"],
        title: json["title"],
        startMonth: DateTime.parse(json["startMonth"]),
        endMonth: DateTime.parse(json["endMonth"]),
        description: json["description"],
        skillSets: json["skillSets"] != null
            ? List<SkillSet>.from(
                json["skillSets"].map((x) => SkillSet.fromMap(x)))
            : [],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "studentId": studentId,
        "title": title,
        "startMonth": startMonth!.toIso8601String(),
        "endMonth": endMonth!.toIso8601String(),
        "description": description,
        "skillSets": skillSets != null
            ? List<dynamic>.from(skillSets!.map((x) => x.toMap()))
            : [],
      };
}
