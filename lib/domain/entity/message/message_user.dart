class MessageUser {
  int id;
  String fullname;
  MessageUser({
    required this.id,
    required this.fullname,
  });

  factory MessageUser.fromJson(Map<String, dynamic> json) {
    return MessageUser(
      id: json['id'],
      fullname: json['fullname'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullname': fullname,
    };
  }
}
