import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/entity/project_2/project.dart';

import 'package:boilerplate/domain/entity/project_2/project_list.dart';
import 'package:boilerplate/domain/repository/project/project_repository.dart';

class PostcompanyProjectParams {
  final String title;
  final int scopeType;
  final int studentNumber;
  final String describeProject;

  PostcompanyProjectParams(
      {required this.title,
      required this.scopeType,
      required this.studentNumber,
      required this.describeProject});
}

class PostCompanyProjectsUseCase
    extends UseCase<Project, PostcompanyProjectParams> {
  final ProjectRepository _projectRepository;

  PostCompanyProjectsUseCase(this._projectRepository);

  @override
  Future<Project> call({required params}) {
    return _projectRepository.postProject(params.title, params.scopeType,
        params.studentNumber, params.describeProject);
  }
}
