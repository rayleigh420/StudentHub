import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/home/store/theme/theme_store.dart';
import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                    const Text("Title"),
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
          width: DeviceUtils.getScaledWidth(context, 0.4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Start Date"),
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
                        child: Column(
                          children: [
                            CupertinoDatePicker(
                              mode: CupertinoDatePickerMode.date,
                              initialDateTime: DateTime.now(),
                              onDateTimeChanged: (DateTime dateTime) {
                                setState(() {
                                  selectedStartDate = dateTime;
                                });
                              },
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
            },
            child: Icon(
              Icons.cancel,
              color: _themeStore.darkMode ? Colors.white : Colors.black,
            ),
          ),
          GestureDetector(
            onTap: () {
              // Handle confirm action
            },
            child: Icon(
              Icons.check,
              color: _themeStore.darkMode ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
