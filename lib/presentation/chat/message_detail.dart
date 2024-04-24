import 'package:boilerplate/core/widgets/schedules/schedule_item_chat.dart';
import 'package:boilerplate/core/widgets/schedules/schedule_meet_modal.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/network/socket_client.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/domain/entity/message/message.dart';

import 'package:boilerplate/domain/entity/message/message_project.dart';
import 'package:boilerplate/domain/entity/message/message_user.dart';
import 'package:boilerplate/presentation/login/login.dart';
// import 'package:boilerplate/presentation/chat/message_list.dart';
import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageDetail extends StatefulWidget {
  final MessageProject messageProject;
  const MessageDetail({super.key, required this.messageProject});

  @override
  State<MessageDetail> createState() => _MessageDetailState();
}

class _MessageDetailState extends State<MessageDetail> {
  final TextEditingController _messagecontroller = TextEditingController();
  final GlobalKey _scrollViewKey = GlobalKey();
  final ScrollController _controller = ScrollController();
  final SharedPreferenceHelper _sharePref = getIt<SharedPreferenceHelper>();
  late final SocketClient socketClient =
      SocketClient(widget.messageProject.project.id!);
  late int myId = -1;
  late int otherId = -1;
  late MessageProject messageProject = widget.messageProject;

  @override
  void initState() {
    super.initState();
    print("rerender");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadId();
      _connectSocket();
    });
  }

  @override
  void dispose() {
    super.dispose();
    socketClient.disconnect();
  }

  _connectSocket() async {
    final token = await _sharePref.authToken;
    socketClient.connect(Endpoints.baseUrl, token!);
  }

  _loadId() async {
    // final token = await _sharePref.authToken;
    final role = await _sharePref.roles;
    final token = await _sharePref.authToken;

    final companyId = await _sharePref.currentCompanyId;
    final userId = await _sharePref.currentStudentId;
    if (companyId == null && userId == null) {
      Navigator.of(context, rootNavigator: true).pushReplacement(
          MaterialPageRoute(
              builder: (context) => LoginScreen(), maintainState: false));
    }
    if (token == null) {
      Navigator.of(context, rootNavigator: true).pushReplacement(
          MaterialPageRoute(
              builder: (context) => LoginScreen(), maintainState: false));
    }
    print("role: " + role.toString());
    if (role![0] != null) {
      final jwt = JWT.decode(token!);
      final id2 = findOtherId();

      setState(
        () {
          myId = jwt.payload['id'];
          otherId = id2;
        },
      );
      // if (role[0] == 1) {
      //   // myId = companyId!;
      //   setState(() {
      //     myId = companyId!;
      //   });
      //   print(("company id: " + companyId.toString()));
      // } else {
      //   setState(() {
      //     myId = userId!;
      //   });
      //   // myId = userId!;
      //   print(("student id: " + userId.toString()));
      // }
    }
  }

  int findOtherId() {
    if (myId == messageProject.messages[0].sender.id) {
      return messageProject.messages[0].receiver.id;
    }
    return messageProject.messages[0].sender.id;
  }

  void newMessage(String content) {
    Message newmesage = Message(
      id: messageProject.messages.last.id + 1,
      content: content,
      sender: MessageUser.fromJson({
        "id": myId,
        "fullname": "Luis Pham",
      }),
      receiver: MessageUser.fromJson({
        "id": otherId,
        "fullname": "Luis Pham",
      }),
      createdAt: DateTime.now().add(Duration(minutes: 35)),
    );
    setState(() {
      messageProject.messages.add(newmesage);
    });
    // scrollToBottom();
  }

  void newSchedule(String content) {
    Message newmesage = Message(
      id: messageProject.messages.last.id + 1,
      content: content,
      sender: MessageUser.fromJson({
        "id": myId,
        "fullname": "Luis Pham",
      }),
      receiver: MessageUser.fromJson({
        "id": otherId,
        "fullname": "Luis Pham",
      }),
      createdAt: DateTime.now().add(Duration(minutes: 35)),
    );
    socketClient.sendMessage("SEND_MESSAGE", newmesage);
    setState(() {
      messageProject.messages.add(newmesage);
    });
  }

  void scrollToBottom() {
    _controller.animateTo(
      _controller.position.minScrollExtent,
      duration: Duration(seconds: 1),
      curve: Curves.ease,
    );
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
              // GestureDetector(
              //   onTap: () {
              //     Navigator.pop(context);
              //   },
              //   child: Padding(
              //     padding: EdgeInsets.only(left: 10),
              //     child: Icon(Icons.arrow_back_ios),
              //   ),
              // ),
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage('assets/images/student.png'),
                ),
              ),
              Text('Luis Pham')
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
                                  newSchedule: () {
                                    newSchedule("aha");
                                  },
                                );
                              },
                            );
                            // Navigator.pop(context);
                          },
                          child: Text("Schedule a meeting"),
                        ),
                      ],
                      cancelButton: CupertinoActionSheetAction(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child:
                            Text("Cancel", style: TextStyle(color: Colors.red)),
                      ),
                    );
                  });
            },
          ),
        ],
      ),
      // resizeToAvoidBottomInset: false,
      body: Stack(
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
                  buildChatDivider(context, "6/6/2024"),
                  buildChat(),
                  // buildMessageTo(context, messages2[0]),
                  // buildMessageFrom(context, messages2[1]),
                  // buildMessageSchedule(
                  //     context, "12:00 AM", "Luis", "assets/images/student.png"),
                  // buildMessageTo(context, messages2[2]),
                  // buildMessageScheduleTo(
                  //     context, "12:00 AM", "Luis", "assets/images/student.png"),
                  const SizedBox(height: 70),
                ],
              ),
            ),
          ),
          buildBottomTextBox(context)
        ],
      ),
    ));
  }

  Widget buildChat() {
    return Column(
      children: [
        ListView.builder(
          key: _scrollViewKey,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: messageProject.messages.length,
          itemBuilder: (context, index) {
            if (messageProject.messages[index].sender.id != myId) {
              if (messageProject.messages[index].interview == null) {
                return buildMessageFrom(
                    context, messageProject.messages[index]);
              } else
                return buildMessageSchedule(
                    context, "12:00 AM", "Luis", "assets/images/student.png");
            } else {
              if (messageProject.messages[index].interview == null) {
                return buildMessageTo(context, messageProject.messages[index]);
              }
              return buildMessageScheduleTo(
                  context, "12:00 AM", "Luis", "assets/images/student.png");
            }
          },
        )
      ],
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
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.grey.withOpacity(0.5),
            //     spreadRadius: 2,
            //     blurRadius: 2,
            //     offset: Offset(0, 2), // changes position of shadow
            //   ),
            // ],
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
                color: Color(0xffF0F0F0),
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

  Widget buildMessage(BuildContext context, String message, String time,
      String name, String avatarUrl) {
    return Container(
        padding: EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  padding: EdgeInsets.all(10),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage(avatarUrl),
                  )),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              child: Text(
                            name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          )),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                              child: Text(
                            time,
                            style: TextStyle(fontSize: 15),
                          )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      message,
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          )
        ]));
  }

  Widget buildMessageSchedule(
      BuildContext context, String time, String name, String avatarUrl) {
    return Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.all(10),
        // width: DeviceUtils.getScaledWidth(context, 0.5),
        child: ScheduleItemChat(
          isCancelled: false,
          type: 0,
        ));
  }

  Widget buildMessageScheduleTo(
      BuildContext context, String time, String name, String avatarUrl) {
    return Container(
        alignment: Alignment.centerRight,
        // width: DeviceUtils.getScaledWidth(context, 0.5),
        padding: EdgeInsets.all(10),
        child: ScheduleItemChat(
          isCancelled: false,
          type: 0,
        ));
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
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                },
                decoration: InputDecoration(
                    hintText: "Write message...",
                    hintStyle: TextStyle(color: Colors.black54),
                    border: InputBorder.none),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            FloatingActionButton(
              onPressed: () {
                newMessage(_messagecontroller.text);
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
