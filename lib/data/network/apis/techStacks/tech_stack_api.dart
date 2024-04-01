import 'dart:async';

import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/domain/entity/techStack/techStack_list.dart';

class TechStackApi {
  // dio instance
  final DioClient _dioClient;

  // injecting dio instance
  TechStackApi(this._dioClient);

  /// Returns list of post in response
  Future<TechStackList> getTechStacks() async {
    try {
      final res = await _dioClient.dio.get(Endpoints.getTechStacks);
      return TechStackList.fromJson(res.data);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
