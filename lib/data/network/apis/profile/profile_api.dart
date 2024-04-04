import 'dart:async';
import 'dart:developer';

import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/core/data/network/dio/interceptors/auth_interceptor.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/di/service_locator.dart';
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

  Future<Profile> getProfile() async {
    try {
      // final authToken = "Bearer ${token}";
      final res = await _dioClient.dio.get(Endpoints.getProfile);
      log("cout<<getProfile response");
      log(res.data.toString());
      return Profile.fromJson(res.data);
    } catch (e) {
      throw new Exception(e.toString());
    }
  }
}
