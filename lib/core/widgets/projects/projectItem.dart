import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Project {
  final String name;
  final String day;
  final List<String> criteria;
  final int proposals;
  final int messages;
  final int hired;

  Project(
      {required this.name,
      required this.day,
      required this.criteria,
      required this.proposals,
      required this.messages,
      required this.hired});
}

class ProjectItem extends StatefulWidget {
  final Project project;

  ProjectItem({required this.project});

  @override
  _ProjectItemState createState() => _ProjectItemState();
}

class _ProjectItemState extends State<ProjectItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1))),
        padding: EdgeInsets.only(bottom: 17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.project.name,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      widget.project.day,
                      style: TextStyle(fontSize: 13),
                    )
                  ],
                ),
                Icon(Icons.more_vert)
              ],
            ),
            SizedBox(height: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Students are looking for",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                if (widget.project.criteria.isNotEmpty)
                  ...widget.project.criteria
                      .map((criteria) => Text(
                            criteria,
                            style: TextStyle(fontSize: 14),
                          ))
                      .toList(),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("0"),
                    Text(
                      "Proposals",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("2"),
                    Text(
                      "Messages",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("8"),
                    Text(
                      "Hired",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    )
                  ],
                ),
              ],
            )
          ],
        ));
  }
}
