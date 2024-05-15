import 'dart:developer';

import 'package:boilerplate/core/stores/error/error_store.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/domain/entity/message/interview.dart';
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

class ObservableListMessage {}

class InterviewItem {
  Interview interview;
  int projectId;
  int receiverId;
  int senderId;

  InterviewItem(
      {required this.interview,
      required this.projectId,
      required this.receiverId,
      required this.senderId});
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

  // @observable
  // ObservableList<ObservableMessages> messages =
  //     ObservableList<ObservableMessages>();

  @observable
  ObservableList<Observable<MessageListItem>> messageList =
      ObservableList<Observable<MessageListItem>>();

  @observable
  ObservableList<Messages> messages2 = ObservableList<Messages>();

  @computed
  List<InterviewItem> get interviews2 {
    List<InterviewItem> result = [];
    for (var observableMessages in this.messages2) {
      if (observableMessages.messages.length > 0) {
        for (var message in observableMessages.messages) {
          if (message.interview != null &&
              message.interview!.disableFlag == 0) {
            result.add(InterviewItem(
                interview: message.interview!,
                projectId: observableMessages.projectId,
                receiverId: observableMessages.receiverId,
                senderId: observableMessages.senderId));
          }
        }
      }
    }
    return result;
  }

  @observable
  bool success = false;

  @observable
  bool doneReloading = false;

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
        doneReloading = true;
        return;
      }
      item.forEach((element) {
        messageList.add(Observable<MessageListItem>(element));
      });
      List<Future> futures = [];
      messageList.forEach((element) {
        final getMessageListFuture = _getProjectMessageUseCase.call(
            params: GetProjectMessageParams(
                projectId: element.value.project.id!,
                receiverId: myId == element.value.receiver.id
                    ? element.value.sender.id
                    : element.value.receiver.id));
        fetchMessageListFuture = ObservableFuture(getMessageListFuture);
        futures.add(getMessageListFuture);
        getMessageListFuture.then((value) {
          messages2.add(Messages(
              messages: ObservableList.of(value),
              projectId: element.value.project.id!,
              receiverId: element.value.receiver.id,
              senderId: element.value.sender.id));

          log("value nè: " +
              element.value.project.id!.toString() +
              " " +
              value[0].receiver.id.toString() +
              " " +
              value[0].sender.id.toString());
          if (messages2.length == messageList.length) {
            success = true;
            doneReloading = true;
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
  int getIndex2(int projectId, int receiverId, int senderId) {
    int index = -1;
    for (int i = 0; i < this.messages2.length; i++) {
      if (messages2[i].projectId == projectId) {
        final x = messages2[i].senderId == senderId &&
            messages2[i].receiverId == receiverId;
        final y = messages2[i].senderId == receiverId &&
            messages2[i].receiverId == senderId;
        if (x || y) {
          index = i;
          break;
        }
      }
    }

    return index;
  }

  @action
  int getIndexMessageList(int projectId, int receiverId, int senderId) {
    int index = -1;
    for (int i = 0; i < this.messageList.length; i++) {
      if (messageList[i].value.project.id == projectId) {
        final x = messageList[i].value.sender.id == senderId &&
            messageList[i].value.receiver.id == receiverId;
        final y = messageList[i].value.sender.id == receiverId &&
            messageList[i].value.receiver.id == senderId;
        if (x || y) {
          index = i;
          break;
        }
      }
    }
    return index;
  }

  @action
  int newMessageListItem2(MessageUser sender, MessageUser receiver,
      Project project, Message? message) {
    final index = getIndex2(
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
      // final ObservableList<Observable<Message>> empty_observe_list_msg =
      //     ObservableList();
      if (message != null) {
        emptyMessage.add(message);
      }
      messages2.add(Messages(
          messages: ObservableList.of(emptyMessage),
          projectId: project.id!,
          receiverId: receiver.id,
          senderId: sender.id));
      messageList.add(Observable<MessageListItem>(newMessageListItem));
      return getIndex2(project.id!, receiver.id, sender.id);
    }
    return index;
  }


  @action
  void addNewMessageToIndex2(int index, Message message) {
    this.messages2[index].messages.add(message);
  }

  @action
  void updateMessageListTitle(int index, String title) {
    messageList[index].value.content = title;
  }

  @action
  Interview getInterview(int index, int interviewId) {
    return this.messages2[index].messages.firstWhere((element) {
      return element.interview != null && element.interview!.id == interviewId;
    }).interview!;
  }

  

  @action
  updateInterview2(int index, dynamic interviewData) {
    final interviewId = interviewData['interviewId'];
    final title = interviewData['title'];
    final startTime = interviewData['startTime'];
    final endTime = interviewData['endTime'];
    Interview currInterview = getInterview(index, interviewId);
    currInterview.title = title;
    currInterview.startTime = DateTime.parse(startTime);
    currInterview.endTime = DateTime.parse(endTime);

    for (int i = 0; i < messages2[index].messages.length; i++) {
      if (messages2[index].messages[i].interview != null) {
        if (messages2[index].messages[i].interview!.id == interviewId) {
          messages2[index].messages[i].interview = currInterview;
        }
      }
    }
  }

  @action
  updateInterviewCancelled2(int index, int interviewId) {
    Interview currInterview = getInterview(index, interviewId);
    currInterview.disableFlag = 1;
    for (int i = 0; i < messages2[index].messages.length; i++) {
      if (messages2[index].messages[i].interview != null) {
        if (messages2[index].messages[i].interview!.id == interviewId) {
          messages2[index].messages[i].interview = currInterview;
        }
      }
    }
  }

  @action
  refreshMessage() {
    messageList = ObservableList<Observable<MessageListItem>>();
    messages2 = ObservableList<Messages>();
    // messages = ObservableList<ObservableMessages>();
    doneReloading = false;
    errorStore.errorMessage = "";
    getMessages();
  }

  @action
  clearStoreData() {
    messageList = ObservableList<Observable<MessageListItem>>();
    // messages = ObservableList<ObservableMessages>();
    messages2 = ObservableList<Messages>();
    success = false;
    doneReloading = false;
    successMessages = false;
  }
}
