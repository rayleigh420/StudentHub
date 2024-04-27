import 'package:boilerplate/domain/entity/message/message.dart';
import 'package:boilerplate/domain/entity/project_2/project.dart';

class MessageProject {
  final Project project;
  final List<Message> messages;
  late int? otherId;
  late String? otherFullname;
  MessageProject(
      {required this.project,
      required this.messages,
      this.otherId,
      this.otherFullname});

  factory MessageProject.fromJson(Map<String, dynamic> map) {
    return MessageProject(
      project: Project.fromJson(map['project']),
      messages:
          List<Message>.from(map['messages'].map((x) => Message.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'project': project.toJson(),
      'messages': messages.map((x) => x.toJson()).toList(),
    };
  }
}
