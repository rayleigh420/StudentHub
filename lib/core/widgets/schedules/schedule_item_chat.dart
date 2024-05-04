import 'dart:developer';

import 'package:boilerplate/core/widgets/schedules/schedule_meet_modal.dart';
import 'package:boilerplate/domain/entity/message/interview.dart';
import 'package:boilerplate/presentation/meeting/meeting.dart';
import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// class ScheduleItemChat extends StatelessWidget {

// }

class ScheduleItemChat extends StatefulWidget {
  final Interview interview;
  final isCancelled;
  final int? type;
  final void Function(dynamic)? updateSchedule;
  final void Function(int)? deleteSchedule;
  const ScheduleItemChat(
      {super.key,
      this.type,
      this.isCancelled,
      required this.interview,
      this.updateSchedule,
      this.deleteSchedule});

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
        if (widget.type == 1) {
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
                              interview: widget.interview,
                              updateSchedule: (data) {
                                widget.updateSchedule!(data);
                              },
                              isUpdate: true,
                            );
                          },
                        );
                      },
                      child: Text("Re-schedule"),
                    ),
                    CupertinoActionSheetAction(
                      onPressed: () {
                        log("cancelled tapped");
                        widget.deleteSchedule!(widget.interview.id);
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
        }
        ;
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(12, 16, 12, 12),
        // margin: EdgeInsets.fromLTRB(15, 0, 15, 15),
        width: DeviceUtils.getScaledWidth(context, 0.7),
        decoration: BoxDecoration(
          color: Color(0xfff0f0f0),
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
                  widget.interview.title,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Text(
                  getTimeDifference(widget.interview.startTime,
                              widget.interview.endTime)
                          .toString() +
                      " minutes",
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Start time: " + formatDateTime(widget.interview.startTime),
              style: TextStyle(fontSize: 13),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "End time: " + formatDateTime(widget.interview.endTime),
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
                    widget.interview.disableFlag == 1
                        ? null
                        : Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute(
                                builder: (context) => MeetingScreen(),
                                maintainState: true));
                  },
                  child: Container(
                    // margin: EdgeInsets.only(right: 8),
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: widget.interview.disableFlag == 1
                          ? Colors.white
                          : Colors.blueAccent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: widget.interview.disableFlag == 1
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

int getTimeDifference(DateTime startTime, DateTime endTime) {
  return endTime.difference(startTime).inMinutes;
}

String formatDateTime(DateTime date) {
  return "${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}";
}
