import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/entity/project_2/project_list.dart';
import 'package:boilerplate/domain/repository/project/project_repository.dart';
 class ParamsInput {
  final int id;
  ParamsInput(this.id);
  }
class DeleteProjectsUseCase extends UseCase<bool, ParamsInput> {
  final ProjectRepository _projectRepository;

  DeleteProjectsUseCase(this._projectRepository);

  @override
  Future<bool> call({required params}) {
    return _projectRepository.deleteProject(params.id);
  }
}
