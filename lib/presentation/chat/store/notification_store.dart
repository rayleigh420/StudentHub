import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/core/stores/error/error_store.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/domain/entity/notification/notification.dart';
import 'package:boilerplate/domain/entity/project_2/project_list.dart';
import 'package:boilerplate/domain/usecase/noti/get_noti_usecase.dart';
import 'package:boilerplate/domain/usecase/project/get_projects_usecase.dart';
import 'package:mobx/mobx.dart';

import '../../../domain/entity/project_2/project.dart';

part 'notification_store.g.dart';

class NotificationStore = _NotificationStore with _$NotificationStore;

abstract class _NotificationStore with Store {
  _NotificationStore(this._sharedPreferenceHelper, this.errorStore,
      this._dioClient, this._getNotiUseCase);
  final SharedPreferenceHelper _sharedPreferenceHelper;
  final ErrorStore errorStore;
  final DioClient _dioClient;
  final GetNotiUseCase _getNotiUseCase;

  static ObservableFuture<List<Noti>?> emptyNotiResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<List<Noti>?> fetchNoti =
      ObservableFuture<List<Noti>?>(emptyNotiResponse);

  @observable
  ObservableList<Noti> notifications = ObservableList<Noti>();

  @observable
  bool success = false;

  @observable
  bool doneRefresh = false;

  @action
  Future getNotifications() async {
    final defaultId = await _sharedPreferenceHelper.getDefaultId();
    // final defaultToken = await _sharedPreferenceHelper.authToken;
    fetchNoti = ObservableFuture(_getNotiUseCase.call(params: defaultId!));
    fetchNoti.then((value) {
      notifications = ObservableList<Noti>.of(value!);
      success = true;
      doneRefresh = true;
    }).catchError((error) {
      notifications = ObservableList<Noti>();
      success = true;
      doneRefresh = true;
    });
  }

  @action
  void addNotification(Noti noti) {
    notifications.add(noti);
  }

  @action
  refreshNoti() {
    success = false;
    doneRefresh = false;
    errorStore.errorMessage = "";
    getNotifications();
  }

  @action
  clearStoreData() {
    notifications.clear();
    success = false;
    doneRefresh = false;
  }
}
