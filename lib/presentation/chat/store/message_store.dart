import 'dart:developer';

import 'package:boilerplate/core/stores/error/error_store.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/domain/entity/message/message.dart';
import 'package:boilerplate/domain/entity/message/message_list.dart';
import 'package:boilerplate/domain/entity/message/message_user.dart';
import 'package:boilerplate/domain/entity/message/messages.dart';
import 'package:boilerplate/domain/entity/project_2/project.dart';
import 'package:boilerplate/domain/usecase/message/get_all_message_usecase.dart';
import 'package:boilerplate/domain/usecase/message/get_project_message.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

import 'package:mobx/mobx.dart';

part 'message_store.g.dart';

class ObservableMessages {
  @observable
  Messages messages;

  ObservableMessages({required this.messages});
}

class MessageStore = _MessageStore with _$MessageStore;

abstract class _MessageStore with Store {
  _MessageStore(this._getAllMessageUseCase, this._getProjectMessageUseCase,
      this.errorStore);

  final GetAllMessageUseCase _getAllMessageUseCase;
  final GetProjectMessageUseCase _getProjectMessageUseCase;
  final ErrorStore errorStore;
  final SharedPreferenceHelper sharedPreferenceHelper =
      getIt<SharedPreferenceHelper>();
  static ObservableFuture<List<MessageListItem>?> emptyMessageResponse =
      ObservableFuture.value(null);
  static ObservableFuture<List<Message>?> emptyMessageListResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<List<MessageListItem>?> fetchMessageFuture =
      ObservableFuture<List<MessageListItem>?>(emptyMessageResponse);

  @observable
  ObservableFuture<List<Message>?> fetchMessageListFuture =
      ObservableFuture<List<Message>?>(emptyMessageListResponse);

  // @observable
  // Map<int, List<Message>>? messages = {};

  @observable
  int completedMessageLists = 0;

  @observable
  ObservableList<ObservableMessages> messages =
      ObservableList<ObservableMessages>();

  @observable
  ObservableList<MessageListItem> messageList =
      ObservableList<MessageListItem>();

  @observable
  bool success = false;

  @observable
  bool successMessages = false;

  @computed
  bool get loading => success == false;

  @computed
  bool get loadingMessageList =>
      fetchMessageListFuture.status == FutureStatus.pending;

  @action
  Future getMessages() async {
    final token = await sharedPreferenceHelper.authToken;
    final jwt = JWT.decode(token!);
    final myId = jwt.payload['id'];
    final getAllMessageFuture = _getAllMessageUseCase.call(params: null);
    fetchMessageFuture = ObservableFuture(getAllMessageFuture);

    getAllMessageFuture.then((item) {
      if (item.length == 0) {
        success = true;
        return;
      }
      item.forEach((element) {
        messageList.add(element);
      });
      List<Future> futures = [];
      messageList.forEach((element) {
        final getMessageListFuture = _getProjectMessageUseCase.call(
            params: GetProjectMessageParams(
                projectId: element.project.id!,
                receiverId: myId == element.receiver.id
                    ? element.sender.id
                    : element.receiver.id));
        fetchMessageListFuture = ObservableFuture(getMessageListFuture);
        futures.add(getMessageListFuture);
        getMessageListFuture.then((value) {
          messages.add(ObservableMessages(
              messages: Messages(
                  messages: value,
                  projectId: element.project.id!,
                  receiverId: element.receiver.id,
                  senderId: element.sender.id)));

          log("value nè: " +
              element.project.id!.toString() +
              " " +
              value[0].receiver.id.toString() +
              " " +
              value[0].sender.id.toString());
          if (messages.length == messageList.length) {
            success = true;
          }
        });
      });
      log("message list length cout: ${messageList.length.toString()}");
      // success = true;
    }).catchError((error) {
      errorStore.errorMessage = error.toString();
    });
  }

  @action
  int getIndex(int projectId, int receiverId, int senderId) {
    int index = -1;

    messages.forEach((element) {
      if (element.messages.projectId == projectId) {
        final x = element.messages.senderId == senderId &&
            element.messages.receiverId == receiverId;
        final y = element.messages.senderId == receiverId &&
            element.messages.receiverId == senderId;
        if (x || y) {
          index = messages.indexOf(element);
        }
      }
    });
    return index;

    // for (int i = 0; i < this.messages.length; i++) {
    //   if (messages[i].messages.projectId == projectId) {
    //     final x = messages[i].messages.senderId == senderId &&
    //         messages![i].messages.receiverId == receiverId;
    //     final y = messages![i].messages.senderId == receiverId &&
    //         messages![i].messages.receiverId == senderId;
    //     if (x || y) {
    //       index = i;
    //       break;
    //     }
    //   }
    // }
  }

  @action
  int newMessageListItem(MessageUser sender, MessageUser receiver,
      Project project, Message? message) {
    final index = getIndex(
      project.id!,
      receiver.id,
      sender.id,
    );
    log("index từ store: $index");
    if (index == -1) {
      final MessageListItem newMessageListItem = MessageListItem(
          id: 0,
          sender: sender,
          receiver: receiver,
          content: '',
          createdAt: DateTime.now(),
          project: project);
      log("newMessageListItem: " + newMessageListItem.toJson().toString());
      final List<Message> emptyMessage = [];
      if (message != null) {
        emptyMessage.add(message);
      }
      messages.add(ObservableMessages(
          messages: Messages(
              messages: emptyMessage,
              projectId: project.id!,
              receiverId: receiver.id,
              senderId: sender.id)));
      messageList.add(newMessageListItem);
      return getIndex(project.id!, receiver.id, sender.id);
    }
    return index;
  }

  @action
  void addNewMessageToIndex(int index, Message message) {
    messages[index].messages.messages.add(message);
  }

  @action
  receiveMessage(dynamic data) {
    log("data nè " + data.toString());
    final msg = {
      "content": data['content'],
      "senderId": data['senderId'],
      "receiverId": data['receiverId'],
      "projectId": data['projectId'],
      "messageFlag": data['messageFlag'],
    };
    int index =
        getIndex(data['projectId'], data['receiverId'], data['senderId']);
    log("index thêm message: $index");
    if (index != -1) {
      final Message newMessage = Message(
        id: 0,
        content: msg['content'],
        sender: MessageUser(id: msg['senderId'], fullname: ''),
        receiver: MessageUser(id: msg['receiverId'], fullname: ''),
        createdAt: DateTime.now(),
        interview: null,
        messageFlag: msg['messageFlag'],
      );
      messages[index].messages.messages.add(newMessage);

      // messages![index].messages.add(newMessage);
    }
  }

  @action
  refreshMessage() {
    messages = ObservableList<ObservableMessages>();
    // success = false;
    errorStore.errorMessage = "";
    getMessages();
  }
}
