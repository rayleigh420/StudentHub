import 'dart:async';
import 'dart:developer';

import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/network/rest_client.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/domain/entity/post/post_list.dart';
import 'package:boilerplate/domain/entity/user/user.dart';

class AuthApi {
  // dio instance
  final DioClient _dioClient;
  
  // injecting dio instance
  AuthApi(this._dioClient);

  /// Returns list of post in response
  Future<PostList> getPosts() async {
    try {
      final res = await _dioClient.dio.get(Endpoints.getPosts);
      return PostList.fromJson(res.data);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<String> logIn(String email, String password) async {
    try {
      final res = await _dioClient.dio.post(Endpoints.logIn, data: {
        'email': email,
        'password': password,
      });
      log("cout<<login response");
      log(res.data.toString());
      return res.data['result']['token'].toString();
    } catch (e) {
      throw new Exception(e.toString());
    }
  }

  Future<String> signUp(String email, String password, String fullName,
      int role) async {
    try {
      final res = await _dioClient.dio.post(Endpoints.signUp, data: {
        'email': email,
        'password': password,
        'fullname': fullName,
        'role': role,
      });
      log("cout<<signup response");
      log(res.statusCode.toString());
      if (res.statusCode.toString() == "201") {
        final String token = await logIn(email, password);
        return token;
      } else
        throw Exception("Failed to sign up");
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
  Future<String> testToken() async {
    try { 
      final token = await getIt<SharedPreferenceHelper>().authToken;
      final authToken = "Bearer ${token}";
      log(token.toString());
      log("loonf thais dit me m");
      return "1";
    } catch (e) {
      throw new Exception(e.toString());
    }
  }
  /// sample api call with default rest client
//  Future<PostsList> getPosts() {
//
//    return _restClient
//        .get(Endpoints.getPosts)
//        .then((dynamic res) => PostsList.fromJson(res))
//        .catchError((error) => throw NetworkException(message: error));
//  }
}
