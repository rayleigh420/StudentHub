import 'package:boilerplate/core/widgets/appBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProjectPost2 extends StatefulWidget {
  @override
  _ProjectPost2State createState() => _ProjectPost2State();
}

class _ProjectPost2State extends State<ProjectPost2> {
  final List<String> _time = ['1 to 3 months', '3 to 6 months'];
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
                  ..._time.map((size) {
                    return RadioListTile<String>(
                      title: Text(size),
                      value: size,
                      groupValue: time,
                      onChanged: (String? value) {
                        setState(() {
                          time = value;
                        });
                      },
                    );
                  }).toList(),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "How many students do you want for this project?",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 10),
                  TextField(
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
                          Navigator.pushNamed(context, '/project_post_3');
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
