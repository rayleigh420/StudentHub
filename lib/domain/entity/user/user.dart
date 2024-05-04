class User {
  int? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  String? email;
  String? password;
  List<String>? roles;
  bool? isConfirmed;

  User({
    this.id,
    this.email,
    this.password,
    this.roles,
    this.isConfirmed,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
      deletedAt: DateTime.parse(map['deleted_at']),
      email: map['email'],
      password: map['password'],
      roles: List<String>.from(map['roles']),
      isConfirmed: map['isConfirmed'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
      'email': email,
      'password': password,
      'roles': roles,
      'isConfirmed': isConfirmed,
    };
  }
}
