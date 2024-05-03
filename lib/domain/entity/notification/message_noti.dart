class MessageNoti {
  int id;
  DateTime createdAt;
  int senderId;
  int receiverId;
  int projectId;
  int? interviewId;
  String content;
  int messageFlag;

  MessageNoti({
    required this.id,
    required this.createdAt,
    required this.senderId,
    required this.receiverId,
    required this.projectId,
    this.interviewId,
    required this.content,
    required this.messageFlag,
  });

  factory MessageNoti.fromJson(Map<String, dynamic> json) {
    return MessageNoti(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      projectId: json['projectId'],
      interviewId: json['interviewId'],
      content: json['content'],
      messageFlag: json['messageFlag'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt.toIso8601String(),
      'senderId': senderId,
      'receiverId': receiverId,
      'projectId': projectId,
      'interviewId': interviewId,
      'content': content,
      'messageFlag': messageFlag,
    };
  }
}