import 'package:boilerplate/core/widgets/appBar.dart';
import 'package:boilerplate/presentation/project/company/project_post_3.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProjectPost2 extends StatefulWidget {
  final String? title;
  ProjectPost2({this.title});
  @override
  _ProjectPost2State createState() => _ProjectPost2State();
}

class _ProjectPost2State extends State<ProjectPost2> {
  final List<String> _time = ["One to three months", "Three to six months"];
  final List<int> _timeValue = [0, 1];
  int scopeType = 0;
  final TextEditingController _studentNumberController =
      TextEditingController();
  String? time = '1 to 3 months';
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
                    "2/4 Next, estimate the scope of your job",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Consider the size of your project and the timeline",
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "How long will your project take?",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 10),
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
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "How many students do you want for this project?",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: _studentNumberController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                      hintText: 'Number of students',
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
                          if (_studentNumberController.text.isNotEmpty &&
                                  scopeType == 0 ||
                              scopeType == 1) {
                            Navigator.of(context, rootNavigator: true).push(
                                MaterialPageRoute(
                                    builder: (context) => ProjectPost3(
                                        title: widget.title,
                                        scopeType: scopeType,
                                        studentNumber: int.parse(
                                            _studentNumberController.text)),
                                    maintainState: false));
                          }
                          ;
                          // Navigator.pushNamed(context, '/project_post_3');
                        },
                        child: const Text(
                            style: TextStyle(fontSize: 16),
                            "Next: Description")),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
