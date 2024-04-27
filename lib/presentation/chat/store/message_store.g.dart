// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MessageStore on _MessageStore, Store {
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??=
          Computed<bool>(() => super.loading, name: '_MessageStore.loading'))
      .value;

  late final _$initSocketAtom =
      Atom(name: '_MessageStore.initSocket', context: context);

  @override
  bool get initSocket {
    _$initSocketAtom.reportRead();
    return super.initSocket;
  }

  @override
  set initSocket(bool value) {
    _$initSocketAtom.reportWrite(value, super.initSocket, () {
      super.initSocket = value;
    });
  }

  late final _$fetchMessageFutureAtom =
      Atom(name: '_MessageStore.fetchMessageFuture', context: context);

  @override
  ObservableFuture<List<MessageListItem>?> get fetchMessageFuture {
    _$fetchMessageFutureAtom.reportRead();
    return super.fetchMessageFuture;
  }

  @override
  set fetchMessageFuture(ObservableFuture<List<MessageListItem>?> value) {
    _$fetchMessageFutureAtom.reportWrite(value, super.fetchMessageFuture, () {
      super.fetchMessageFuture = value;
    });
  }

  late final _$fetchMessageListFutureAtom =
      Atom(name: '_MessageStore.fetchMessageListFuture', context: context);

  @override
  ObservableFuture<List<Message>?> get fetchMessageListFuture {
    _$fetchMessageListFutureAtom.reportRead();
    return super.fetchMessageListFuture;
  }

  @override
  set fetchMessageListFuture(ObservableFuture<List<Message>?> value) {
    _$fetchMessageListFutureAtom
        .reportWrite(value, super.fetchMessageListFuture, () {
      super.fetchMessageListFuture = value;
    });
  }

  late final _$messagesAtom =
      Atom(name: '_MessageStore.messages', context: context);

  @override
  List<Messages>? get messages {
    _$messagesAtom.reportRead();
    return super.messages;
  }

  @override
  set messages(List<Messages>? value) {
    _$messagesAtom.reportWrite(value, super.messages, () {
      super.messages = value;
    });
  }

  late final _$messageListAtom =
      Atom(name: '_MessageStore.messageList', context: context);

  @override
  List<MessageListItem>? get messageList {
    _$messageListAtom.reportRead();
    return super.messageList;
  }

  @override
  set messageList(List<MessageListItem>? value) {
    _$messageListAtom.reportWrite(value, super.messageList, () {
      super.messageList = value;
    });
  }

  late final _$successAtom =
      Atom(name: '_MessageStore.success', context: context);

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

  late final _$getMessagesAsyncAction =
      AsyncAction('_MessageStore.getMessages', context: context);

  @override
  Future<dynamic> getMessages() {
    return _$getMessagesAsyncAction.run(() => super.getMessages());
  }

  late final _$_MessageStoreActionController =
      ActionController(name: '_MessageStore', context: context);

  @override
  dynamic receiveMessage(dynamic data) {
    final _$actionInfo = _$_MessageStoreActionController.startAction(
        name: '_MessageStore.receiveMessage');
    try {
      return super.receiveMessage(data);
    } finally {
      _$_MessageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic refreshMessage() {
    final _$actionInfo = _$_MessageStoreActionController.startAction(
        name: '_MessageStore.refreshMessage');
    try {
      return super.refreshMessage();
    } finally {
      _$_MessageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
initSocket: ${initSocket},
fetchMessageFuture: ${fetchMessageFuture},
fetchMessageListFuture: ${fetchMessageListFuture},
messages: ${messages},
messageList: ${messageList},
success: ${success},
loading: ${loading}
    ''';
  }
}
