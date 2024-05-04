import 'dart:developer';

import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/domain/entity/experiences/experience_list.dart';
import 'package:dio/dio.dart';

class ExperienceApi {
  // dio instance
  final DioClient _dioClient;

  // injecting dio instance
  ExperienceApi(this._dioClient);

  /// Returns list of post in response
  Future<ExperienceList> getExperienceByStudentId(int studentId) async {
    try {
      final res =
          await _dioClient.dio.get('${Endpoints.getExperiences}/$studentId');
      return ExperienceList.fromJson(res.data);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<ExperienceList> updateExperienceByStudentId(
      int studentId, ExperienceReqList experienceList) async {
    try {
      final res = await _dioClient.dio
          .put('${Endpoints.updateExperience}/$studentId', data: {
        'experience': experienceList.experiences!.map((e) => e.toMap()).toList()
      });
      return ExperienceList.fromJson(res.data);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
