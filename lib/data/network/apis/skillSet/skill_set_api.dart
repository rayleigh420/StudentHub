import 'dart:async';
import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/domain/entity/skillSet/skillSet_list.dart';

class SkillSetApi {
  final DioClient _dioClient;

  SkillSetApi(this._dioClient);

  Future<SkillSetList> getSkillSets() async {
    try {
      final response = await _dioClient.dio.get(Endpoints.getSkillSets);
      return SkillSetList.fromJson(response.data);
    
    } catch (e) {
      throw e;
    }
  }
}