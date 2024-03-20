import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/home/store/theme/theme_store.dart';
import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:boilerplate/utils/time/getDurationFromDateTime.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScheduleMeetingModal extends StatefulWidget {
  const ScheduleMeetingModal({super.key});

  @override
  State<ScheduleMeetingModal> createState() => _ScheduleMeetingModalState();
}

class _ScheduleMeetingModalState extends State<ScheduleMeetingModal> {
  DateTime selectedStartDate = DateTime.now();
  DateTime selectedStartTime = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  DateTime selectedEndTime = DateTime.now();
  final FocusNode fcNode = FocusNode();
  final ThemeStore _themeStore = getIt<ThemeStore>();
  @override
  void initState() {
    super.initState();
    fcNode.requestFocus();
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
                    const Text("Schedule a video call interview "),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("Title"),
                    const SizedBox(
                      height: 16,
                    ),
                    TextField(
                      focusNode: fcNode,
                      decoration: InputDecoration(
                        hintText: "Enter title",
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
              const Text("Start Date"),
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
                                      initialTimerDuration:
                                          TimeUtil.getDurationFromDateTime(
                                              selectedStartDate),
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
              const Text("End Date"),
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
                                      initialTimerDuration:
                                          TimeUtil.getDurationFromDateTime(
                                              selectedStartDate),
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
                "Cancel",
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
              "Save",
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
            onTap: () {},
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
          Container(
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
              "Send Invite",
              textAlign: TextAlign.center,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
