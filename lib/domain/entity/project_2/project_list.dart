import 'package:boilerplate/domain/entity/favorite/favorite_project.dart';
import 'package:boilerplate/domain/entity/project_2/project.dart';

class ProjectList {
  final List<Project>? projects;

  ProjectList({this.projects});

  factory ProjectList.fromJson(List<dynamic> json) {
    List<Project> projects = <Project>[];
    projects = json.map((project) => Project.fromJson(project)).toList();
    return ProjectList(projects: projects);
  }

  factory ProjectList.fromJson_project(List<dynamic> json) {
    List<Project> projects = <Project>[];
    projects = json
        .map((project) => FavoriteProject.fromJson(project).project!)
        .toList();
    return ProjectList(projects: projects);
  }
}
