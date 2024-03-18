import 'package:boilerplate/core/widgets/projects/list_project_company.dart';
import 'package:boilerplate/core/widgets/projects/project_company_item.dart';
import 'package:boilerplate/core/widgets/projects/submited_project_item.dart';
import 'package:boilerplate/core/widgets/toogle_filter.dart';
import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:flutter/material.dart';

class DashboardStudentScreen extends StatefulWidget {
  @override
  _DashboardStudentScreenState createState() => _DashboardStudentScreenState();
}

class _DashboardStudentScreenState extends State<DashboardStudentScreen> {
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
                      onPressed: () {
                        Navigator.pushNamed(context, '/project_post_1');
                      },
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
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Color(0xFF121212)
                      : Colors.yellow,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  "You have a new message",
                  style: TextStyle(fontSize: 15),
                ),
              ),
              SubmitedProjectItem(),
              SubmitedProjectItem(),
              SubmitedProjectItem(),
              SubmitedProjectItem(),
            ],
          )),
    )));
  }
}
