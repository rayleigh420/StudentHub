import 'package:boilerplate/domain/entity/skillSet/skillSet.dart';
import 'package:boilerplate/domain/entity/techStack/teachStack.dart';

class Experience {
  int? id;
  // int? studentId;
  String? title;
  String? startMonth;
  String? endMonth;
  String? description;
  List<SkillSet>? skillSets;

  Experience({
    this.id,
    // this.studentId,
    this.title,
    this.startMonth,
    this.endMonth,
    this.description,
    this.skillSets,
  });

  factory Experience.fromMap(Map<String, dynamic> json) => Experience(
        id: json["id"],
        // studentId: json["studentId"],
        title: json["title"],
        startMonth: json["startMonth"],
        endMonth: json["endMonth"],
        description: json["description"],
        skillSets: json["skillSets"] != null
            ? List<SkillSet>.from(
                json["skillSets"].map((x) => SkillSet.fromMap(x)))
            : [],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        // "studentId": studentId,
        "title": title,
        "startMonth": startMonth,
        "endMonth": endMonth,
        "description": description,
        "skillSets": skillSets != null
            ? List<dynamic>.from(skillSets!.map((x) => x.toMap()))
            : [],
      };
}

class ExperienceReq {
  int? id;
  // int? studentId;
  String? title;
  String? startMonth;
  String? endMonth;
  String? description;
  List<String>? skillSets;

  ExperienceReq({
    this.id,
    // this.studentId,
    this.title,
    this.startMonth,
    this.endMonth,
    this.description,
    this.skillSets,
  });

  factory ExperienceReq.fromMap(Map<String, dynamic> json) => ExperienceReq(
        id: json["id"],
        // studentId: json["studentId"],
        title: json["title"],
        startMonth: json["startMonth"],
        endMonth: json["endMonth"],
        description: json["description"],
        skillSets: json["skillSets"] != null
            ? List<String>.from(json["skillSets"].map((x) => x))
            : [],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        // "studentId": studentId,
        "title": title,
        "startMonth": startMonth,
        "endMonth": endMonth,
        "description": description,
        "skillSets": skillSets != null ? skillSets : [],
      };
}
