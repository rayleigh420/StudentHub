// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:boilerplate/domain/entity/profile/student.dart';

class ItemProposal {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime? deletedAt;
  int projectId;
  int? studentId;
  String coverLetter;
  int statusFlag;
  int disableFlag;
  Student? student;
  ItemProposal({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.projectId,
    required this.studentId,
    required this.coverLetter,
    required this.statusFlag,
    required this.disableFlag,
    this.student,
  });
  factory ItemProposal.fromJson(Map<String, dynamic> map) {
    return ItemProposal(
      id: map['id'],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
      deletedAt:
          map['deletedAt'] != null ? DateTime.parse(map['deletedAt']) : null,
      projectId: map['projectId'],
      studentId: map['studentId']!=null ? map['studentId']:null,
      coverLetter: map['coverLetter'],
      statusFlag: map['statusFlag'],
      disableFlag: map['disableFlag'],
      student:
          map['student'] != null ? Student.fromJson(map['student']) : null,
    );
    
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "createdAt": createdAt.toIso8601String(),
      "updatedAt": updatedAt.toIso8601String(),
      "deletedAt": deletedAt?.toIso8601String(),
      "projectId": projectId,
      "studentId": studentId!,
      "coverLetter": coverLetter,
      "statusFlag": statusFlag,
      "disableFlag": disableFlag,
      "student": student?.toJson(),
    };
  }
  
}
