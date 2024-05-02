import 'package:boilerplate/domain/entity/message/interview.dart';
import 'package:boilerplate/domain/entity/message/message_user.dart';

class Message {
  final int id;
  final MessageUser sender;
  final MessageUser receiver;
  final DateTime createdAt;
  final String content;
  final Interview? interview;
  Message(
      {required this.id,
      required this.content,
      required this.sender,
      required this.receiver,
      required this.createdAt,
      required this.interview});

  factory Message.fromJson(Map<String, dynamic> map) {
    return Message(
      id: map['id'],
      content: map['content'],
      sender: MessageUser.fromJson(map['sender']),
      receiver: MessageUser.fromJson(map['receiver']),
      createdAt: DateTime.parse(map['createdAt']),
      interview: map['interview'] == null
          ? null
          : Interview.fromJson(map['interview']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'sender': sender.toJson(),
      'receiver': receiver.toJson(),
      'interview': interview?.toJson(),
    };
  }
}
