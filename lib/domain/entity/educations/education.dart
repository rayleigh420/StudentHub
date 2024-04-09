class Education {
  int? id;
  // int? studentId;
  String? schoolName;
  DateTime? startYear;
  DateTime? endYear;

  Education({
    this.id,
    // this.studentId,
    this.schoolName,
    this.startYear,
    this.endYear,
  });

  factory Education.fromMap(Map<String, dynamic> json) => Education(
        id: json["id"],
        // studentId: json["studentId"],
        schoolName: json["schoolName"],
        startYear: DateTime.parse(json["startYear"]),
        endYear: DateTime.parse(json["endYear"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        // "studentId": studentId,
        "schoolName": schoolName,
        "startYear": startYear!.toIso8601String(),
        "endYear": endYear!.toIso8601String(),
      };
}
