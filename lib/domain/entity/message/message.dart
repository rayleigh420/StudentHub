class Message {
  final String id;
  final int sender;
  final int receiver;
  final DateTime createdAt;
  final String type;
  final String content;
  final int projectId;
  Message({
    required this.id,
    required this.content,
    required this.sender,
    required this.receiver,
    required this.createdAt,
    required this.type,
    required this.projectId,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      content: json['content'],
      sender: json['sender'],
      receiver: json['receiver'],
      createdAt: DateTime.parse(json['createdAt']),
      type: json['type'],
      projectId: json['projectId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'sender': sender,
      'receiver': receiver,
      'createdAt': createdAt.toIso8601String(),
      'type': type,
      'projectId': projectId,
    };
  }
}
