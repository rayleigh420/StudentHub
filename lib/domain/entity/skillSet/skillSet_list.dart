import 'package:boilerplate/domain/entity/skillSet/skillSet.dart';

class SkillSetList {
  final List<SkillSet>? SkillSets;

  SkillSetList({
    this.SkillSets,
  });

  factory SkillSetList.fromJson(Map<String, dynamic> json) {
    List<SkillSet> SkillSets = <SkillSet>[];
    SkillSets = List.from(
        json['result'].map((SkillSet) => SkillSet.fromMap(SkillSet)));

    return SkillSetList(
      SkillSets: SkillSets,
    );
  }
}