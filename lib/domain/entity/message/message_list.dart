import 'package:boilerplate/domain/entity/message/message_user.dart';
import 'package:boilerplate/domain/entity/project_2/project.dart';

class MessageListItem {
  int id;
  MessageUser sender;
  MessageUser receiver;
  String content;
  DateTime createdAt;
  Project project;

  MessageListItem({
    required this.id,
    required this.sender,
    required this.receiver,
    required this.content,
    required this.createdAt,
    required this.project,
  });

  factory MessageListItem.fromJson(Map<String, dynamic> map) {
    return MessageListItem(
      id: map['id'],
      sender: MessageUser.fromJson(map['sender']),
      receiver: MessageUser.fromJson(map['receiver']),
      content: map['content'],
      createdAt: DateTime.parse(map['createdAt']),
      project: Project.fromJson(map['project']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sender': sender.toJson(),
      'receiver': receiver.toJson(),
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'project': project.toJson(),
    };
  }
}
