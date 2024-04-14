import 'package:boilerplate/domain/entity/project_2/project_list.dart';

abstract class FavoriteRepository {
  Future<ProjectList> getFavoriteProject();
  Future<bool> addFavorite(int projectId, int disableFlag);
}
