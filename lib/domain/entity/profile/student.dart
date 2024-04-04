class Student {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime? deletedAt;
  int userId;
  int techStackId;
  dynamic resume;
  dynamic transcript;
  Student({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.userId,
    required this.techStackId,
    this.resume,
    this.transcript,
  });

  factory Student.fromJson(Map<String, dynamic> map) {
    return Student(
      id: map['id'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
      deletedAt: DateTime.parse(map['deleted_at']),
      userId: map['user_id'],
      techStackId: map['tech_stack_id'],
      resume: map['resume'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
      'user_id': userId,
      'tech_stack_id': techStackId,
      'resume': resume,
    };
  }
}
