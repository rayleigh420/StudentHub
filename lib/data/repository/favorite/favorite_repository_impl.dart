import 'package:boilerplate/data/network/apis/favorite/favorite_api.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/domain/repository/favorite/favorite_repository.dart';

class FavoriteRepositoryImpl extends FavoriteRepository {
  final FavoriteApi _favoriteApi;
  final SharedPreferenceHelper _sharedPrefsHelper;

  FavoriteRepositoryImpl(this._favoriteApi, this._sharedPrefsHelper);

  @override
  Future<bool> addFavorite(int projectId, int disableFlag) async {
    try {
      int? studentId = await _sharedPrefsHelper.currentStudentId;
      bool result =
          await _favoriteApi.addFavorite(studentId!, projectId, disableFlag);
      return result;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
