import 'dart:developer';

import 'package:boilerplate/core/widgets/schedules/schedule_item_chat.dart';
import 'package:boilerplate/core/widgets/schedules/schedule_meet_modal.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/domain/entity/message/interview.dart';
import 'package:boilerplate/domain/entity/message/message.dart';

import 'package:boilerplate/domain/entity/message/message_user.dart';
import 'package:boilerplate/domain/entity/notification/message_noti.dart';
import 'package:boilerplate/domain/entity/notification/notification.dart';
import 'package:boilerplate/domain/entity/project_2/project.dart';
import 'package:boilerplate/domain/usecase/message/cancel_schedule_message.dart';
import 'package:boilerplate/domain/usecase/message/new_message_usecase.dart';
import 'package:boilerplate/domain/usecase/message/new_schedule_usecase.dart';
import 'package:boilerplate/domain/usecase/message/update_schedule_usecase.dart';
import 'package:boilerplate/presentation/chat/store/current_message_store.dart';
import 'package:boilerplate/presentation/chat/store/message_store.dart';
import 'package:boilerplate/presentation/home/store/theme/theme_store.dart';

// import 'package:boilerplate/presentation/chat/message_list.dart';
import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

class MessageDetail extends StatefulWidget {
  final int projectId;
  final int receiverId;
  final int senderId;
  final dynamic index;

  MessageDetail({
    super.key,
    required this.projectId,
    required this.receiverId,
    required this.senderId,
    this.index,
  });

  @override
  State<MessageDetail> createState() => _MessageDetailState();
}

class _MessageDetailState extends State<MessageDetail> {
  final TextEditingController _messagecontroller = new TextEditingController();
  final ScrollController _controller = new ScrollController();
  final SharedPreferenceHelper _sharePref = getIt<SharedPreferenceHelper>();
  final ThemeStore _themeStore = getIt<ThemeStore>();
  final MessageStore _messageStore = getIt<MessageStore>();
  late MessageUser me = MessageUser(id: -1, fullname: "");
  late MessageUser other = MessageUser(id: -1, fullname: "");
  List<Message> messages = [];
  String token = '';
  int index = -1;
  final NewMessageUseCase _newMessageUseCase = getIt<NewMessageUseCase>();
  final NewScheduleUseCase _newScheduleUseCase = getIt<NewScheduleUseCase>();
  final UpdateScheduleUseCase _updateScheduleUseCase =
      getIt<UpdateScheduleUseCase>();
  final CancelScheduleUseCase _cancelScheduleUseCase =
      getIt<CancelScheduleUseCase>();
  late Socket socket;
  final CurrentMessageStore _currentMessageStore = getIt<CurrentMessageStore>();
  int count = 0;
  @override
  void initState() {
    super.initState();
    log("receiver + sender: " +
        widget.receiverId.toString() +
        " " +
        widget.senderId.toString() +
        " " +
        widget.projectId.toString());
    _loadId();
    // _loadId();
  }

  @override
  void dispose() {
    socket.disconnect();
    socket.dispose();
    super.dispose();
    _currentMessageStore.clearMessageListItem();
    // print("dispose detail message");
  }

  _connectSocket() {
    // socket = new SocketClient(widget.projectId);
    final finalurl = Endpoints.baseUrl;
    log("Connecting to $finalurl");
    socket = IO.io(
        Endpoints.baseUrl,
        OptionBuilder()
            .setTransports(['websocket'])
            .enableForceNewConnection()
            // .setExtraHeaders({'Authorization': 'Bearer $token'})
            .disableAutoConnect()
            .build());

    print('Bearer $token');
    socket.io.options?['extraHeaders'] = {
      'Authorization': 'Bearer ${token}',
    };

    socket.onConnect((data) {
      print('Connected');
      log("Connected to user id ${other.id}");
    });

    socket.onDisconnect((data) => {
          print('Disconnected'),
        });
    socket.onConnectError((data) => print('$data'));
    socket.onError((data) => print(data));
    socket.on("ERROR", (data) => print(data));
    // socket.on("RECEIVE_MESSAGE", (data) {
    //   log("RECEIVE_MESSAGE");
    //   print(data);
    //   dynamic msg = data['notification']['message'];
    //   msg['projectId'] = widget.projectId;
    //   Message message = Message.fromJson({
    //     "id": msg['id'],
    //     "content": msg['content'],
    //     "sender": {
    //       "id": msg['senderId'],
    //       "fullname": data['notification']['sender']['fullname']
    //     },
    //     "receiver": {
    //       "id": msg['receiverId'],
    //       "fullname": data['notification']['receiver']['fullname']
    //     },
    //     "messageFlag": msg['messageFlag'],
    //     "createdAt": DateTime.now().toString(),
    //     "interview": null
    //   });
    //   setState(() {
    //     messages.add(message);
    //   });
    // });

    // socket.on("RECEIVE_INTERVIEW", (data) {
    //   log("RECEIVE_INTERVIEW");
    //   if (data['notification'] == null) {
    //     log("CANCEL_INTERVIEW");
    //     final projectId = data['projectId'];
    //     final receiverId = data['receiverId'];
    //     final senderId = data['senderId'];
    //     final messageId = data['messageId'];
    //     int index = _messageStore.getIndex(
    //       projectId,
    //       receiverId,
    //       senderId,
    //     );
    //     setState(() {
    //       messages.forEach((element) {
    //         if (element.id == messageId) {
    //           element.interview!.disableFlag = 1;
    //         }
    //       });
    //     });
    //     return;
    //   }
    //   log("NORMAL_EVENT");
    //   dynamic msg = data['notification']['message'];
    //   dynamic interview = data['notification']['message']['interview'];
    //   dynamic meetingRoom =
    //       data['notification']['message']['interview']['meetingRoom'];
    //   dynamic sender = data['notification']['sender'];
    //   dynamic receiver = data['notification']['receiver'];

    //   Interview interviewData = Interview.fromJson({
    //     "id": interview['id'],
    //     "title": interview['title'],
    //     "createdAt": interview['createdAt'],
    //     "updatedAt": interview['updatedAt'],
    //     "deletedAt": interview['deletedAt'],
    //     "startTime": interview['startTime'],
    //     "endTime": interview['endTime'],
    //     "disableFlag": interview['disableFlag'],
    //     "meetingRoomId": interview['meetingRoomId'],
    //   });
    //   MeetingRoom meetingRoomData = MeetingRoom.fromJson({
    //     "id": meetingRoom['id'],
    //     "createdAt": meetingRoom['createdAt'],
    //     "updatedAt": meetingRoom['updatedAt'],
    //     "deletedAt": meetingRoom['deletedAt'],
    //     "meeting_room_code": meetingRoom['meeting_room_code'],
    //     "meeting_room_id": meetingRoom['meeting_room_id'],
    //     "expired_at": meetingRoom['expired_at'],
    //   });
    //   interviewData.meetingRoom = meetingRoomData;
    //   Message message = Message.fromJson({
    //     "id": msg['id'],
    //     "content": msg['content'],
    //     "sender": {"id": msg['senderId'], "fullname": sender['fullname']},
    //     "receiver": {"id": msg['receiverId'], "fullname": receiver['fullname']},
    //     "messageFlag": msg['messageFlag'],
    //     "createdAt": msg['createdAt'],
    //   });

    //   message.interview = interviewData;
    //   log(message.toJson().toString());
    //   if (data['notification']['content'] == 'Interview updated') {
    //     final interviewId = interview['id'];
    //     final newTitle = interview['title'];
    //     final newStartTime = interview['startTime'];
    //     final newEndTime = interview['endTime'];
    //     Interview currentInterview =
    //         _messageStore.getInterview(this.index, interviewId);
    //     currentInterview.title = newTitle;
    //     currentInterview.startTime = newStartTime;
    //     currentInterview.endTime = newEndTime;

    //     setState(() {
    //       messages.add(message);
    //       messages.removeLast();
    //     });
    //   } else {
    //     setState(() {
    //       messages.add(message);
    //     });
    //   }
    // });

    socket.on("NOTI_${other.id}", (data) {
      setState(() {
        count = count + 1;
      });
      dynamic noti = data;
      if (noti['notification']['typeNotifyFlag'] == "0") {
        return;
      } else if (noti['notification']['typeNotifyFlag'] == "2") {
        return;
      }

      log("index ban đầu: $index");
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
          "endTime": data['notification']['message']['interview']['endTime'],
        });
      } else if (noti['notification']['content'] == "Interview cancelled") {
        _messageStore.updateInterviewCancelled2(
            index, noti['notification']['message']['interview']['id']);
      } else {
        _messageStore.addNewMessageToIndex2(index, newMessage);
        _messageStore.updateMessageListTitle(index2,
            "${noti['notification']['sender']['fullname']}: ${noti['notification']['message']['content']}");

        //notification
      }
    });

    socket.on("NOTI_${me.id}", (data) {
      setState(() {
        count = count + 1;
      });

      dynamic noti = data;
      if (noti['notification']['typeNotifyFlag'] == "0") {
        return;
      } else if (noti['notification']['typeNotifyFlag'] == "2") {
        return;
      }
      log("index ban đầu: $index");
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
          "endTime": data['notification']['message']['interview']['endTime'],
        });
      } else if (noti['notification']['content'] == "Interview cancelled") {
        _messageStore.updateInterviewCancelled2(
            index, noti['notification']['message']['interview']['id']);
      } else {
        _messageStore.addNewMessageToIndex2(index, newMessage);
        _messageStore.updateMessageListTitle(index2,
            "${noti['notification']['sender']['fullname']}: ${noti['notification']['message']['content']}");

        //notification
      }
    });

    socket.connect();
    // _messageStore.receiveMessage(msg);
  }

  _loadId() async {
    final id = await _sharePref.getDefaultId();
    final tk = await _sharePref.authToken;
    setState(() {
      token = tk!;
    });
    log(widget.projectId.toString() +
        " " +
        widget.receiverId.toString() +
        " " +
        widget.senderId.toString());
    if (widget.index == null) {
      this.index = _messageStore.getIndex2(
          widget.projectId, widget.receiverId, widget.senderId);
    } else {
      this.index = widget.index;
    }
    _currentMessageStore.setIndex(this.index);
    // List<Message> m = _messageStore.messages2[this.index].;
    log("index tu widget message_detail" + this.index.toString());
    // setState(() {
    //   messages = m;
    // });
    if (_messageStore.messages2[this.index].messages.isEmpty) {
      final otherId =
          widget.receiverId == id ? widget.senderId : widget.receiverId;
      setState(() {
        me = MessageUser(id: id!, fullname: "User id $id");
        other = MessageUser(id: otherId, fullname: "User id $otherId");
      });
    } else {
      if (id == _messageStore.messages2[this.index].messages[0].sender.id) {
        setState(() {
          me = _messageStore.messages2[this.index].messages[0].sender;
          other = _messageStore.messages2[this.index].messages[0].receiver;
        });
      } else {
        setState(() {
          me = _messageStore.messages2[this.index].messages[0].receiver;
          other = _messageStore.messages2[this.index].messages[0].sender;
        });
      }
    }

    _connectSocket();
  }

  void newMessage(String content) {
    Message newmesage = Message(
      id: -1,
      content: content,
      sender: me,
      receiver: other,
      createdAt: DateTime.now(),
      interview: null,
      messageFlag: 0,
    );
    log(newmesage.toJson().toString());
    socket.emit("SEND_MESSAGE", {
      "content": newmesage.content,
      "senderId": newmesage.sender.id,
      "receiverId": newmesage.receiver.id,
      "projectId": widget.projectId,
      "messageFlag": 0
    });
  }

  void newMessageApi(String content) {
    Message newMessage = Message(
      id: -1,
      content: content,
      sender: me,
      receiver: other,
      createdAt: DateTime.now(),
      interview: null,
      messageFlag: 0,
    );
    //callapi
    _newMessageUseCase(
        params: MessageParams(message: {
      "content": newMessage.content,
      "senderId": newMessage.sender.id,
      "receiverId": newMessage.receiver.id,
      "projectId": widget.projectId,
      "messageFlag": 0
    }));
  }

  void newSchedule(dynamic dataInterview) {
    dynamic msg = {
      "title": dataInterview['title'],
      "content": "Schedule a meeting",
      "startTime": dataInterview['startTime'],
      "endTime": dataInterview['endTime'],
      "projectId": widget.projectId,
      "senderId": me.id,
      "receiverId": other.id,
      "meeting_room_code":
          "${other.id}_${me.id}_${DateTime.now().toIso8601String()}",
      "meeting_room_id":
          "${me.id}_${other.id}_${DateTime.now().toIso8601String()}"
    };
    log("data nè " + msg.toString());

    log(msg.toString());
    socket.emit("SCHEDULE_INTERVIEW", msg);
  }

  void newScheduleApi(dynamic dataInterview) {
    dynamic msg = {
      "title": dataInterview['title'],
      "content": "Schedule a meeting",
      "startTime": dataInterview['startTime'],
      "endTime": dataInterview['endTime'],
      "projectId": widget.projectId,
      "senderId": me.id,
      "receiverId": other.id,
      "meeting_room_code":
          "${other.id}_${me.id}_${DateTime.now().toIso8601String()}",
      "meeting_room_id":
          "${me.id}_${other.id}_${DateTime.now().toIso8601String()}"
    };
    //callapi
    _newScheduleUseCase.call(params: NewScheduleParams(message: msg));
    log("data nè " + msg.toString());
  }

  void updateScheduleApi(dynamic dataInterview) {
    dynamic msg = {
      "title": dataInterview['title'],
      "startTime": dataInterview['startTime'],
      "endTime": dataInterview['endTime'],
    };
    //callapi
    _updateScheduleUseCase.call(
        params: UpdatecheduleParams(
            interviewId: dataInterview['id'], message: msg));
    log("data update nè " + msg.toString());
  }

  void deleteScheduleApi(int interviewId) {
    // dynamic msg = {
    //   "interviewId": interviewId,
    //   "projectId": widget.projectId,
    //   "senderId": me.id,
    //   "receiverId": other.id,
    //   "deleteAction": true
    // };
    _cancelScheduleUseCase.call(
        params: CancelScheduleParams(interviewId: interviewId));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('assets/images/student.png'),
                ),
              ),
              Text(other.fullname),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                child: Text(count.toString()),
                height: 0,
                width: 0,
              )
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_horiz),
            onPressed: () {
              showCupertinoModalPopup(
                  context: context,
                  builder: (context) {
                    return CupertinoActionSheet(
                      actions: [
                        CupertinoActionSheetAction(
                          onPressed: () {
                            showModalBottomSheet(
                              isDismissible: true,
                              context: context,
                              isScrollControlled: true,
                              useRootNavigator: true,
                              enableDrag: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) {
                                return ScheduleMeetingModal(
                                  newSchedule: (data) {
                                    newScheduleApi(data);
                                  },
                                  isUpdate: false,
                                );
                              },
                            );
                            // Navigator.pop(context);
                          },
                          child: Text(AppLocalizations.of(context)
                              .translate('schedule_a_meeting_text')),
                        ),
                      ],
                      cancelButton: CupertinoActionSheetAction(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                            AppLocalizations.of(context)
                                .translate('cancel_text'),
                            style: TextStyle(color: Colors.red)),
                      ),
                    );
                  });
            },
          ),
        ],
      ),
      // resizeToAvoidBottomInset: false,
      body: Observer(
        builder: (context) {
          return Stack(
            children: [
              Container(
                height: DeviceUtils.getScaledHeight(context, 1),
                child: SingleChildScrollView(
                  controller: _controller,
                  reverse: true,
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // buildChatDivider(context, "6/6/2024"),
                      buildChat(),
                      const SizedBox(height: 70),
                    ],
                  ),
                ),
              ),
              buildBottomTextBox(context)
            ],
          );
        },
      ),
    ));
  }

  Widget buildChat() {
    int i = _messageStore.getIndex2(
        widget.projectId, widget.receiverId, widget.senderId);

    return _messageStore.loading
        ? Center(child: CupertinoActivityIndicator())
        : Observer(
            builder: (context) {
              return Column(
                children: [
                  ListView.builder(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _messageStore.messages2[i].messages.length,
                    itemBuilder: (context, index) {
                      if (_messageStore
                              .messages2[i].messages[index].sender.id !=
                          me.id) {
                        if (_messageStore
                                .messages2[i].messages[index].interview ==
                            null) {
                          return buildMessageFrom(context,
                              _messageStore.messages2[i].messages[index]);
                        } else
                          return buildMessageSchedule(
                              context,
                              _messageStore.messages2[i].messages[index],
                              "assets/images/student.png");
                      } else {
                        if (_messageStore
                                .messages2[i].messages[index].interview ==
                            null) {
                          return buildMessageTo(context,
                              _messageStore.messages2[i].messages[index]);
                        }
                        return buildMessageScheduleTo(
                            context,
                            _messageStore.messages2[i].messages[index],
                            "assets/images/student.png");
                      }
                    },
                  )
                ],
              );
            },
          );
  }

  Widget buildMessageTo(BuildContext context, Message message) {
    return Container(
        // padding: EdgeInsets.all(10),
        alignment: Alignment.centerRight,
        child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            message.content,
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
        ));
  }

  Widget buildMessageFrom(BuildContext context, Message message) {
    return Container(
        // padding: EdgeInsets.all(10),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _themeStore.darkMode ? Colors.black : Color(0xffF0F0F0),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                message.content,
                style: TextStyle(fontSize: 15),
              ),
            )
          ],
        ));
  }

  Widget buildMessageSchedule(
      BuildContext context, Message message, String avatarUrl) {
    return Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(10),
        // width: DeviceUtils.getScaledWidth(context, 0.5),
        child: ScheduleItemChat(
          interview: message.interview!,
          isCancelled: false,
          type: 0,
        ));
  }

  Widget buildMessageScheduleTo(
      BuildContext context, Message message, String avatarUrl) {
    return GestureDetector(
      onTap: () {
        log(message.id.toString());
      },
      child: Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.all(10),
          child: ScheduleItemChat(
            interview: message.interview!,
            isCancelled: false,
            type: 1,
            updateSchedule: (data) {
              updateScheduleApi(data);
            },
            deleteSchedule: (data) {
              deleteScheduleApi(data);
            },
          )),
    );
  }

  Widget buildChatDivider(BuildContext context, String date) {
    return Container(
        margin: EdgeInsets.only(top: 15),
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Divider(
                color: Colors.grey,
              ),
            ),
            SizedBox(
              width: 1,
            ),
            Text("6/6/2024", style: TextStyle(color: Colors.grey)),
            SizedBox(
              width: 1,
            ),
            Expanded(
              child: Divider(
                color: Colors.grey,
              ),
            ),
          ],
        ));
  }

  Widget buildSendMessage(BuildContext context) {
    return Container(
        child: Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(width: 1.0),
            bottom: BorderSide(width: 1.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                child: IconButton(
                    padding: EdgeInsets.all(10),
                    constraints: BoxConstraints(),
                    icon: const Icon(Icons.calendar_today),
                    color: Colors.black,
                    iconSize: 30,
                    onPressed: () {})),
            Expanded(
              child: TextField(
                keyboardType: TextInputType.text,
                maxLines: 3,
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
                decoration: const InputDecoration(
                  hintText: 'Chat content',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(10),
                ),
                onChanged: (value) {},
              ),
            ),
            Container(
                child: IconButton(
                    padding: EdgeInsets.all(10),
                    constraints: BoxConstraints(),
                    icon: const Icon(Icons.send),
                    color: Colors.black,
                    iconSize: 30,
                    onPressed: () {})),
          ],
        ),
      ),
    ));
  }

  Widget buildBottomTextBox(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
        height: 60,
        width: double.infinity,
        color: Colors.white,
        child: Row(
          children: <Widget>[
            GestureDetector(
              onTap: () {},
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: TextField(
                controller: _messagecontroller,
                autofocus: true,
                // onTapOutside: (event) {
                //   FocusScope.of(context).unfocus();
                // },
                decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)
                        .translate('input_message_hint_text'),
                    hintStyle: TextStyle(color: Colors.black54),
                    border: InputBorder.none),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            FloatingActionButton(
              onPressed: () {
                // newMessage(_messagecontroller.text);
                newMessageApi(_messagecontroller.text);
                _messagecontroller.clear();
              },
              child: Icon(
                Icons.send,
                color: Colors.white,
                size: 18,
              ),
              backgroundColor: Colors.blue,
              elevation: 0,
            ),
          ],
        ),
      ),
    );
  }
}
