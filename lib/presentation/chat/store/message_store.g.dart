// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MessageStore on _MessageStore, Store {
  Computed<List<InterviewItem>>? _$interviews2Computed;

  @override
  List<InterviewItem> get interviews2 => (_$interviews2Computed ??=
          Computed<List<InterviewItem>>(() => super.interviews2,
              name: '_MessageStore.interviews2'))
      .value;
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??=
          Computed<bool>(() => super.loading, name: '_MessageStore.loading'))
      .value;
  Computed<bool>? _$loadingMessageListComputed;

  @override
  bool get loadingMessageList => (_$loadingMessageListComputed ??=
          Computed<bool>(() => super.loadingMessageList,
              name: '_MessageStore.loadingMessageList'))
      .value;

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

  late final _$completedMessageListsAtom =
      Atom(name: '_MessageStore.completedMessageLists', context: context);

  @override
  int get completedMessageLists {
    _$completedMessageListsAtom.reportRead();
    return super.completedMessageLists;
  }

  @override
  set completedMessageLists(int value) {
    _$completedMessageListsAtom.reportWrite(value, super.completedMessageLists,
        () {
      super.completedMessageLists = value;
    });
  }

  late final _$messageListAtom =
      Atom(name: '_MessageStore.messageList', context: context);

  @override
  ObservableList<Observable<MessageListItem>> get messageList {
    _$messageListAtom.reportRead();
    return super.messageList;
  }

  @override
  set messageList(ObservableList<Observable<MessageListItem>> value) {
    _$messageListAtom.reportWrite(value, super.messageList, () {
      super.messageList = value;
    });
  }

  late final _$messages2Atom =
      Atom(name: '_MessageStore.messages2', context: context);

  @override
  ObservableList<Messages> get messages2 {
    _$messages2Atom.reportRead();
    return super.messages2;
  }

  @override
  set messages2(ObservableList<Messages> value) {
    _$messages2Atom.reportWrite(value, super.messages2, () {
      super.messages2 = value;
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

  late final _$doneReloadingAtom =
      Atom(name: '_MessageStore.doneReloading', context: context);

  @override
  bool get doneReloading {
    _$doneReloadingAtom.reportRead();
    return super.doneReloading;
  }

  @override
  set doneReloading(bool value) {
    _$doneReloadingAtom.reportWrite(value, super.doneReloading, () {
      super.doneReloading = value;
    });
  }

  late final _$successMessagesAtom =
      Atom(name: '_MessageStore.successMessages', context: context);

  @override
  bool get successMessages {
    _$successMessagesAtom.reportRead();
    return super.successMessages;
  }

  @override
  set successMessages(bool value) {
    _$successMessagesAtom.reportWrite(value, super.successMessages, () {
      super.successMessages = value;
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
  int getIndex2(int projectId, int receiverId, int senderId) {
    final _$actionInfo = _$_MessageStoreActionController.startAction(
        name: '_MessageStore.getIndex2');
    try {
      return super.getIndex2(projectId, receiverId, senderId);
    } finally {
      _$_MessageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  int getIndexMessageList(int projectId, int receiverId, int senderId) {
    final _$actionInfo = _$_MessageStoreActionController.startAction(
        name: '_MessageStore.getIndexMessageList');
    try {
      return super.getIndexMessageList(projectId, receiverId, senderId);
    } finally {
      _$_MessageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  int newMessageListItem2(MessageUser sender, MessageUser receiver,
      Project project, Message? message) {
    final _$actionInfo = _$_MessageStoreActionController.startAction(
        name: '_MessageStore.newMessageListItem2');
    try {
      return super.newMessageListItem2(sender, receiver, project, message);
    } finally {
      _$_MessageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addNewMessageToIndex2(int index, Message message) {
    final _$actionInfo = _$_MessageStoreActionController.startAction(
        name: '_MessageStore.addNewMessageToIndex2');
    try {
      return super.addNewMessageToIndex2(index, message);
    } finally {
      _$_MessageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateMessageListTitle(int index, String title) {
    final _$actionInfo = _$_MessageStoreActionController.startAction(
        name: '_MessageStore.updateMessageListTitle');
    try {
      return super.updateMessageListTitle(index, title);
    } finally {
      _$_MessageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Interview getInterview(int index, int interviewId) {
    final _$actionInfo = _$_MessageStoreActionController.startAction(
        name: '_MessageStore.getInterview');
    try {
      return super.getInterview(index, interviewId);
    } finally {
      _$_MessageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateInterview2(int index, dynamic interviewData) {
    final _$actionInfo = _$_MessageStoreActionController.startAction(
        name: '_MessageStore.updateInterview2');
    try {
      return super.updateInterview2(index, interviewData);
    } finally {
      _$_MessageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateInterviewCancelled2(int index, int interviewId) {
    final _$actionInfo = _$_MessageStoreActionController.startAction(
        name: '_MessageStore.updateInterviewCancelled2');
    try {
      return super.updateInterviewCancelled2(index, interviewId);
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
  dynamic clearStoreData() {
    final _$actionInfo = _$_MessageStoreActionController.startAction(
        name: '_MessageStore.clearStoreData');
    try {
      return super.clearStoreData();
    } finally {
      _$_MessageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
fetchMessageFuture: ${fetchMessageFuture},
fetchMessageListFuture: ${fetchMessageListFuture},
completedMessageLists: ${completedMessageLists},
messageList: ${messageList},
messages2: ${messages2},
success: ${success},
doneReloading: ${doneReloading},
successMessages: ${successMessages},
interviews2: ${interviews2},
loading: ${loading},
loadingMessageList: ${loadingMessageList}
    ''';
  }
}
