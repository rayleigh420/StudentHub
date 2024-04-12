import 'package:boilerplate/domain/entity/project_2/project.dart';

class FavoriteProject {
  final Project? project;

  FavoriteProject({this.project});

  factory FavoriteProject.fromJson(Map<String, dynamic> json) {
    Project project = Project.fromJson(json['project']);
    project.isFavorite = true;
    return FavoriteProject(
      project: project,
    );
  }
}
