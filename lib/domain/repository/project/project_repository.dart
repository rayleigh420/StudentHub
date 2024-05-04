import 'package:boilerplate/domain/entity/project_2/project.dart';
import 'package:boilerplate/domain/entity/project_2/project_list.dart';

abstract class ProjectRepository {
  Future<ProjectList> getProjects();
  Future<ProjectList> getCompanyProjects();
  Future<Project> postProject(
      String title, int scopeType, int studentNumber, String describeProject);
  Future<bool> deleteProject(int id);
  Future<Project> updateProject(Project project);
  Future<ProjectList> searchProject(String? title, int? projectScopeFlag,
      int? numberOfStudents, int? proposalsLessThan);
}
