import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/entity/project_2/project.dart';
import 'package:boilerplate/domain/repository/project/project_repository.dart';

class UpdateProjectsUseCase extends UseCase<Project, Project> {
  final ProjectRepository _projectRepository;

  UpdateProjectsUseCase(this._projectRepository);

  @override
  Future<Project> call({required params}) {
    return _projectRepository.updateProject(params);
  }
}
