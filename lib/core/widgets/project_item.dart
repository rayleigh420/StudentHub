import 'package:boilerplate/core/widgets/project_modal.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/domain/entity/project_2/project.dart';
import 'package:boilerplate/domain/usecase/favorite/add_favorite_by_student_id.dart';
import 'package:boilerplate/domain/usecase/favorite/get_favorite_by_student_id.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
// import 'package:boilerplate/domain/entity/project/project.dart';

import 'package:flutter/material.dart';

class ProjectItem extends StatefulWidget {
  const ProjectItem({super.key, required this.projDat});
  final Project projDat;
  @override
  State<ProjectItem> createState() => _ProjectItemState();
}

class _ProjectItemState extends State<ProjectItem> {
  AddFavoriteByStudentIdUseCase _addFavoriteByStudentIdUseCase =
      getIt<AddFavoriteByStudentIdUseCase>();

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
                            "${AppLocalizations.of(context).translate("created_at_text")} ${dateDiff(DateTime.now(), widget.projDat.createdAt!)} ${AppLocalizations.of(context).translate("days_ago_text")}",
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
                            "${widget.projDat.projectScopeFlag == 0 ? AppLocalizations.of(context).translate("one_to_three_months") : AppLocalizations.of(context).translate("three_to_six_months")}",
                            style:
                                TextStyle(fontSize: 13, color: Colors.black)),
                        Text(", ",
                            style:
                                TextStyle(fontSize: 13, color: Colors.black)),
                        Text(
                            "${widget.projDat.numberOfStudents} ${widget.projDat.numberOfStudents! > 1 ? AppLocalizations.of(context).translate("students_text") : AppLocalizations.of(context).translate("student_text")}",
                            style:
                                TextStyle(fontSize: 13, color: Colors.black)),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                        AppLocalizations.of(context)
                            .translate("student_looking_for_text"),
                        style: TextStyle(fontSize: 13, color: Colors.black)),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 5.0),
                          child: Text(
                              "${widget.projDat.description != null ? "-   ${AppLocalizations.of(context).translate("student_description_text")} ${widget.projDat.description!}" : AppLocalizations.of(context).translate("every_student_text")}",
                              style:
                                  TextStyle(fontSize: 13, color: Colors.black)),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                        "Proposals: ${widget.projDat.countProposals} proposals",
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
        _addFavoriteByStudentIdUseCase.call(
            params: AddProjectParams(
                projectId: widget.projDat.projectId != null
                    ? widget.projDat.projectId!
                    : widget.projDat.id!,
                disableFlag: widget.projDat.isFavorite! ? 1 : 0));
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
