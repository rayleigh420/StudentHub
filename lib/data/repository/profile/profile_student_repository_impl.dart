import 'package:boilerplate/data/network/apis/profile/profile_api.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/domain/repository/profile/profile_student_repository.dart';

class ProfileStudentRepositoryImpl extends ProfileStudentRepository {
  final ProfileApi _profileApi;
  final SharedPreferenceHelper _sharedPrefsHelper;
  ProfileStudentRepositoryImpl(this._profileApi, this._sharedPrefsHelper);

  @override
  Future<bool> createProfileStudent(
    int techStackId,
    List<String> skillSets,
  ) async {
    try {
      final token =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTUxLCJmdWxsbmFtZSI6IkR1eSIsImVtYWlsIjoibG5kdXkyMEBjbGMuZml0dXMuZWR1LnZuIiwicm9sZXMiOlsiMCJdLCJpYXQiOjE3MTIzNzQ3OTYsImV4cCI6MTcxMzU4NDM5Nn0.cMdWk3lwVr4WwBouoMsATJpUEYdnoNXFSkmwsV8Gly0';
      // await _sharedPrefsHelper.authToken;

      final res = await _profileApi.createProfileStudent(
        techStackId,
        skillSets,
        token!,
      );
      return res;
    } catch (e) {
      throw new Exception(e.toString());
    }
  }
}
