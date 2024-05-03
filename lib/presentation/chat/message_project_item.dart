import 'dart:developer';

import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/domain/entity/message/message.dart';
import 'package:boilerplate/domain/entity/message/message_list.dart';
import 'package:boilerplate/presentation/chat/message_detail.dart';
import 'package:boilerplate/presentation/chat/store/message_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageProjectItem extends StatefulWidget {
  final MessageListItem messageListItem;
  final int index;
  const MessageProjectItem(
      {super.key, required this.messageListItem, required this.index});
  @override
  State<MessageProjectItem> createState() => _MessageProjectItemState();
}

class _MessageProjectItemState extends State<MessageProjectItem> {
  final MessageStore _messageStore = getIt<MessageStore>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        decoration: BoxDecoration(
          border: Border(
            // top: BorderSide(width: 1.0),
            bottom: BorderSide(width: 0.5, color: Colors.grey),
          ),
        ),
        child: InkWell(
          onTap: () {
            Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                builder: (context) => MessageDetail(
                      projectId: widget.messageListItem.project.id!,
                      receiverId: widget.messageListItem.receiver.id,
                      senderId: widget.messageListItem.sender.id,
                      index: widget.index,
                    ),
                maintainState: false));
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
                                formatDate(widget.messageListItem.createdAt),
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
                              widget.messageListItem.project.title!,
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text('${widget.messageListItem.sender.fullname}: ',
                                style: TextStyle(fontSize: 15)),
                            Text(
                              widget.messageListItem.content,
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
