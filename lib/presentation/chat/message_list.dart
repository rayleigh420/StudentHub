import 'dart:developer';

import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/domain/entity/message/message_project.dart';
import 'package:boilerplate/domain/usecase/message/get_all_message_usecase.dart';
import 'package:boilerplate/presentation/chat/message_detail.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageList extends StatefulWidget {
  const MessageList({super.key});

  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  final GetAllMessageUseCase _getAllMessageUseCase =
      getIt<GetAllMessageUseCase>();
  final SharedPreferenceHelper _sharedPreferenceHelper =
      getIt<SharedPreferenceHelper>();
  late int myId = -1;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Add Your Code here.
      _loadId();
    });
  }

  _loadId() async {
    final token = await _sharedPreferenceHelper.authToken;
    log(token.toString());
    if (token != null) {
      final jwt = JWT.decode(token);
      final id = jwt.payload['id'];
      setState(
        () {
          myId = id;
        },
      );
    }
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
        child: FutureBuilder<List<MessageProject>>(
          future: _getAllMessageUseCase.call(params: null),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CupertinoActivityIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error appeared"),
              );
            } else {
              final messages = snapshot.data;
              messages!.forEach((element) {
                if (element.messages.last.sender.id == myId) {
                  element.otherId = element.messages.last.receiver.id;
                  element.otherFullname =
                      element.messages.last.receiver.fullname;
                } else {
                  element.otherId = element.messages.last.sender.id;
                  element.otherFullname = element.messages.last.sender.fullname;
                }
              });
              log(messages.toString());
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        onTapOutside: (event) =>
                            FocusScope.of(context).unfocus(),
                        decoration: const InputDecoration(
                          hintText: 'Search ',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          contentPadding: EdgeInsets.all(10),
                        ),
                        onChanged: (value) {},
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListView.builder(
                      itemCount: messages!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return MessageProjectItem(
                          messageProject: messages[index],
                        );
                      },
                    )

                    // MessageProjectItem(),
                  ],
                ),
              );
            }
          },
        ),
      ),
    ));
  }
}

class MessageProjectItem extends StatelessWidget {
  final MessageProject messageProject;
  MessageProjectItem({super.key, required this.messageProject});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        decoration: BoxDecoration(
          border: Border(
            // top: BorderSide(width: 1.0),
            bottom: BorderSide(width: 0.5),
          ),
        ),
        child: InkWell(
          onTap: () {
            Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                builder: (context) => MessageDetail(
                      messageProject: messageProject,
                    ),
                maintainState: false));
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => MessageDetail()));
          },
          child: Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage('assets/images/student.png'),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  child: Text(
                                messageProject.otherFullname!,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              )),
                              Container(
                                  child: Text(
                                formatDate(
                                    messageProject.messages.last.createdAt),
                                style: TextStyle(fontSize: 15),
                              )),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              "Project: ",
                              style: TextStyle(fontSize: 15),
                            ),
                            Text(
                              messageProject.project.title!,
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text('${messageProject.messages.last.sender.fullname}: ',
                                style: TextStyle(fontSize: 15)),
                            Text(
                              messageProject.messages.last.content,
                              style: TextStyle(fontSize: 15),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ));
  }
}

String formatDate(DateTime dateTime) {
  // Lấy ngày, tháng và năm từ đối tượng DateTime
  String day = dateTime.day.toString().padLeft(2, '0');
  String month = dateTime.month.toString().padLeft(2, '0');
  String year = dateTime.year.toString();

  // Trả về chuỗi ngày/tháng/năm
  return '$day/$month/$year';
}
