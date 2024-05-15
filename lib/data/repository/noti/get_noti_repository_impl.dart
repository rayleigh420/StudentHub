import 'dart:developer';

import 'package:boilerplate/data/network/apis/noti/noti_api.dart';
import 'package:boilerplate/data/network/apis/project/project_api.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/domain/entity/notification/notification.dart';
import 'package:boilerplate/domain/entity/project_2/project.dart';
import 'package:boilerplate/domain/entity/project_2/project_list.dart';
import 'package:boilerplate/domain/repository/noti/noti_repository.dart';
import 'package:boilerplate/domain/repository/project/project_repository.dart';

class NotiRepositoryImpl extends NotiRepository {
  final NotiApi _notiApi;
  NotiRepositoryImpl(this._notiApi);

  @override
  Future<List<Noti>> getNoti(int id) async {
    try {
      return await _notiApi.getNotifications(id);
    } catch (e) {
      log("error");
      log(e.toString());
      throw new Exception(e.toString());
    }
  }
}
