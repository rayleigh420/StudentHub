import 'dart:async';

import 'package:boilerplate/domain/entity/message/message.dart';
import 'package:boilerplate/domain/entity/message/message_list.dart';

abstract class MessageRepository {
  Future<List<MessageListItem>> getMessages();
  Future<List<Message>> getProjectMessages(int projectId, int receiverId);
}
