import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/repository/favorite/favorite_repository.dart';

class AddProjectParams {
  final int projectId;
  final int disableFlag;

  AddProjectParams({required this.projectId, required this.disableFlag});
}

class AddFavoriteByStudentIdUseCase extends UseCase<bool, AddProjectParams> {
  final FavoriteRepository _favoriteRepository;

  AddFavoriteByStudentIdUseCase(this._favoriteRepository);

  @override
  Future<bool> call({required params}) {
    return _favoriteRepository.addFavorite(
        params.projectId, params.disableFlag);
  }
}
