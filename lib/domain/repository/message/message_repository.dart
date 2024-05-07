import 'dart:async';

import 'package:boilerplate/domain/entity/message/message.dart';
import 'package:boilerplate/domain/entity/message/message_list.dart';

abstract class MessageRepository {
  Future<List<MessageListItem>> getMessages();
  Future<List<Message>> getProjectMessages(int projectId, int receiverId);
  Future<void> newMessage(dynamic message);
  Future<void> newSchedule(dynamic message);
  Future<void> updateSchedule(int interviewId, dynamic message);
  Future<void> cancelSchedule(int interviewId);
}
