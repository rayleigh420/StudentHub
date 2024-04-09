import 'package:boilerplate/core/widgets/project_item.dart';
import 'package:boilerplate/domain/entity/project_2/project.dart';

import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:flutter/material.dart';

final data = {
  "title": "Senior frontend developer (Fintech)",
  "props": [
    "Students are looking for",
    "Clear expectation about your project or deliverables",
    "React",
    "Redux",
    "TypeScript",
    "GraphQL",
    "Node.js",
    "AWS",
  ],
  "scopeFrom": 1,
  "scopeFrom2": "month",
  "scopeTo": 3,
  "scopeTo2": "months",
  "quantityRequired": "6",
  "createdDate": DateTime.now().add(Duration(days: -3)),
  "proposal": 6
};
final projDat = Project.fromJson({
  "id": 25,
  "createdAt": "2024-04-08T11:10:58.223Z",
  "updatedAt": "2024-04-08T11:10:58.223Z",
  "deletedAt": null,
  "companyId": "31",
  "projectScopeFlag": 0,
  "title": "Backend dev",
  "description": "Node",
  "numberOfStudents": 5,
  "typeFlag": 0,
  "proposals": [],
  "countProposals": 0,
  "countMessages": 0,
  "countHired": 0
});

class SavedProject extends StatefulWidget {
  const SavedProject({super.key});

  @override
  State<SavedProject> createState() => _SavedProjectState();
}

class _SavedProjectState extends State<SavedProject> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text("Saved Project"),
            ),
            body: Container(
                child: Column(
              children: [
                Expanded(
                  // height: DeviceUtils.getScaledHeight(context, 0.7),
                  child: CustomScrollView(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    slivers: [
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 16,
                            ),
                            const Text("Saved Project",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            const SizedBox(
                              height: 16,
                            ),
                            ProjectItem(projDat: projDat),
                            ProjectItem(projDat: projDat),
                            ProjectItem(projDat: projDat),
                            ProjectItem(projDat: projDat),
                            ProjectItem(projDat: projDat),
                            ProjectItem(projDat: projDat),

                            const SizedBox(
                              height: 16,
                            )
                            // buildProjectItem()
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ))));
    ;
  }
}
