import 'dart:async';
import 'dart:developer';

import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/core/data/network/dio/interceptors/auth_interceptor.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/domain/entity/profile/company.dart';
import 'package:boilerplate/domain/entity/profile/profile.dart';
import 'package:dio/dio.dart';

class ProfileApi {
  // dio instance
  final DioClient _dioClient;

  // injecting dio instance
  ProfileApi(this._dioClient);

  Future<bool> createProfileCompany(String companyName, int size,
      String website, String description, String token) async {
    try {
      // final token = await getIt<SharedPreferenceHelper>().authToken;
      final authToken = "Bearer ${token}";

      log(token.toString());
      final res = await _dioClient.dio.post(Endpoints.createProfileCompany,
          data: {
            'companyName': companyName,
            'size': size,
            'website': website,
            'description': description,
          },
          options: Options(
            headers: {
              'Authorization': authToken,
            },
          ));
      log("cout<<createProfileCompany response");
      log(res.data.toString());
      return true;
    } catch (e) {
      throw new Exception(e.toString());
    }
  }

  Future<bool> createProfileStudent(
      int techStackId, List<String> skillSets, String token) async {
    try {
      // final token = await getIt<SharedPreferenceHelper>().authToken;
      final authToken = "Bearer ${token}";

      log(token.toString());
      final res = await _dioClient.dio.post(Endpoints.createProfileStudent,
          data: {
            'techStackId': techStackId,
            'skillSets': skillSets,
          },
          options: Options(
            headers: {
              'Authorization': authToken,
            },
          ));
      log("cout<<createProfileStudent response");
      log(res.data.toString());
      return true;
    } catch (e) {
      throw new Exception(e.toString());
    }
  }

  Future<Profile> getProfile() async {
    try {
      // final authToken = "Bearer ${token}";
      print("Auth/me");
      final res = await _dioClient.dio.get(Endpoints.getProfile);
      log("cout<<getProfile response");
      print(res.data["result"].toString());
      return Profile.fromJson(res.data["result"]);
    } catch (e) {
      log(e.toString());
      throw e;
      // throw new Exception(e.toString());
    }
  }
  Future <Company> updateProfileCompany(String companyName, int size,
      String website, String description,int id, String token) async {
    try {
      // final token = await getIt<SharedPreferenceHelper>().authToken;
      final authToken = "Bearer ${token}";

      log(token.toString());
      final res = await _dioClient.dio.put(Endpoints.updateProfileCompany+ "/${id}",
          data: {
            'companyName': companyName,
            'size': size,
            'website': website,
            'description': description,
          },
          options: Options(
            headers: {
              'Authorization': authToken,
            },
          ));
      log("cout<<updateProfileCompany response");
      log(res.data.toString());
      return Company.fromJson(res.data["result"]);
    } catch (e) {
      throw new Exception(e.toString());
    }
  }

}
