import 'dart:developer';

import 'package:boilerplate/data/network/apis/project/project_api.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/domain/entity/project_2/project.dart';
import 'package:boilerplate/domain/entity/project_2/project_list.dart';
import 'package:boilerplate/domain/repository/project/project_repository.dart';

class ProjectRepositoryImpl extends ProjectRepository {
  final SharedPreferenceHelper _sharedPreferenceHelper;
  final ProjectApi _projectApi;
  ProjectRepositoryImpl(this._projectApi, this._sharedPreferenceHelper);
  @override
  Future<ProjectList> getProjects() async {
    try {
      final token = await _sharedPreferenceHelper.authToken;
      log("token");
      ProjectList list = await _projectApi.getProjects(token!);
      log(list.toString());
      return list;
    } catch (e) {
      log("error");
      log(e.toString());
      throw new Exception(e.toString());
    }
  }
}
