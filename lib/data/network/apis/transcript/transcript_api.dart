
import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:dio/dio.dart';

class TranscriptApi {
  final DioClient _dioClient;

  TranscriptApi(this._dioClient);

  Future<FormData> createFormData( String filePath,String fileName) async {
    return FormData.fromMap({
      'name': 'dio',
      'date': DateTime.now().toIso8601String(),

      'file': await MultipartFile.fromFile(filePath, filename: fileName),
      
    });
  }

  Future<bool> postTranscript(int id, String token,String filePath, String fileName) async {

    try {

      print(filePath);
      print(fileName);
      print("api end");

    

       FormData formData = await createFormData(filePath,fileName);
      print(formData.fields);
      final authToken = "Bearer ${token}";
      final res = await _dioClient.dio.put(Endpoints.postTranscript+"/$id"+"/transcript",
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