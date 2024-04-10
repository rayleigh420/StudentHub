import 'package:boilerplate/core/widgets/project_modal.dart';
import 'package:boilerplate/domain/entity/project_2/project.dart';
// import 'package:boilerplate/domain/entity/project/project.dart';

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
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          isDismissible: true,
          context: context,
          isScrollControlled: true,
          useRootNavigator: true,
          enableDrag: true,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return ProjectModal(
              project: widget.projDat,
            );
          },
        );
      },
      child: Container(
          padding: EdgeInsets.fromLTRB(12, 16, 8, 16),
          margin: EdgeInsets.fromLTRB(15, 0, 15, 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 2,
                offset: Offset(0, 2), // changes position of shadow
              ),
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
                    widget.projDat.createdAt != null
                        ? Text(
                            "Created ${dateDiff(DateTime.now(), widget.projDat.createdAt!)} days ago",
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          )
                        : Container(),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.projDat.title!,
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
                            // "${widget.projDat.scopeFrom} ${widget.projDat.scopeFrom2} - ${widget.projDat.scopeTo} ${widget.projDat.scopeTo2}",
                            "${widget.projDat.projectScopeFlag == 0 ? "One to three months" : "Three to six months"}",
                            style:
                                TextStyle(fontSize: 13, color: Colors.black)),
                        Text(", ",
                            style:
                                TextStyle(fontSize: 13, color: Colors.black)),
                        Text(
                            "${widget.projDat.numberOfStudents} ${widget.projDat.numberOfStudents! > 1 ? "students" : "student"}",
                            style:
                                TextStyle(fontSize: 13, color: Colors.black)),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text("Student are looking for",
                        style: TextStyle(fontSize: 13, color: Colors.black)),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 5.0),
                          child: Text(
                              "${widget.projDat.description != null ? "-   Student who can ${widget.projDat.description!}" : "Everyone"}",
                              style:
                                  TextStyle(fontSize: 13, color: Colors.black)),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text("Proposals: 0 proposals",
                        // "Proposals: ${widget.projDat.proposals != null ? widget.projDat.proposals : 0} proposals",
                        style: TextStyle(fontSize: 13, color: Colors.black)),
                  ],
                ),
              ),
              Expanded(
                child: buildFavorite(context),
              ),
            ],
          )),
    );
  }

  Widget buildFavorite(BuildContext context) {
    Widget content;
    if (widget.projDat.isFavorite != false) {
      content = Container(
        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Icon(Icons.favorite, color: Color(0xFFF9187F), size: 25),
      );
    } else {
      content = Container(
        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Icon(Icons.favorite_border, color: Colors.grey, size: 25),
      );
    }
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.projDat.isFavorite = !widget.projDat.isFavorite!;
        });
      },
      child: content,
    );
  }
}

int dateDiff(DateTime date1, DateTime date2) {
  Duration difference = date1.difference(date2);
  return difference.inDays;
}
