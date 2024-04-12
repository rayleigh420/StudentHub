import 'dart:convert';

import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/domain/entity/project_2/project_list.dart';

class FavoriteApi {
  // dio instance
  final DioClient _dioClient;

  // injecting dio instance
  FavoriteApi(this._dioClient);

  Future<ProjectList> getFavoriteProject(int studentId) async {
    try {
      final res =
          await _dioClient.dio.get('${Endpoints.getFavorites}/$studentId');
      return ProjectList.fromJson_project(res.data["result"]);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<bool> addFavorite(
      int studentId, int projectId, int disableFlag) async {
    try {
      final res = await _dioClient.dio.patch(
          '${Endpoints.addFavorite}/$studentId',
          data:
              jsonEncode({"projectId": projectId, "disableFlag": disableFlag}));
      if (res.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
