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
  Future<ProjectList> getProjects(String token) async {
    try {
      // final token = await getIt<SharedPreferenceHelper>().authToken;
      final authToken = "Bearer ${token}";
      final res = await _dioClient.dio.get(
        Endpoints.getProjects,
        options: Options(
          headers: {
            'Authorization': authToken,
          },
        ),
      );
      log(res.data["result"].runtimeType.toString());
      return ProjectList.fromJson(res.data["result"]);
    } catch (e) {
      log("error in get projects api");
      log(e.toString());
      throw new Exception(e.toString());
    }
  }
}
