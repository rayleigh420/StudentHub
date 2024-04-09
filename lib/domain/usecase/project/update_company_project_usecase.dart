import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/entity/project_2/project.dart';
import 'package:boilerplate/domain/repository/project/project_repository.dart';
 class ParamsInput {
  final int id;
  final int typeFlag;
  ParamsInput(this.id, this.typeFlag);
  }
class UpdateProjectsUseCase extends UseCase<Project, ParamsInput> {
  final ProjectRepository _projectRepository;

  UpdateProjectsUseCase(this._projectRepository);

  @override
  Future<Project> call({required params}) {
    return _projectRepository.updateProject(params.id, params.typeFlag);
  }
}
