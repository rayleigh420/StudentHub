import 'dart:developer';

import 'package:boilerplate/core/widgets/schedules/schedule_item_chat.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/domain/entity/message/interview.dart';
import 'package:boilerplate/domain/entity/message/message.dart';
import 'package:boilerplate/domain/entity/message/message_user.dart';
import 'package:boilerplate/domain/entity/notification/message_noti.dart';
import 'package:boilerplate/domain/entity/notification/notification.dart';
import 'package:boilerplate/domain/entity/project_2/project.dart';
import 'package:boilerplate/notification_service.dart';
import 'package:boilerplate/presentation/browse_project/store/project_company_store.dart';
import 'package:boilerplate/presentation/chat/message_detail.dart';
import 'package:boilerplate/presentation/chat/message_project_item.dart';
import 'package:boilerplate/presentation/chat/store/current_message_store.dart';
import 'package:boilerplate/presentation/chat/store/message_store.dart';
import 'package:boilerplate/presentation/chat/store/notification_store.dart';

import 'package:boilerplate/presentation/profile/store/profile_store.dart';
import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

import 'package:socket_io_client/socket_io_client.dart';

class MessageList extends StatefulWidget {
  const MessageList({super.key});

  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  // final SocketStore _socketStore = getIt<SocketStore>();

  final MessageStore _messageStore = getIt<MessageStore>();
  final ProjectCompanyStore _projectCompanyStore = getIt<ProjectCompanyStore>();
  final ProfileStore _profileStore = getIt<ProfileStore>();
  final NotificationStore _notificationStore = getIt<NotificationStore>();
  final CurrentMessageStore _currentMessageStore = getIt<CurrentMessageStore>();
  late List<Socket> _socketClientList = [];
  int count = 0;
  // late int myId = -1;+

  @override
  void initState() {
    super.initState();

    this._initSocket2();
  }

  @override
  void dispose() {
    _socketClientList.forEach((element) {
      element.dispose();
      element.disconnect();
    });
    super.dispose();
  }

  void _initSocket2() {
    final token = _profileStore.token;
    final socket = io(
        Endpoints.baseUrl,
        OptionBuilder()
            .setTransports(['websocket'])
            .enableForceNewConnection()
            .disableAutoConnect()
            .build());
    socket.io.options?['extraHeaders'] = {
      'Authorization': 'Bearer ${token}',
    };
    socket.connect();
    socket.onConnect((data) {
      log("Connected to user socket");
    });

    socket.onDisconnect((data) => {
          print('Disconnected'),
        });
    socket.onConnectError((data) => print('$data'));
    socket.onError((data) => print(data));

    socket.on("NOTI_${_profileStore.profile!.id}", (data) {
      dynamic noti = data;
      Noti notification = Noti(
          id: noti['notification']['id'],
          title: noti['notification']['title'],
          content: noti['notification']['content'],
          createdAt: DateTime.parse(noti['notification']['createdAt']),
          notifyFlag: noti['notification']['notifyFlag'],
          typeNotifyFlag: noti['notification']['typeNotifyFlag'],
          messageNoti: MessageNoti.fromJson(noti['notification']['message']));

      int index = _messageStore.getIndex2(
          noti['notification']['message']['projectId'],
          noti['notification']['receiver']['id'],
          noti['notification']['sender']['id']);

      log("index ban đầu: $index");

      if (_currentMessageStore.index == index) {
        log("index hiện tại: ${_currentMessageStore.index}");
      } else {
        setState(() {
          count = count + 1;
        });
        Message newMessage = Message(
            id: noti['notification']['message']['id'],
            content: noti['notification']['message']['content'],
            createdAt:
                DateTime.parse(noti['notification']['message']['createdAt']),
            messageFlag: noti['notification']['message']['messageFlag'],
            receiver: MessageUser(
                id: noti['notification']['receiver']['id'],
                fullname: noti['notification']['receiver']['fullname']),
            sender: MessageUser(
                id: noti['notification']['sender']['id'],
                fullname: noti['notification']['sender']['fullname']),
            interview: null);
        if (noti['notification']['message']['messageFlag'] == 1) {
          dynamic interview = data['notification']['message']['interview'];
          dynamic meetingRoom =
              data['notification']['message']['interview']['meetingRoom'];
          Interview interviewData = Interview.fromJson({
            "id": interview['id'],
            "title": interview['title'],
            "createdAt": interview['createdAt'],
            "updatedAt": interview['updatedAt'],
            "deletedAt": interview['deletedAt'],
            "startTime": interview['startTime'],
            "endTime": interview['endTime'],
            "disableFlag": interview['disableFlag'],
            "meetingRoomId": interview['meetingRoomId'],
          });
          MeetingRoom meetingRoomData = MeetingRoom.fromJson({
            "id": meetingRoom['id'],
            "createdAt": meetingRoom['createdAt'],
            "updatedAt": meetingRoom['updatedAt'],
            "deletedAt": meetingRoom['deletedAt'],
            "meeting_room_code": meetingRoom['meeting_room_code'],
            "meeting_room_id": meetingRoom['meeting_room_id'],
            "expired_at": meetingRoom['expired_at'],
          });
          interviewData.meetingRoom = meetingRoomData;
          newMessage.interview = interviewData;
        }
        if (index == -1) {
          //handle new item
          int newIndex = _messageStore.newMessageListItem2(
              MessageUser(
                  id: noti['notification']['sender']['id'],
                  fullname: noti['notification']['sender']['fullname']),
              MessageUser(
                  id: noti['notification']['receiver']['id'],
                  fullname: noti['notification']['receiver']['fullname']),
              Project(
                  id: noti['notification']['message']['projectId'],
                  title:
                      "Project id ${noti['notification']['message']['projectId']}"),
              newMessage);
          log("index thêm message: $newIndex");
        } else {
          int index2 = _messageStore.getIndexMessageList(
              noti['notification']['message']['projectId'],
              noti['notification']['receiver']['id'],
              noti['notification']['sender']['id']);

          if (noti['notification']['content'] == "Interview updated") {
            _messageStore.updateInterview2(index, {
              "interviewId": data['notification']['message']['interview']['id'],
              "title": data['notification']['message']['interview']['title'],
              "startTime": data['notification']['message']['interview']
                  ['startTime'],
              "endTime": data['notification']['message']['interview']
                  ['endTime'],
            });
          } else if (noti['notification']['content'] == "Interview cancelled") {
            _messageStore.updateInterviewCancelled2(
                index, data['notification']['message']['interview']['id']);
          } else {
            _messageStore.addNewMessageToIndex2(index, newMessage);
            _messageStore.updateMessageListTitle(index2,
                "${noti['notification']['sender']['fullname']}: ${noti['notification']['message']['content']}");
          }
        }
        if (noti['notification']['senderId'] != _profileStore.profile!.id) {
          _notificationStore.addNotification(notification);
          NotificationService().showNotification(
              title: notification.title,
              body: notification.content,
              payload:
                  "${noti['notification']['message']['projectId']}_${noti['notification']['receiver']['id']}_${noti['notification']['sender']['id']}");
        }
        log(notification.toJson().toString());
      }
    });

    socket.on("ERROR", (data) => print(data));

    _socketClientList.add(socket);
  }

  Future<void> _pullRefresh() async {
    _messageStore.refreshMessage();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('StudentHub'),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(18, 10, 20, 0),
        child: buildMainContent(),
      ),
    ));
  }

  Widget buildMainContent() {
    return Observer(
      builder: (context) {
        if (_messageStore.doneReloading == false) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        } else {
          return DefaultTabController(
            length: 2, // Số lượng tab là 2: Chat và Interview
            child: Column(
              children: [
                Container(
                  // margin: EdgeInsets.only(top: 20),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    maxLines: 1,
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
                    decoration: InputDecoration(
                      hintText:
                          AppLocalizations.of(context).translate('search_text'),
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      // contentPadding: EdgeInsets.all(10),
                    ),
                    onChanged: (value) {},
                  ),
                ),
                SizedBox(height: 10),
                TabBar(
                  tabs: [
                    Tab(text: 'Chat'),
                    Tab(text: 'Interview'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      buildChatTab(),
                      buildInterviewTab(),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  // Widget buildMessageListTab(BuildContext context) {
  //   return ListView.builder(
  //     shrinkWrap: true,
  //     itemCount: _messageStore.messageList.length,
  //     physics: NeverScrollableScrollPhysics(),
  //     itemBuilder: (context, index) {
  //       final newIndex = _messageStore.getIndex(
  //           _messageStore.messageList[index].value.project.id!,
  //           _messageStore.messageList[index].value.receiver.id,
  //           _messageStore.messageList[index].value.sender.id);
  //       return MessageProjectItem(
  //         messageListItem: _messageStore.messageList![index].value,
  //         index: newIndex,
  //       );
  //     },
  //   );
  // }

  Widget buildChatTab() {
    _messageStore.messageList
        .sort((a, b) => b.value.createdAt.compareTo(a.value.createdAt));
    return RefreshIndicator(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: _messageStore.messageList.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final newIndex = _messageStore.getIndex2(
                    _messageStore.messageList[index].value.project.id!,
                    _messageStore.messageList[index].value.receiver.id,
                    _messageStore.messageList[index].value.sender.id,
                  );
                  final newIndex2 = _messageStore.getIndexMessageList(
                      _messageStore.messageList[index].value.project.id!,
                      _messageStore.messageList[index].value.receiver.id,
                      _messageStore.messageList[index].value.sender.id);
                  return MessageProjectItem(
                    messageListItem: _messageStore.messageList![index].value,
                    index: newIndex,
                    index2: newIndex2,
                  );
                },
              ),
            ],
          ),
        ),
        onRefresh: _pullRefresh);
  }

  Widget buildInterviewTab() {
    final filteredInterviews = _messageStore.interviews2
        .where((interview) => interview.interview.disableFlag == 0)
        .toList();
    filteredInterviews
        .sort((a, b) => b.interview.startTime.compareTo(a.interview.startTime));

    return RefreshIndicator(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: filteredInterviews.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final interview = filteredInterviews[index];

                  return Container(
                    padding: EdgeInsets.all(10),
                    child: ScheduleItemChat(
                      interview: interview.interview,
                      isCancelled:
                          interview.interview.disableFlag == 1 ? true : false,
                      type: 1,
                      onTap: (p0) {
                        final index = _messageStore.getIndex2(
                          interview.projectId,
                          interview.receiverId,
                          interview.senderId,
                        );
                        log("hey index: $index");
                        Navigator.of(context, rootNavigator: true)
                            .push(MaterialPageRoute(
                                builder: (context) => MessageDetail(
                                      projectId: interview.projectId,
                                      receiverId: interview.receiverId,
                                      senderId: interview.senderId,
                                      index: index,
                                    ),
                                maintainState: false));
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        onRefresh: _pullRefresh);
  }
}
