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
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
      deletedAt:
          map['deletedAt'] != null ? DateTime.parse(map['deletedAt']) : null,
      userId: map['userId'],
      techStackId: map['techStackId'],
      resume: map['resume'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'userId': userId,
      'techStackId': techStackId,
      'resume': resume,
    };
  }
}
