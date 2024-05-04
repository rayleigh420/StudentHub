import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/entity/project_2/project_list.dart';
import 'package:boilerplate/domain/repository/favorite/favorite_repository.dart';

class GetFavoriteByStudentIdUseCase extends UseCase<ProjectList, void> {
  final FavoriteRepository _favoriteRepository;

  GetFavoriteByStudentIdUseCase(this._favoriteRepository);

  @override
  Future<ProjectList> call({required params}) {
    return _favoriteRepository.getFavoriteProject();
  }
}
