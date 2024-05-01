


import 'package:boilerplate/data/network/apis/transcript/transcript_api.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/domain/repository/transcript/transcript_repository.dart';


class TranscriptRepositoryImpl implements TranscriptRepository {
  final TranscriptApi _transcriptApi;
  final SharedPreferenceHelper _sharedPreferenceHelper;

  TranscriptRepositoryImpl(
    this._transcriptApi,
    this._sharedPreferenceHelper,
  );

  @override
  Future<bool> postTranscript(String filePath, String fileName) async {
    try {
     
      final token = await _sharedPreferenceHelper.authToken;
      int? studentId = await _sharedPreferenceHelper.currentStudentId;
      bool res = await _transcriptApi.postTranscript(studentId!, token!, filePath, fileName);
      return res;
    } catch (e) {
      throw e;
    }
  }


   
   
}