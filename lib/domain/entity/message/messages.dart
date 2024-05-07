import 'package:boilerplate/domain/entity/message/message.dart';
import 'package:mobx/mobx.dart';

class Messages {
  ObservableList<Message> messages;
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
      messages: ObservableList.of(
          map['messages'].map<Message>((x) => Message.fromJson(x))),
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
