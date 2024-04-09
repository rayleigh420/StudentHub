import 'dart:async';

import 'package:boilerplate/domain/entity/skillSet/skillSet_list.dart';

abstract class SkillSetRepository {
  Future<SkillSetList> getSkillSets();
}