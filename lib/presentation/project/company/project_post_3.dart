import 'package:boilerplate/core/widgets/appBar.dart';
import 'package:boilerplate/presentation/project/company/project_post_4.dart';
import 'package:boilerplate/utils/device/device_utils.dart';

import 'package:flutter/material.dart';

class ProjectPost3 extends StatefulWidget {
  final String? title;
  final int? scopeType;
  final int? studentNumber;
  // final scopeType = ['1 to 3 months', '3 to 6 months'];
  ProjectPost3({this.title, this.scopeType, this.studentNumber});
  @override
  _ProjectPost3State createState() => _ProjectPost3State();
}

class _ProjectPost3State extends State<ProjectPost3> {
  final TextEditingController _projectDescriptionController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarItem(),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
              padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
              height: MediaQuery.of(context).size.height * 1,
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
                      "3/4 Next, provide project description",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Students are looking for",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15, top: 5),
                      child: Wrap(
                        children: [
                          Text(
                            "- Clear expectation about your project or deliverables",
                            style: TextStyle(fontSize: 14),
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
                    Text(
                      "Describe your project",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: _projectDescriptionController,
                      onTapOutside: (event) {
                        DeviceUtils.hideKeyboard(context);
                      },
                      maxLines: 10,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                          width: 3,
                        )),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5))),
                          onPressed: () {
                            // Navigator.pushNamed(context, '/project_post_4');
                            Navigator.of(context, rootNavigator: true)
                                .push(MaterialPageRoute(
                                    builder: (context) => ProjectPost4(
                                          title: widget.title,
                                          scopeType: widget.scopeType,
                                          studentNumber: widget.studentNumber,
                                          describeProject:
                                              _projectDescriptionController
                                                  .text,
                                        ),
                                    maintainState: false));
                          },
                          child: const Text(
                              style: TextStyle(fontSize: 16),
                              "Review your post")),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
