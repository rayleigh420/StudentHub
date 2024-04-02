import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/domain/entity/educations/education_list.dart';

class EducationApi {
  // dio instance
  final DioClient _dioClient;

  // injecting dio instance
  EducationApi(this._dioClient);

  /// Returns list of post in response
  Future<EducationList> getEducationByStudentId(int studentId) async {
    try {
      final res =
          await _dioClient.dio.get('${Endpoints.getEducations}/$studentId');
      return EducationList.fromJson(res.data);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<EducationList> updateEducationByStudentId(
      int studentId, EducationList educationList) async {
    try {
      final res = await _dioClient.dio.put(
          '${Endpoints.getEducations}/$studentId',
          data: educationList.educations!.map((e) => e.toMap()).toList());
      return EducationList.fromJson(res.data);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
