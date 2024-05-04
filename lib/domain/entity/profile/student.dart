import 'package:boilerplate/domain/entity/educations/education.dart';
import 'package:boilerplate/domain/entity/experiences/experience.dart';
import 'package:boilerplate/domain/entity/language/language_student.dart';
// import 'package:boilerplate/domain/entity/language/Language.dart';
import 'package:boilerplate/domain/entity/proposal/proposal.dart';
import 'package:boilerplate/domain/entity/skillSet/skillSet.dart';
import 'package:boilerplate/domain/entity/techStack/teachStack.dart';
import 'package:boilerplate/domain/entity/profile/user.dart';

class Student {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime? deletedAt;
  int userId;
  int techStackId;
  User? user;
  TechStack? techStack;
  List<Proposal>? proposals;
  List<Education>? educations;
  List<LanguageStudent>? languages;
  List<Experience>? experiences;
  List<SkillSet>? skillSets;
  dynamic resume;
  dynamic transcript;
  Student(
      {required this.id,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt,
      required this.userId,
      required this.techStackId,
      this.user,
      this.resume,
      this.transcript,
      this.techStack,
      this.proposals,
      this.educations,
      this.languages,
      this.experiences,
      this.skillSets});

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
      transcript: map['transcript'],
      techStack:
          map['techStack'] != null ? TechStack.fromMap(map['techStack']) : null,
      user: map['user'] != null ? User.fromJson(map['user']) : null,
      proposals: List<Proposal>.from(
          map['proposals']?.map((x) => Proposal.fromJson(x))?.toList() ?? []),
      educations: List<Education>.from(
          map['educations']?.map((x) => Education.fromMap(x))?.toList() ?? []),
      languages: List<LanguageStudent>.from(
          map['languages']?.map((x) => LanguageStudent.fromMap(x))?.toList() ?? []),
      experiences: List<Experience>.from(
          map['experiences']?.map((x) => Experience.fromMap(x))?.toList() ??
              []),
      skillSets: List<SkillSet>.from(
          map['skillSets']?.map((x) => SkillSet.fromMap(x))?.toList() ?? []),
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
      'transcript': transcript,
      'techStack': techStack?.toMap(),
      'user': user?.toJson(),
      'proposals':
          proposals != null ? proposals!.map((x) => x.toJson()).toList() : null,
      'educations': educations != null
          ? educations!.map((x) => x.toMap()).toList()
          : null,
      'languages':
          languages != null ? languages!.map((x) => x.toMap()).toList() : null,
      'experiences': experiences != null
          ? experiences!.map((x) => x.toMap()).toList()
          : null,
      'skillSets':
          skillSets != null ? skillSets!.map((x) => x.toMap()).toList() : null,
    };
  }
}
