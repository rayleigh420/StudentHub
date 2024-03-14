import 'package:boilerplate/core/widgets/projects/list_project.dart';
import 'package:boilerplate/core/widgets/projects/projectItem.dart';
import 'package:boilerplate/core/widgets/toogle_filter.dart';
import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:flutter/material.dart';

class DashBoardScreen extends StatefulWidget {
  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.fromLTRB(18, 10, 20, 0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                      style: TextStyle(fontWeight: FontWeight.w600),
                      "Your Projects"),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5))),
                      onPressed: () {},
                      child: const Text(
                          style: TextStyle(fontSize: 16), "Post a job")),
                ],
              ),
              // Row(
              //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   mainAxisSize: MainAxisSize.min,
              //   children: [
              //   ],
              // ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: FilterButtons(),
              ),
              // ProjectItem(),
              ListProject(),
              Container(
                margin: EdgeInsets.only(
                    top: DeviceUtils.getScaledHeight(context, 0.35)),
                child: Center(
                    child: Column(
                  children: [
                    const Text(
                        style: TextStyle(fontWeight: FontWeight.w500),
                        "Welcome Duy!"),
                    const Text(
                        style: TextStyle(fontWeight: FontWeight.w500),
                        "You have no jobs!"),
                  ],
                )),
              ),
            ],
          )),
    )));
  }
}
