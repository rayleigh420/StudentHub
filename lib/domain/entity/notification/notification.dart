import 'package:boilerplate/domain/entity/message/interview.dart';
import 'package:boilerplate/domain/entity/message/message.dart';
import 'package:boilerplate/domain/entity/message/message_user.dart';
import 'package:boilerplate/domain/entity/notification/message_noti.dart';

class Noti {
  int id;
  String title;
  String content;
  DateTime createdAt;
  String notifyFlag;
  String typeNotifyFlag;
  MessageNoti? messageNoti;
  Interview? interview;
  MessageUser? sender;
  MessageUser? receiver;
  Noti(
      {required this.id,
      required this.title,
      required this.content,
      required this.createdAt,
      required this.notifyFlag,
      required this.typeNotifyFlag,
      required this.messageNoti,
      this.interview,
      this.sender,
      this.receiver});

  factory Noti.fromJson(Map<String, dynamic> json) {
    return Noti(
        id: json['id'],
        title: json['title'],
        content: json['content'],
        createdAt: DateTime.parse(json['createdAt']),
        notifyFlag: json['notifyFlag'],
        typeNotifyFlag: json['typeNotifyFlag'],
        messageNoti: json['message'] == null
            ? null
            : MessageNoti.fromJson(json['message']),
        interview: json['interview'] == null
            ? null
            : Interview.fromJson(json['interview']),
        sender: json['sender'] == null
            ? null
            : MessageUser.fromJson(json['sender']),
        receiver: json['receiver'] == null
            ? null
            : MessageUser.fromJson(json['receiver']));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'notifyFlag': notifyFlag,
      'typeNotifyFlag': typeNotifyFlag,
      'message': messageNoti?.toJson(),
      'interview': interview?.toJson(),
      'sender': sender?.toJson(),
      'receiver': receiver?.toJson()
    };
  }
}
