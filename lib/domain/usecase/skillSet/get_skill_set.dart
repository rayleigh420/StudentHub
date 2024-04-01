

import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/entity/skillSet/skillSet_list.dart';
import 'package:boilerplate/domain/repository/skillSet/skill_set_repository.dart';

class GetSkillSetUC extends UseCase<SkillSetList, void> {
  final SkillSetRepository _skillSetRepository;

  GetSkillSetUC(this._skillSetRepository);

  @override
  Future<SkillSetList> call({required params})  {
    return  _skillSetRepository.getSkillSets();
  }
}