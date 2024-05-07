import 'dart:developer';

import 'package:boilerplate/data/network/apis/message/message_api.dart';
import 'package:boilerplate/domain/entity/message/message.dart';
import 'package:boilerplate/domain/entity/message/message_list.dart';
import 'package:boilerplate/domain/entity/message/message_project.dart';
import 'package:boilerplate/domain/repository/message/message_repository.dart';

class MessageRepositoryImpl extends MessageRepository {
  final MessageApi _messageApi;

  MessageRepositoryImpl(this._messageApi);

  @override
  Future<List<MessageListItem>> getMessages() async {
    try {
      final res = await _messageApi.getMessages();
      return res;
    } catch (e) {
      log("error fetching messages");
      throw e;
    }
  }

  @override
  Future<List<Message>> getProjectMessages(
      int projectId, int receiverId) async {
    try {
      final res = await _messageApi.getProjectMessages(projectId, receiverId);
      return res;
    } catch (e) {
      log("error fetching messages");
      throw e;
    }
  }

  @override
  Future<void> newMessage(dynamic message) async {
    try {
      await _messageApi.newMessage(message);
    } catch (e) {
      log("error sending message");
      throw e;
    }
  }

  @override
  Future<void> newSchedule(dynamic message) async {
    try {
      await _messageApi.newSchedule(message);
    } catch (e) {
      log("error sending schedule");
      throw e;
    }
  }

  @override
  Future<void> updateSchedule(int interviewId, dynamic message) async {
    try {
      await _messageApi.updateSchedule(interviewId, message);
    } catch (e) {
      log("error updating schedule");
      throw e;
    }
  }

  @override
  Future<void> cancelSchedule(int interviewId) async {
    try {
      await _messageApi.cancelSchedule(interviewId);
    } catch (e) {
      log("error cancelling schedule");
      throw e;
    }
  }
}
