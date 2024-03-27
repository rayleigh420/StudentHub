import 'package:flutter/material.dart';

class SubmitedProjectItem extends StatefulWidget {
  @override
  _SubmitedProjectItemState createState() => _SubmitedProjectItemState();
}

class _SubmitedProjectItemState extends State<SubmitedProjectItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(12, 16, 8, 16),
        margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? Color(0xFF2e3239)
              : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey, width: 0.6),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              offset: Offset(0, 2),
              spreadRadius: 2,
              blurRadius: 2,
            )
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // decoration: BoxDecoration(
              //   border: Border.all(color: Colors.grey),
              //   borderRadius: BorderRadius.circular(8),
              // ),
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Senior frontend developer (Fintech)",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Submitted 3 days ago",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text("Student are looking for",
                      style: TextStyle(fontSize: 13)),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 5.0),
                        child: Text(
                            "-   Clear expectation about your project or deliverables",
                            style: TextStyle(fontSize: 13)),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
