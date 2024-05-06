import 'dart:developer';

import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/domain/entity/message/interview.dart';
import 'package:boilerplate/presentation/home/store/theme/theme_store.dart';
import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/utils/time/getDurationFromDateTime.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScheduleMeetingModal extends StatefulWidget {
  final void Function(dynamic)? newSchedule;
  final void Function(dynamic)? updateSchedule;
  final bool isUpdate;
  final Interview? interview;
  const ScheduleMeetingModal(
      {super.key,
      this.newSchedule,
      this.updateSchedule,
      this.interview,
      required this.isUpdate});

  @override
  State<ScheduleMeetingModal> createState() => _ScheduleMeetingModalState();
}

class _ScheduleMeetingModalState extends State<ScheduleMeetingModal> {
  DateTime selectedStartDate = DateTime.now();
  DateTime selectedStartTime = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  DateTime selectedEndTime = DateTime.now();
  final TextEditingController _titleController = new TextEditingController();
  final FocusNode fcNode = FocusNode();
  final ThemeStore _themeStore = getIt<ThemeStore>();
  @override
  void initState() {
    super.initState();
    fcNode.requestFocus();
    _titleController.text = widget.interview?.title ?? "";
    selectedStartDate = widget.interview?.startTime ?? DateTime.now();
    selectedStartTime = widget.interview?.startTime ?? DateTime.now();
    selectedEndDate = widget.interview?.endTime ?? DateTime.now();
    selectedEndTime = widget.interview?.endTime ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        child: Wrap(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                        color: _themeStore.darkMode
                            ? Colors.white
                            : Colors.transparent)),
                color: _themeStore.darkMode ? Color(0xff2E3239) : Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              width: DeviceUtils.getScaledWidth(context, 1),
              // height: DeviceUtils.getScaledHeight(context, 0.5),
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(AppLocalizations.of(context)
                        .translate('schedule_video_call_text')),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(AppLocalizations.of(context).translate('title_text')),
                    const SizedBox(
                      height: 16,
                    ),
                    TextField(
                      controller: _titleController,
                      focusNode: fcNode,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)
                            .translate('enter_title_hint_text'),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    buildPickStartTime(context),
                    const SizedBox(
                      height: 20,
                    ),
                    buildPickEndTime(context),
                    const SizedBox(
                      height: 20,
                    ),
                    buildButtons(context),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildPickStartTime(BuildContext context) {
    return Row(
      children: [
        Container(
          width: DeviceUtils.getScaledWidth(context, 0.9),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppLocalizations.of(context).translate('start_date_text')),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isDismissible: true,
                        isScrollControlled: true,
                        useRootNavigator: true,
                        enableDrag: true,
                        builder: (context) {
                          return Container(
                            height: DeviceUtils.getScaledHeight(context, 0.4),
                            child: Column(
                              children: [
                                buildTopBar(context),
                                Expanded(
                                  child: Container(
                                    height: DeviceUtils.getScaledHeight(
                                        context, 0.25),
                                    width:
                                        DeviceUtils.getScaledWidth(context, 1),
                                    decoration: BoxDecoration(
                                      color: _themeStore.darkMode
                                          ? Color(0xff2E3239)
                                          : Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                    child: CupertinoDatePicker(
                                      use24hFormat: true,
                                      showDayOfWeek: true,
                                      mode: CupertinoDatePickerMode.date,
                                      initialDateTime: selectedStartDate,
                                      onDateTimeChanged: (DateTime dateTime) {
                                        setState(() {
                                          selectedStartDate = dateTime;
                                        });
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "${selectedStartDate.toLocal()}".split(' ')[0],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Icon(Icons.calendar_today_outlined),
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isDismissible: true,
                        isScrollControlled: true,
                        useRootNavigator: true,
                        enableDrag: true,
                        builder: (context) {
                          return Container(
                            height: DeviceUtils.getScaledHeight(context, 0.4),
                            child: Column(
                              children: [
                                buildTopBar(context),
                                Expanded(
                                  child: Container(
                                    height: DeviceUtils.getScaledHeight(
                                        context, 0.25),
                                    width:
                                        DeviceUtils.getScaledWidth(context, 1),
                                    decoration: BoxDecoration(
                                      color: _themeStore.darkMode
                                          ? Color(0xff2E3239)
                                          : Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                    child: CupertinoTimerPicker(
                                      onTimerDurationChanged: (value) {
                                        setState(() {
                                          selectedStartTime =
                                              selectedStartDate.add(value);
                                        });
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "${DateFormat('HH:mm:ss').format(selectedStartTime)}",
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget buildPickEndTime(BuildContext context) {
    return Row(
      children: [
        Container(
          width: DeviceUtils.getScaledWidth(context, 0.9),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppLocalizations.of(context).translate('end_date_text')),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isDismissible: true,
                        isScrollControlled: true,
                        useRootNavigator: true,
                        enableDrag: true,
                        builder: (context) {
                          return Container(
                            height: DeviceUtils.getScaledHeight(context, 0.4),
                            child: Column(
                              children: [
                                buildTopBar(context),
                                Expanded(
                                  child: Container(
                                    height: DeviceUtils.getScaledHeight(
                                        context, 0.25),
                                    width:
                                        DeviceUtils.getScaledWidth(context, 1),
                                    decoration: BoxDecoration(
                                      color: _themeStore.darkMode
                                          ? Color(0xff2E3239)
                                          : Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                    child: CupertinoDatePicker(
                                      use24hFormat: true,
                                      showDayOfWeek: true,
                                      mode: CupertinoDatePickerMode.date,
                                      initialDateTime: DateTime.now(),
                                      onDateTimeChanged: (DateTime dateTime) {
                                        setState(() {
                                          selectedEndDate = dateTime;
                                        });
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "${selectedEndDate.toLocal()}".split(' ')[0],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Icon(Icons.calendar_today_outlined),
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isDismissible: true,
                        isScrollControlled: true,
                        useRootNavigator: true,
                        enableDrag: true,
                        builder: (context) {
                          return Container(
                            height: DeviceUtils.getScaledHeight(context, 0.4),
                            child: Column(
                              children: [
                                buildTopBar(context),
                                Expanded(
                                  child: Container(
                                    height: DeviceUtils.getScaledHeight(
                                        context, 0.25),
                                    width:
                                        DeviceUtils.getScaledWidth(context, 1),
                                    decoration: BoxDecoration(
                                      color: _themeStore.darkMode
                                          ? Color(0xff2E3239)
                                          : Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                      ),
                                    ),
                                    child: CupertinoTimerPicker(
                                      onTimerDurationChanged: (value) {
                                        setState(() {
                                          selectedEndTime =
                                              selectedEndDate.add(value);
                                        });
                                        log(selectedEndTime.toIso8601String()
                                            as String);
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "${DateFormat('HH:mm:ss').format(selectedEndTime)}",
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget buildTopBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: _themeStore.darkMode ? Color(0xff2E3239) : Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
              onTap: () {
                // Handle cancel action
                Navigator.of(context).pop();
              },
              child: Text(
                AppLocalizations.of(context).translate('cancel_text'),
                style: TextStyle(
                  color: Colors.red,
                ),
              )),
          GestureDetector(
            onTap: () {
              // Handle confirm action
              Navigator.of(context).pop();
            },
            child: Text(
              AppLocalizations.of(context).translate('save_text'),
              style: TextStyle(
                color: Colors.blueAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildButtons(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey)),
      ),
      width: DeviceUtils.getScaledWidth(context, 1),
      padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              alignment: Alignment.center,
              height: DeviceUtils.getScaledHeight(context, 0.034),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
                // border: Border(top: BorderSide(color: )),
              ),
              width: DeviceUtils.getScaledWidth(context, 0.4),
              child: Text(
                "Cancel",
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (!widget.isUpdate!) {
                dynamic data = {
                  "title": _titleController.text,
                  "content": _titleController.text,
                  "startTime": selectedStartTime.toIso8601String().toString(),
                  "endTime": selectedEndTime.toIso8601String().toString(),
                };
                log("data từ schedule meet modal: " + data.toString());
                widget.newSchedule!(data);
                Navigator.of(context).pop();
                // Navigator.of(context).pop();
              } else {
                dynamic data = {
                  "id": widget.interview!.id,
                  "title": _titleController.text,
                  "startTime": selectedStartTime.toIso8601String().toString(),
                  "endTime": selectedEndTime.toIso8601String().toString(),
                };
                log("data từ schedule meet modal update: " + data.toString());
                widget.updateSchedule!(data);
                Navigator.of(context).pop();
                // Navigator.of(context).pop();
              }
            },
            child: Container(
              alignment: Alignment.center,
              height: DeviceUtils.getScaledHeight(context, 0.034),
              decoration: BoxDecoration(
                // color: Colors.blueAccent,
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              width: DeviceUtils.getScaledWidth(context, 0.4),
              child: Text(
                widget.isUpdate ? AppLocalizations.of(context).translate('update_text') : AppLocalizations.of(context).translate('new_invite_text'),
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
