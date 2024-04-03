import 'package:boilerplate/domain/entity/skillSet/skillSet.dart';

class SkillSetList {
  final List<SkillSet>? skillSets;

  SkillSetList({
    this.skillSets,
  });

  factory SkillSetList.fromJson(Map<String, dynamic> json) {
    List<SkillSet> skillSets = <SkillSet>[];
    skillSets = List.from(
        json['result'].map((skillSet) => SkillSet.fromMap(skillSet)));

    return SkillSetList(
      skillSets: skillSets,
    );
  }
}