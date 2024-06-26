import 'dart:convert';
import 'dart:developer';

import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/domain/entity/project_2/project.dart';
import 'package:boilerplate/domain/entity/project_2/project_list.dart';
import 'package:dio/dio.dart';

class ProjectApi {
  final DioClient _dioClient;
  ProjectApi(this._dioClient);
  Future<ProjectList> getProjects(String token,
      {String? title,
      int? projectScopeFlag,
      int? numberOfStudents,
      int? proposalsLessThan}) async {
    try {
      // final token = await getIt<SharedPreferenceHelper>().authToken;
      final authToken = "Bearer ${token}";
      final Map<String, dynamic> queryParams = {};
      if (title != null) queryParams['title'] = title;
      if (projectScopeFlag != null)
        queryParams['projectScopeFlag'] = projectScopeFlag;
      if (numberOfStudents != null)
        queryParams['numberOfStudents'] = numberOfStudents;
      if (proposalsLessThan != null)
        queryParams['proposalsLessThan'] = proposalsLessThan;
      queryParams['page'] = 1;
      queryParams['perPage'] = 20000;
      final res = await _dioClient.dio.get(Endpoints.getProjects,
          options: Options(
            headers: {
              'Authorization': authToken,
            },
          ),
          queryParameters: queryParams);
      log(res.data["result"].runtimeType.toString());
      return ProjectList.fromJson(res.data["result"]);
    } catch (e) {
      log("error in get projects api");
      log(e.toString());
      return ProjectList(projects: []);
      throw new Exception(e.toString());
    }
  }

  Future<ProjectList> searchProjects(String token,
      {String? title,
      int? projectScopeFlag,
      int? numberOfStudents,
      int? proposalsLessThan,
      int? page,
      int? perPage}) async {
    final authToken = "Bearer ${token}";
    final Map<String, dynamic> queryParams = {};
    if (title != null) queryParams['title'] = title;
    if (projectScopeFlag != null)
      queryParams['projectScopeFlag'] = projectScopeFlag;
    if (numberOfStudents != null)
      queryParams['numberOfStudents'] = numberOfStudents;
    if (proposalsLessThan != null)
      queryParams['proposalsLessThan'] = proposalsLessThan;
    if (page != null) queryParams['page'] = page;
    if (perPage != null) queryParams['perPage'] = perPage;

    final res = await _dioClient.dio.get(Endpoints.getProjects,
        options: Options(
          headers: {
            'Authorization': authToken,
          },
        ),
        queryParameters: queryParams);
    if (res.statusCode != 200) {
      return ProjectList(projects: []);
    } else {
      log(res.data["result"].runtimeType.toString());
      return ProjectList.fromJson(res.data["result"]);
    }
  }

  Future<ProjectList> getProjectsCompany(int companyId) async {
    try {
      // final token = await getIt<SharedPreferenceHelper>().authToken;
      final res = await _dioClient.dio.get(
        Endpoints.getProjectCompany + "/" + companyId.toString(),
      );
      log("cdc");
      log(res.data["result"].toString());
      log(res.data["result"].runtimeType.toString());
      return ProjectList.fromJson(res.data["result"]);
    } catch (e) {
      log("error in get projects api");
      log(e.toString());
      throw new Exception(e.toString());
    }
  }

  Future<Project> postProject(String title, int scopeType, int studentNumber,
      String describeProject, int companyId) async {
    try {
      final res = await _dioClient.dio.post(
        Endpoints.createProject,
        data: jsonEncode({
          "companyId": companyId,
          "title": title,
          "projectScopeFlag": scopeType,
          "numberOfStudents": studentNumber,
          "description": describeProject,
          "typeFlag": 0
        }),
      );
      log("cdc2");
      log(res.data["result"].toString());
      log(res.data["result"].runtimeType.toString());
      res.data["result"]["companyId"] =
          res.data["result"]["companyId"].toString();
      return Project.fromJson(res.data["result"]);
    } catch (e) {
      log("error in get projects api");
      log(e.toString());
      throw new Exception(e.toString());
    }
  }

  Future<bool> deleteProject(String token, int id) async {
    try {
      final authToken = "Bearer ${token}";
      final res = await _dioClient.dio.delete(
        Endpoints.deleteProject + "/" + id.toString(),
        options: Options(
          headers: {
            'Authorization': authToken,
          },
        ),
      );
      log("cdc2");
      log(res.data["result"].toString());
      log(res.data["result"].runtimeType.toString());
      return true;
    } catch (e) {
      log("error in delete projects api");
      log(e.toString());
      throw new Exception(e.toString());
    }
  }

  Future<Project> updateProject(String token, Project project) async {
    try {
      final authToken = "Bearer ${token}";
      final res = await _dioClient.dio.patch(
        Endpoints.updateProject + "/" + project.id.toString(),
        data: jsonEncode({
          "projectScopeFlag": project.projectScopeFlag,
          "title": project.title,
          "description": project.description,
          "numberOfStudents": project.numberOfStudents,
          "typeFlag": project.typeFlag
        }),
        options: Options(
          headers: {
            'Authorization': authToken,
          },
        ),
      );
      log("cdc2");
      log(res.data["result"].toString());
      log(res.data["result"].runtimeType.toString());
      return Project.fromJson(res.data["result"]);
    } catch (e) {
      log("error in update projects api");
      log(e.toString());
      throw new Exception(e.toString());
    }
  }
}
