import 'package:boilerplate/core/stores/error/error_store.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/domain/entity/notification/notification.dart';
import 'package:boilerplate/domain/entity/project_2/project_list.dart';
import 'package:boilerplate/domain/usecase/project/get_projects_usecase.dart';
import 'package:mobx/mobx.dart';

import '../../../domain/entity/project_2/project.dart';

part 'notification_store.g.dart';

class NotificationStore = _NotificationStore with _$NotificationStore;

abstract class _NotificationStore with Store {
  _NotificationStore(this._sharedPreferenceHelper, this.errorStore);
  final SharedPreferenceHelper _sharedPreferenceHelper;
  final ErrorStore errorStore;

  static ObservableFuture<List<Noti>?> emptyNotiResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<List<Noti>?> fetchNotifromSharedPref =
      ObservableFuture<List<Noti>?>(emptyNotiResponse);

  @observable
  ObservableList<Noti> notifications = ObservableList<Noti>();

  @observable
  bool success = false;

  @action
  Future getNotifications() async {
    this.notifications = notifications;
    // success = true;
  }

  @action
  void addNotification(Noti noti) {
    notifications.add(noti);
  }

  @action
  refreshNoti() {
    success = false;
    errorStore.errorMessage = "";
    getNotifications();
  }
}
