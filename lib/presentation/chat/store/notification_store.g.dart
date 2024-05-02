// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$NotificationStore on _NotificationStore, Store {
  late final _$fetchNotifromSharedPrefAtom = Atom(
      name: '_NotificationStore.fetchNotifromSharedPref', context: context);

  @override
  ObservableFuture<List<Noti>?> get fetchNotifromSharedPref {
    _$fetchNotifromSharedPrefAtom.reportRead();
    return super.fetchNotifromSharedPref;
  }

  @override
  set fetchNotifromSharedPref(ObservableFuture<List<Noti>?> value) {
    _$fetchNotifromSharedPrefAtom
        .reportWrite(value, super.fetchNotifromSharedPref, () {
      super.fetchNotifromSharedPref = value;
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
  String toString() {
    return '''
fetchNotifromSharedPref: ${fetchNotifromSharedPref},
notifications: ${notifications},
success: ${success}
    ''';
  }
}
