import 'package:boilerplate/domain/entity/message/message_project.dart';

class MessageList {
  final List<MessageProject> messages;

  MessageList({
    required this.messages,
  });

  factory MessageList.fromJson(Map<String, dynamic> map) {
    return MessageList(
      messages: List<MessageProject>.from(
          map['messages'].map((x) => MessageProject.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'messagesProject': messages.map((x) => x.toJson()).toList(),
    };
  }
}
