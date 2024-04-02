import 'package:boilerplate/domain/entity/language/language_student.dart';

class LanguageStudentList {
  final List<LanguageStudent>? languageStudents;

  LanguageStudentList({
    this.languageStudents,
  });

  factory LanguageStudentList.fromJson(Map<String, dynamic> json) {
    List<LanguageStudent> languageStudents = <LanguageStudent>[];
    languageStudents = List.from(json['result']
        .map((languageStudent) => LanguageStudent.fromMap(languageStudent)));

    return LanguageStudentList(
      languageStudents: languageStudents,
    );
  }
}
