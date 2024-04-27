import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/domain/entity/message/message.dart';
import 'package:boilerplate/domain/entity/message/message_list.dart';
import 'package:boilerplate/domain/entity/message/message_project.dart';

class MessageApi {
  final DioClient _dioClient;
  MessageApi(this._dioClient);

  Future<List<MessageListItem>> getMessages() async {
    try {
      final res = await _dioClient.dio.get(Endpoints.baseUrl + '/api/message');
      final data = res.data["result"];
      return List<MessageListItem>.from(
          data.map((x) => MessageListItem.fromJson(x)));
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<List<Message>> getProjectMessages(
      int projectId, int receiverId) async {
    try {
      //https://api.studenthub.dev/api/message/471/user/2

      final res = await _dioClient.dio.get(
          Endpoints.baseUrl + '/api/message' + '/$projectId/user/$receiverId');
      final data = res.data["result"];
      return List<Message>.from(data.map((x) => Message.fromJson(x)));
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
