import 'package:boilerplate/core/widgets/appBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProjectPost3 extends StatefulWidget {
  @override
  _ProjectPost3State createState() => _ProjectPost3State();
}

class _ProjectPost3State extends State<ProjectPost3> {
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
                    "3/4 Next, provide project description",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Students are looking for",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
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
                        onPressed: () {},
                        child: const Text(
                            style: TextStyle(fontSize: 16),
                            "Review your post")),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
