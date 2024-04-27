import 'package:boilerplate/domain/entity/message/message.dart';

class Messages {
  List<Message> messages;
  int projectId;
  int receiverId;
  int senderId;
  Messages(
      {required this.messages,
      required this.projectId,
      required this.receiverId,
      required this.senderId});

  factory Messages.fromJson(Map<String, dynamic> map) {
    return Messages(
      messages:
          List<Message>.from(map['messages'].map((x) => Message.fromJson(x))),
      projectId: map['projectId'],
      receiverId: map['receiverId'],
      senderId: map['senderId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'messages': messages.map((x) => x.toJson()).toList(),
      'projectId': projectId,
      'receiverId': receiverId,
      'senderId': senderId,
    };
  }
}
