import 'dart:html';

import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:dio/dio.dart';

class TranscriptApi {
  final DioClient _dioClient;

  TranscriptApi(this._dioClient);

  Future<bool> postTranscript(int id, String token,FormData formData) async {
    try {
      final authToken = "Bearer ${token}";
      final res = await _dioClient.dio.post(Endpoints.postResume+"/$id"+"/transcript",
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