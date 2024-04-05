import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/entity/project_2/project_list.dart';
import 'package:boilerplate/domain/repository/project/project_repository.dart';

class GetCompanyProjectsUseCase extends UseCase<ProjectList, void> {
  final ProjectRepository _projectRepository;

  GetCompanyProjectsUseCase(this._projectRepository);

  @override
  Future<ProjectList> call({required params}) {
    return _projectRepository.getCompanyProjects();
  }
}
