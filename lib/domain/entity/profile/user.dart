class User {
  String? fullname;
  User({this.fullname});

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
      fullname: map['fullname'] == null ? null : map['fullname'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "fullname": fullname,
    };
  }
}
