class Noti {
  int id;
  String title;
  String content;
  DateTime createdAt;
  String notifyFlag;
  String typeNotifyFlag;

  Noti({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.notifyFlag,
    required this.typeNotifyFlag,
  });

  factory Noti.fromJson(Map<String, dynamic> json) {
    return Noti(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      createdAt: DateTime.parse(json['createdAt']),
      notifyFlag: json['notifyFlag'],
      typeNotifyFlag: json['typeNotifyFlag'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'notifyFlag': notifyFlag,
      'typeNotifyFlag': typeNotifyFlag,
    };
  }
}
