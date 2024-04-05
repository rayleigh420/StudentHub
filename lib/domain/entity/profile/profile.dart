import 'package:boilerplate/domain/entity/profile/company.dart';
import 'package:boilerplate/domain/entity/profile/student.dart';

class Profile {
  int id;
  String fullname;
  List<String> roles;
  Student? student;
  Company? company;
  Profile({
    required this.id,
    required this.fullname,
    required this.roles,
    this.student,
    this.company,
  });

  factory Profile.fromJson(Map<String, dynamic> map) {
    return Profile(
      id: map['id'],
      fullname: map['fullname'],
      roles: List<String>.from(map['roles']),
      student: map['student'] != null ? Student.fromJson(map['student']) : null,
      company: map['company'] != null ? Company.fromJson(map['company']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullname': fullname,
      'roles': roles,
      'student': student?.toJson(),
      'company': company?.toJson(),
    };
  }

  String toString() {
    return 'Profile(id: $id, fullname: $fullname, roles: $roles, student: $student, company: $company)';
  }

  void getTypes() {
    print('Profile');
    print('id: ${id.runtimeType}');
    print('fullname: ${fullname.runtimeType}');
    print('roles: ${roles.runtimeType}');
    if (student != null) {
      // student?.getTypes();
    } else {
      company?.getTypes();
    }
    // print('company: ${company?.runtimeType}');
  }
}
