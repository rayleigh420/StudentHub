import 'package:boilerplate/domain/entity/project_2/project_list.dart';

abstract class ProjectRepository {
  Future<ProjectList> getProjects();
}
