import 'dart:math';

import 'package:boilerplate/data/network/apis/techStacks/tech_stack_api.dart';
import 'package:boilerplate/domain/entity/techStack/techStack_list.dart';
import 'package:boilerplate/domain/repository/techStack/teach_stack_repository.dart';

class TechStackRepositoryImpl extends TechStackRepository {
  final TechStackApi _techStackApi;

  TechStackRepositoryImpl(this._techStackApi);

  @override
  Future<TechStackList> getTechStacks() async {
    try {
      TechStackList tsl = await _techStackApi.getTechStacks();
      return tsl;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
