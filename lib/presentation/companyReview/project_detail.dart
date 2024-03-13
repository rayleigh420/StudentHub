
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:boilerplate/core/widgets/toggle_button.dart';


class ProjectDetail extends StatefulWidget {
  @override
  _ProjectDetailState createState() => _ProjectDetailState();
}

class _ProjectDetailState extends State<ProjectDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
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
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Text(
                      "Senior frontend developer (Fintech)",
                      style: TextStyle(fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.green.shade900),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                   Container(
                      margin: EdgeInsets.only(top: 20),
                      child: ToggleButtonsCompanyDetail(),
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
                        Icons.access_alarm,
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
                            "- 3 to 6 month",
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
                        Icons.people,
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
                            "- 6 students",
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
                                borderRadius: BorderRadius.circular(5),
                                side: BorderSide(color: Colors.black))),
                        onPressed: () {},
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