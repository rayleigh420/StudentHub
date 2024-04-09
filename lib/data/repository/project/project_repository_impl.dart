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

  @override
  Future<ProjectList> getCompanyProjects() async {
    try {
      final id = await _sharedPreferenceHelper.currentCompanyId;
      if (id == false) {
        throw new Exception("Company id is null");
      } else {
        return await _projectApi.getProjectsCompany(id!);
      }
      // return _projectApi.getProjectsCompany(1);
    } catch (e) {
      log("error");
      log(e.toString());
      throw new Exception(e.toString());
    }
  }

  @override
  Future<Project> postProject(String title, int scopeType, int studentNumber,
      String describeProject) async {
    try {
      final id = await _sharedPreferenceHelper.currentCompanyId;
      if (id == false) {
        throw new Exception("Company id is null");
      } else {
        return await _projectApi.postProject(
            title, scopeType, studentNumber, describeProject, id!);
      }
      // return _projectApi.getProjectsCompany(1);
    } catch (e) {
      log("error");
      log(e.toString());
      throw new Exception(e.toString());
    }
  }
  
  @override
  Future<bool> deleteProject(int id) async{
     try {
      final token = await _sharedPreferenceHelper.authToken;
      log("token");
      final res = await _projectApi.deleteProject(token!,id);

      return res;
    } catch (e) {
      log("error");
      log(e.toString());
      throw new Exception(e.toString());
    }

  }
  
  @override
  Future<Project> updateProject(int id, int typeFlag) async {
    // TODO: implement updateProject
     try {
      final token = await _sharedPreferenceHelper.authToken;
      log("token");
      final res = await _projectApi.updateProject(token!,id,typeFlag);

      return res;
    } catch (e) {
      log("error");
      log(e.toString());
      throw new Exception(e.toString());
    }
  }
}
