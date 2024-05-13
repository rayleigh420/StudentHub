

import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:dio/dio.dart';


class ResumeApi {
  final DioClient _dioClient;

  ResumeApi(this._dioClient);

  Future<FormData> createFormData( String filePath,String fileName) async {
    return FormData.fromMap({
      'name': 'dio',
      'date': DateTime.now().toIso8601String(),

      'file': await MultipartFile.fromFile(filePath, filename: fileName),
      
    });
  }

  Future<bool> postResume(int id, String token,String filePath, String fileName) async {

    try {
      print("api resume123");
      print(filePath);
      print(fileName);
      print("api end");

    

       FormData formData = await createFormData(filePath,fileName);
      print(formData.fields);
      final authToken = "Bearer ${token}";
      final res = await _dioClient.dio.put(Endpoints.postResume+"/$id"+"/resume",
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
  Future<String> getResume(int id, String token) async {
    try {
      final authToken = "Bearer ${token}";
      final res = await _dioClient.dio.get(Endpoints.getResume+"/$id"+"/resume",
      options: Options(
        headers: {
          'Authorization': authToken,
          }
        )
      );
      if (res.statusCode == 200) {
        return res.data["result"];
      } else {
        throw Exception(res.data);
      }
    } catch (e) {
      throw e;
    }
  }
}