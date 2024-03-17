import 'package:boilerplate/core/widgets/appBar.dart';
import 'package:flutter/material.dart';

class SubmitProject extends StatefulWidget {
  const SubmitProject({Key? key}) : super(key: key);

  @override
  _SubmitProjectState createState() => _SubmitProjectState();
}

class _SubmitProjectState extends State<SubmitProject> {
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
                    "Cover letter",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Describe why do you fit to this project",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 20,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                            onPressed: () {
                              // Navigator.pushNamed(context, '/project_post_4');
                            },
                            child: const Text(
                                style: TextStyle(fontSize: 16), "Cancel")),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                            onPressed: () {
                              // Navigator.pushNamed(context, '/project_post_4');
                            },
                            child: const Text(
                                style: TextStyle(fontSize: 16),
                                "Submit proposal")),
                      ),
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}
