// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$NotificationStore on _NotificationStore, Store {
  late final _$fetchNotiAtom =
      Atom(name: '_NotificationStore.fetchNoti', context: context);

  @override
  ObservableFuture<List<Noti>?> get fetchNoti {
    _$fetchNotiAtom.reportRead();
    return super.fetchNoti;
  }

  @override
  set fetchNoti(ObservableFuture<List<Noti>?> value) {
    _$fetchNotiAtom.reportWrite(value, super.fetchNoti, () {
      super.fetchNoti = value;
    });
  }

  late final _$notificationsAtom =
      Atom(name: '_NotificationStore.notifications', context: context);

  @override
  ObservableList<Noti> get notifications {
    _$notificationsAtom.reportRead();
    return super.notifications;
  }

  @override
  set notifications(ObservableList<Noti> value) {
    _$notificationsAtom.reportWrite(value, super.notifications, () {
      super.notifications = value;
    });
  }

  late final _$successAtom =
      Atom(name: '_NotificationStore.success', context: context);

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  late final _$doneRefreshAtom =
      Atom(name: '_NotificationStore.doneRefresh', context: context);

  @override
  bool get doneRefresh {
    _$doneRefreshAtom.reportRead();
    return super.doneRefresh;
  }

  @override
  set doneRefresh(bool value) {
    _$doneRefreshAtom.reportWrite(value, super.doneRefresh, () {
      super.doneRefresh = value;
    });
  }

  late final _$getNotificationsAsyncAction =
      AsyncAction('_NotificationStore.getNotifications', context: context);

  @override
  Future<dynamic> getNotifications() {
    return _$getNotificationsAsyncAction.run(() => super.getNotifications());
  }

  late final _$_NotificationStoreActionController =
      ActionController(name: '_NotificationStore', context: context);

  @override
  void addNotification(Noti noti) {
    final _$actionInfo = _$_NotificationStoreActionController.startAction(
        name: '_NotificationStore.addNotification');
    try {
      return super.addNotification(noti);
    } finally {
      _$_NotificationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic refreshNoti() {
    final _$actionInfo = _$_NotificationStoreActionController.startAction(
        name: '_NotificationStore.refreshNoti');
    try {
      return super.refreshNoti();
    } finally {
      _$_NotificationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic clearStoreData() {
    final _$actionInfo = _$_NotificationStoreActionController.startAction(
        name: '_NotificationStore.clearStoreData');
    try {
      return super.clearStoreData();
    } finally {
      _$_NotificationStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
fetchNoti: ${fetchNoti},
notifications: ${notifications},
success: ${success},
doneRefresh: ${doneRefresh}
    ''';
  }
}
