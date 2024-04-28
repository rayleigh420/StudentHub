

import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:dio/dio.dart';

class ResumeApi {
  final DioClient _dioClient;

  ResumeApi(this._dioClient);

  Future<bool> postResume(int id, String token,String filePath, String fileName) async {
    try {
      print("api resume");
      print(filePath);
      print(fileName);
      print("api end");
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(filePath, filename: fileName),
      });
      print(formData.fields);
      final authToken = "Bearer ${token}";
      final res = await _dioClient.dio.post(Endpoints.postResume+"/$id"+"/resume",
      data: formData,
      options: Options(
        headers: {
          'Authorization': authToken,
          }
        )
      );
      if (res.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw e;
    }
  }
}