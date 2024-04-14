import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/domain/entity/project_2/project.dart';
import 'package:boilerplate/presentation/browse_project/store/project_company_store.dart';
import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class ProjectCompanyEditModal extends StatefulWidget {
  final Project project;
  const ProjectCompanyEditModal({super.key, required this.project});
  @override
  State<ProjectCompanyEditModal> createState() =>
      _ProjectCompanyEditModalState();
}

class _ProjectCompanyEditModalState extends State<ProjectCompanyEditModal> {
  TextEditingController _titleController = new TextEditingController();
  TextEditingController _descriptionController = new TextEditingController();
  TextEditingController _numberOfStudentsController =
      new TextEditingController();
  final List<String> _time = ["One to three months", "Three to six months"];
  final List<int> _timeValue = [0, 1];
  final ProjectCompanyStore _projectCompanyStore = getIt<ProjectCompanyStore>();
  late Project projectDat;
  late int scopeType;
  @override
  void initState() {
    super.initState();
    _titleController.text = widget.project.title!;
    _descriptionController.text = widget.project.description!;
    _numberOfStudentsController.text =
        widget.project.numberOfStudents.toString();
    projectDat = widget.project;
    scopeType = projectDat.projectScopeFlag!;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _numberOfStudentsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      width: DeviceUtils.getScaledWidth(context, 1),
      height: DeviceUtils.getScaledHeight(context, 0.8),
      child: Container(
        child: Column(
          children: [
            CupertinoNavigationBar(
              border: Border.all(color: Colors.transparent),
              backgroundColor: Colors.white,
              leading: CupertinoButton(
                padding: const EdgeInsets.all(0),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel',
                    style: TextStyle(color: Color(0xFFD1453A), fontSize: 16)),
              ),
              middle: const Text("Edit Project",
                  style: TextStyle(color: Colors.black, fontSize: 16)),
              trailing: CupertinoButton(
                padding: const EdgeInsets.all(0),
                onPressed: () {
                  _projectCompanyStore.updateCompanyProjects(Project(
                    id: projectDat.id,
                    title: _titleController.text,
                    description: _descriptionController.text,
                    numberOfStudents:
                        int.parse(_numberOfStudentsController.text),
                    projectScopeFlag: scopeType,
                    typeFlag: projectDat.typeFlag,
                  ));
                  Navigator.pop(context);
                },
                child: const Text('Save',
                    style: TextStyle(color: Colors.blueAccent, fontSize: 16)),
              ),
            ),
            Expanded(
              child: Container(
                  margin: EdgeInsets.only(top: 20),
                  width: DeviceUtils.getScaledWidth(context, 1),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: const Text(
                            "Title ",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                          width: DeviceUtils.getScaledWidth(context, 1) * 1,
                          height:
                              DeviceUtils.getScaledHeight(context, 1) * 0.06,
                          padding: EdgeInsets.all(
                              DeviceUtils.getScaledWidth(context, 1) * 0.03),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.white,
                              border: Border.all(color: Colors.grey)),
                          child: Center(
                            child: TextField(
                              controller: _titleController,
                              decoration: InputDecoration.collapsed(
                                  hintText: 'abc@email.com',
                                  hintStyle: TextStyle(color: Colors.grey)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: const Text(
                            "Description ",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                          width: DeviceUtils.getScaledWidth(context, 1) * 1,
                          height:
                              DeviceUtils.getScaledHeight(context, 1) * 0.06,
                          padding: EdgeInsets.all(
                              DeviceUtils.getScaledWidth(context, 1) * 0.03),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.white,
                              border: Border.all(color: Colors.grey)),
                          child: Center(
                            child: TextField(
                              controller: _descriptionController,
                              decoration: InputDecoration.collapsed(
                                  hintText: 'abc@email.com',
                                  hintStyle: TextStyle(color: Colors.grey)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: const Text(
                            "Number of student ",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10, left: 20, right: 20),
                          width: DeviceUtils.getScaledWidth(context, 1) * 1,
                          height:
                              DeviceUtils.getScaledHeight(context, 1) * 0.06,
                          padding: EdgeInsets.all(
                              DeviceUtils.getScaledWidth(context, 1) * 0.03),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: Colors.white,
                              border: Border.all(color: Colors.grey)),
                          child: Center(
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: _numberOfStudentsController,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: InputDecoration.collapsed(
                                  hintText: 'at least 1',
                                  hintStyle: TextStyle(color: Colors.grey)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: const Text(
                            "Scope ",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ..._timeValue.map((size) {
                          return RadioListTile<int>(
                              title: Text(_time[size]),
                              value: size,
                              groupValue: _timeValue.indexOf(scopeType),
                              onChanged: (int? value) {
                                setState(() {
                                  scopeType = value!;
                                });
                              });
                        }),
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
