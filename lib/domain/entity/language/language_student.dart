class LanguageStudent {
  int? id;
  // int? studentId;
  String? languageName;
  String? level;

  LanguageStudent({
    this.id,
    // this.studentId,
    this.languageName,
    this.level,
  });

  factory LanguageStudent.fromMap(Map<String, dynamic> json) => LanguageStudent(
        id: json["id"],
        // studentId: json["studentId"],
        languageName: json["languageName"],
        level: json["level"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        // "studentId": studentId,
        "languageName": languageName,
        "level": level,
      };
}
