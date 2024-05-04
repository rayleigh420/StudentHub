import 'package:boilerplate/data/network/apis/profile/profile_api.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/domain/repository/profile/profile_company_repository.dart';

class ProfileCompanyRepositoryImpl extends ProfileCompanyRepository {
  final ProfileApi _profileApi;
  final SharedPreferenceHelper _sharedPrefsHelper;
  ProfileCompanyRepositoryImpl(this._profileApi, this._sharedPrefsHelper);

  @override
  Future<bool> createProfileCompany(
    String companyName,
    int size,
    String website,
    String description,
  ) async {
    try {
      final token = await _sharedPrefsHelper.authToken;

      final res = await _profileApi.createProfileCompany(
        companyName,
        size,
        website,
        description,
        token!,
      );
      return res;
    } catch (e) {
      throw new Exception(e.toString());
    }
  }
}
