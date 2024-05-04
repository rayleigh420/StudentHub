import 'dart:math';

import 'package:boilerplate/data/network/apis/skillSet/skill_set_api.dart';
import 'package:boilerplate/domain/entity/skillSet/skillSet_list.dart';
import 'package:boilerplate/domain/repository/skillSet/skill_set_repository.dart';


class SkillSetRepositoryImpl extends SkillSetRepository {
  final SkillSetApi _skillSetApi;

  SkillSetRepositoryImpl( this._skillSetApi);

  @override
  Future<SkillSetList> getSkillSets() async {
    try {
      final SkillSetList result = await _skillSetApi.getSkillSets();
      return result;
    } catch (e) {
      throw e;
    }
  }


}