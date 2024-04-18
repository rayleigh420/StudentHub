import 'dart:developer';

import 'package:boilerplate/core/widgets/schedules/schedule_meet_modal.dart';
import 'package:boilerplate/presentation/meeting/meeting.dart';
import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// class ScheduleItemChat extends StatelessWidget {

// }

class ScheduleItemChat extends StatefulWidget {
  final isCancelled;
  final int? type;
  const ScheduleItemChat({super.key, this.type, this.isCancelled});

  @override
  State<ScheduleItemChat> createState() => _ScheduleItemChatState();
}

class _ScheduleItemChatState extends State<ScheduleItemChat> {
  bool isCancelled = false;
  @override
  void initState() {
    super.initState();
    isCancelled = widget.isCancelled;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        showCupertinoModalPopup(
            context: context,
            builder: (context) {
              return CupertinoActionSheet(
                title: Text("Reschedule or cancel meeting"),
                actions: [
                  CupertinoActionSheetAction(
                    onPressed: () {
                      // Navigator.of(context).pop();
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
                              print("hello");
                            },
                          );
                        },
                      );
                    },
                    child: Text("Re-schedule"),
                  ),
                  CupertinoActionSheetAction(
                    onPressed: () {
                      log("cancelled tapped");
                      setState(() {
                        isCancelled = true;
                      });
                      Navigator.of(context).pop();
                    },
                    child: Text("Cancel meeting",
                        style: TextStyle(color: Colors.grey)),
                  ),
                ],
                cancelButton: CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel", style: TextStyle(color: Colors.red)),
                ),
              );
            });
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(12, 16, 12, 12),
        // margin: EdgeInsets.fromLTRB(15, 0, 15, 15),
        width: DeviceUtils.getScaledWidth(context, 0.7),
        decoration: BoxDecoration(
          color: widget.type == 0 ? Color(0xfff0f0f0) : Colors.blueAccent,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Catchup meeting",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Text(
                  "60 minutes",
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Start time: Thursday 13/3/2024 15:00",
              style: TextStyle(fontSize: 13),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "End time: Thursday 13/3/2024 16:00",
              style: TextStyle(fontSize: 13),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MeetingScreen()));
                  },
                  child: Container(
                    // margin: EdgeInsets.only(right: 8),
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: isCancelled ? Colors.white : Colors.blueAccent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: isCancelled
                        ? Text(
                            "Meeting Cancelled",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.red, fontSize: 13),
                          )
                        : Text(
                            "Join",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 13),
                          ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
