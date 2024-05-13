

import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/data/network/apis/resume/resume_api.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/domain/repository/resume/resume_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResumeRepositoryImpl implements ResumeRepository {
  final ResumeApi _resumeApi;
  final SharedPreferenceHelper _sharedPreferenceHelper;

  ResumeRepositoryImpl(
    this._resumeApi,
    this._sharedPreferenceHelper,
  );

  @override
  Future<bool> postResume(String filePath, String fileName) async {
    try {
     
      final token = await _sharedPreferenceHelper.authToken;
      int? studentId = await _sharedPreferenceHelper.currentStudentId;
      bool res = await _resumeApi.postResume(studentId!, token!, filePath, fileName);
      return res;
    } catch (e) {
      throw e;
    }
  }
  Future<String> getResume() async {
    try {
      final token = await _sharedPreferenceHelper.authToken;
      int? studentId = await _sharedPreferenceHelper.currentStudentId;
      String res = await _resumeApi.getResume(studentId!, token!);
       String fileName = Uri.parse(res).pathSegments.last.split("-").last;
        print(fileName); // Output: abc.pdf
      return fileName;
    } catch (e) {
      throw e;
    }
  }



   
   
}