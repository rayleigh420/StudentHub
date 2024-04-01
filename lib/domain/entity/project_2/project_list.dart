import 'package:boilerplate/domain/entity/project_2/project.dart';

class ProjectList {
  final List<Project>? projects;

  ProjectList({this.projects});

  factory ProjectList.fromJson(List<dynamic> json) {
    List<Project> projects = <Project>[];
    projects = json.map((project) => Project.fromJson(project)).toList();
    return ProjectList(projects: projects);
  }
}
