import 'package:boilerplate/domain/entity/project/project.dart';
import 'package:flutter/material.dart';

class ProjectItem extends StatefulWidget {
  const ProjectItem({super.key, required this.projDat});
  final Project projDat;
  @override
  State<ProjectItem> createState() => _ProjectItemState();
}

class _ProjectItemState extends State<ProjectItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(8,16,8,16),
        margin: EdgeInsets.fromLTRB(15,0,15,0),
        decoration: BoxDecoration(
          border: Border(
              // top: BorderSide(color: Colors.grey),
              bottom: BorderSide(color: Colors.grey)),
          // borderRadius: BorderRadius.circular(8),
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
                    "Created ${dateDiff(DateTime.now(), widget.projDat.createdDate!)} days ago",
                    style: TextStyle(fontSize: 12),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.projDat.title,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                          "${widget.projDat.scopeFrom} ${widget.projDat.scopeFrom2} - ${widget.projDat.scopeTo} ${widget.projDat.scopeTo2}",
                          style: TextStyle(fontSize: 13)),
                      Text(", ", style: TextStyle(fontSize: 13)),
                      Text(
                          "${widget.projDat.quantityRequired != null ? widget.projDat.quantityRequired : 0}  students",
                          style: TextStyle(fontSize: 13)),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text("Student are looking for",
                      style: TextStyle(fontSize: 13)),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 5.0),
                        child: Text("-   ${widget.projDat.props[index]}",
                            style: TextStyle(fontSize: 13)),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text("Proposals: ${widget.projDat.proposal} proposals",
                      style: TextStyle(fontSize: 13)),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child:
                    Icon(Icons.favorite_border, color: Colors.grey, size: 25),
              ),
            ),
          ],
        ));
  }
}

int dateDiff(DateTime date1, DateTime date2) {
  Duration difference = date1.difference(date2);
  return difference.inDays;
}
