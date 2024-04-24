import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/domain/entity/message/message_project.dart';

class MessageApi {
  final DioClient _dioClient;
  MessageApi(this._dioClient);

  Future<List<MessageProject>> getMessages() async {
    try {
      final res = await _dioClient.dio.get(Endpoints.baseUrl + '/api/message');
      final data = res.data["result"];
      return List<MessageProject>.from(
          data.map((x) => MessageProject.fromJson(x)));
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
