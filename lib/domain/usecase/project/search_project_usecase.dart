import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/entity/project_2/project_list.dart';
import 'package:boilerplate/domain/repository/project/project_repository.dart';

class SearchProjectParams {
  final String? title;
  final int? projectScopeFlag;
  final int? numberOfStudents;
  final int? proposalsLessThan;
  final int? page;
  final int? perPage;

  SearchProjectParams(
      {this.title,
      this.projectScopeFlag,
      this.numberOfStudents,
      this.proposalsLessThan,
      this.page,
      this.perPage});
}

class SearchProjectsUseCase extends UseCase<ProjectList, SearchProjectParams> {
  final ProjectRepository _projectRepository;

  SearchProjectsUseCase(this._projectRepository);

  @override
  Future<ProjectList> call({required params}) {
    return _projectRepository.searchProject(
        params.title,
        params.projectScopeFlag,
        params.numberOfStudents,
        params.proposalsLessThan,
        params.page,
        params.perPage);
  }
}
