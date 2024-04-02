import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/domain/entity/language/language_student.dart';
import 'package:boilerplate/domain/entity/language/language_student_list.dart';

class LanguageApi {
  // dio instance
  final DioClient _dioClient;

  // injecting dio instance
  LanguageApi(this._dioClient);

  /// Returns list of post in response
  Future<LanguageStudentList> getLanguageByStudentId(int studentId) async {
    try {
      final res =
          await _dioClient.dio.get('${Endpoints.getLanguages}/$studentId');
      return LanguageStudentList.fromJson(res.data);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<LanguageStudentList> updateLanguageByStudentId(
      int studentId, LanguageStudentList languageStudentList) async {
    try {
      final res = await _dioClient.dio.put(
          '${Endpoints.getLanguages}/$studentId',
          data: languageStudentList.languageStudents!
              .map((e) => e.toMap())
              .toList());
      return LanguageStudentList.fromJson(res.data);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
