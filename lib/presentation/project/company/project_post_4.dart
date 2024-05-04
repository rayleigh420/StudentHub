import 'dart:developer';

import 'package:boilerplate/core/widgets/appBar.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/browse_project/store/project_company_store.dart';
import 'package:boilerplate/presentation/navigations/bottomNavigationBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProjectPost4 extends StatefulWidget {
  final String? title;
  final int? scopeType;
  final int? studentNumber;
  final String? describeProject;
  ProjectPost4(
      {this.title, this.scopeType, this.studentNumber, this.describeProject});
  @override
  _ProjectPost4State createState() => _ProjectPost4State();
}

class _ProjectPost4State extends State<ProjectPost4> {
  final ProjectCompanyStore _projectCompanyStore = getIt<ProjectCompanyStore>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarItem(),
      body: SafeArea(
        child: Container(
            padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
            child: GestureDetector(
              onTap: () {
                final currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "4/4 Project details",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    widget.title!,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 1.0),
                          top: BorderSide(width: 1.0)),
                    ),
                    child: Wrap(
                      children: [
                        Text(
                          "Students are looking for",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          "- Clear expectation about your project or deliverables",
                          style: TextStyle(fontSize: 14),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "- The skills required for your project",
                          style: TextStyle(fontSize: 14),
                        ),
                        Text(
                          "- Detail about your project",
                          style: TextStyle(fontSize: 14),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.timer,
                        size: 30,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Project scope"),
                          Text(
                            "- ${widget.scopeType == 0 ? "One to Three Months" : "Three to Six Months"}",
                            style: TextStyle(fontSize: 14),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.person,
                        size: 30,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Student required:"),
                          Text(
                            "- ${widget.studentNumber} students",
                            style: TextStyle(fontSize: 14),
                          )
                        ],
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5))),
                        onPressed: () {
                          log("${widget.title} ${widget.scopeType} ${widget.studentNumber} ${widget.describeProject}");
                          _projectCompanyStore.postCompanyProjects(
                              widget.title!,
                              widget.scopeType!,
                              widget.studentNumber!,
                              widget.describeProject!);
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (context) => AppBottomNavigationBar(
                                        selectedIndex: 2,
                                      )));
                        },
                        child: const Text(
                            style: TextStyle(fontSize: 16), "Post job")),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
