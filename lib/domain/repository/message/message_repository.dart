import 'dart:async';

import 'package:boilerplate/domain/entity/message/message_project.dart';

abstract class MessageRepository {
  Future<List<MessageProject>> getMessages();
}
