// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MessageStore on _MessageStore, Store {
  Computed<List<InterviewItem>>? _$interviewsComputed;

  @override
  List<InterviewItem> get interviews => (_$interviewsComputed ??=
          Computed<List<InterviewItem>>(() => super.interviews,
              name: '_MessageStore.interviews'))
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

  late final _$messagesAtom =
      Atom(name: '_MessageStore.messages', context: context);

  @override
  ObservableList<ObservableMessages> get messages {
    _$messagesAtom.reportRead();
    return super.messages;
  }

  @override
  set messages(ObservableList<ObservableMessages> value) {
    _$messagesAtom.reportWrite(value, super.messages, () {
      super.messages = value;
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
  int getIndex(int projectId, int receiverId, int senderId) {
    final _$actionInfo = _$_MessageStoreActionController.startAction(
        name: '_MessageStore.getIndex');
    try {
      return super.getIndex(projectId, receiverId, senderId);
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
  int newMessageListItem(MessageUser sender, MessageUser receiver,
      Project project, Message? message) {
    final _$actionInfo = _$_MessageStoreActionController.startAction(
        name: '_MessageStore.newMessageListItem');
    try {
      return super.newMessageListItem(sender, receiver, project, message);
    } finally {
      _$_MessageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addNewMessageToIndex(int index, Message message) {
    final _$actionInfo = _$_MessageStoreActionController.startAction(
        name: '_MessageStore.addNewMessageToIndex');
    try {
      return super.addNewMessageToIndex(index, message);
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
  dynamic updateInterview(int index, Interview interview) {
    final _$actionInfo = _$_MessageStoreActionController.startAction(
        name: '_MessageStore.updateInterview');
    try {
      return super.updateInterview(index, interview);
    } finally {
      _$_MessageStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic updateInterviewCancelled(int index, int messageId) {
    final _$actionInfo = _$_MessageStoreActionController.startAction(
        name: '_MessageStore.updateInterviewCancelled');
    try {
      return super.updateInterviewCancelled(index, messageId);
    } finally {
      _$_MessageStoreActionController.endAction(_$actionInfo);
    }
  }

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
fetchMessageFuture: ${fetchMessageFuture},
fetchMessageListFuture: ${fetchMessageListFuture},
completedMessageLists: ${completedMessageLists},
messages: ${messages},
messageList: ${messageList},
success: ${success},
doneReloading: ${doneReloading},
successMessages: ${successMessages},
interviews: ${interviews},
loading: ${loading},
loadingMessageList: ${loadingMessageList}
    ''';
  }
}
