import 'dart:developer';

import 'package:boilerplate/core/widgets/project_item.dart';
import 'package:boilerplate/core/widgets/projects/project_company_edit_modal.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/domain/entity/project_2/project.dart';
import 'package:boilerplate/domain/usecase/project/delete_company_project_usecase.dart';
import 'package:boilerplate/domain/usecase/project/update_company_project_usecase.dart';
import 'package:boilerplate/presentation/browse_project/store/project_company_store.dart';
import 'package:boilerplate/presentation/chat/store/message_store.dart';
import 'package:boilerplate/presentation/companyReview/hire_offer.dart';
import 'package:boilerplate/presentation/profile/store/profile_store.dart';
import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

// class Project {
//   final String name;
//   final String day;
//   final List<String> criteria;
//   final int proposals;
//   final int messages;
//   final int hired;

//   Project(
//       {required this.name,
//       required this.day,
//       required this.criteria,
//       required this.proposals,
//       required this.messages,
//       required this.hired});
// }

class ProjectItemCompany extends StatefulWidget {
  final Project project;

  ProjectItemCompany({required this.project});

  @override
  _ProjectItemCompanyState createState() => _ProjectItemCompanyState();
}

class _ProjectItemCompanyState extends State<ProjectItemCompany> {
  DeleteProjectsUseCase deleteProjectsUseCase = getIt<DeleteProjectsUseCase>();
  UpdateProjectsUseCase updateProjectsUseCase = getIt<UpdateProjectsUseCase>();
  final ProjectCompanyStore _projectCompanyStore = getIt<ProjectCompanyStore>();
  final MessageStore _messageStore = getIt<MessageStore>();
  final ProfileStore _profileStore = getIt<ProfileStore>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: false).push(MaterialPageRoute(
            builder: (context) =>
                HireOffer(project: widget.project, selected: 0),
            maintainState: false));
      },
      child: Container(
          margin: EdgeInsets.only(bottom: 20),
          decoration:
              BoxDecoration(border: Border(bottom: BorderSide(width: 1))),
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
                        widget.project.title!,
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "${dateDiff(DateTime.now(), widget.project.createdAt!).toString()} ${AppLocalizations.of(context).translate('days_ago_text')}",
                        style: TextStyle(fontSize: 13),
                      )
                    ],
                  ),
                  IconButton(
                      icon: Icon(Icons.more_vert),
                      onPressed: () {
                        buildModal(context);
                      })
                ],
              ),
              SizedBox(height: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)
                        .translate('student_looking_for_text'),
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    AppLocalizations.of(context)
                        .translate('every_student_text'),
                    style: TextStyle(fontSize: 14),
                  )
                  // if (widget.project.criteria.isNotEmpty)
                  //   ...widget.project.criteria
                  //       .map((criteria) => Text(
                  //             criteria,
                  //             style: TextStyle(fontSize: 14),
                  //           ))
                  //       .toList(),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.project.countProposals.toString()),
                      Text(
                        "Proposals",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.project.countMessages.toString()),
                      Text(
                        "Messages",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.project.countHired.toString()),
                      Text(
                        "Hired",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ],
              )
            ],
          )),
    );
  }

  void buildModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.assignment),
                  title: Text('View Proposals'),
                  onTap: () => {
                    Navigator.of(context, rootNavigator: false).push(
                        MaterialPageRoute(
                            builder: (context) =>
                                HireOffer(project: widget.project, selected: 0),
                            maintainState: false))
                  },
                ),
                ListTile(
                  leading: Icon(Icons.message),
                  title: Text('View messages'),
                  onTap: () => {
                    // _messageStore.newMessageListItem(
                    //     _profileStore.profile!.id, 1, widget.project)
                  },
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('View hired'),
                  onTap: () => {
                    Navigator.of(context, rootNavigator: false)
                        .push(MaterialPageRoute(
                            builder: (context) => HireOffer(
                                  project: widget.project,
                                  selected: 3,
                                ),
                            maintainState: false))
                  },
                ),
                ListTile(
                  leading: Icon(Icons.post_add),
                  title: Text('View Job posting'),
                  onTap: () => {
                    Navigator.of(context, rootNavigator: false)
                        .push(MaterialPageRoute(
                            builder: (context) => HireOffer(
                                  project: widget.project,
                                  selected: 1,
                                ),
                            maintainState: false))
                  },
                ),
                ListTile(
                  leading: Icon(Icons.edit),
                  title: Text('Edit posting'),
                  onTap: () {
                    showModalBottomSheet(
                      isDismissible: true,
                      context: context,
                      isScrollControlled: true,
                      useRootNavigator: true,
                      enableDrag: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return ProjectCompanyEditModal(
                          project: widget.project,
                        );
                      },
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.delete),
                  title: Text('Remove posting'),
                  // onTap: () => {
                  //   deleteProjectsUseCase.call(
                  //       params: widget.project.projectId!)
                  // },
                  onTap: () {
                    log(widget.project.id.toString());
                    _projectCompanyStore
                        .deleteCompanyProjects(widget.project.id!);
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.close),
                  title: Text('Archive posting'),
                  // onTap: () =>
                  //     {updateProjectsUseCase.call(params: widget.project)},
                  onTap: () {
                    Project newProject = widget.project;
                    newProject.typeFlag = 1;
                    _projectCompanyStore.updateCompanyProjects(newProject);
                  },
                ),
              ],
            ),
          );
        });
  }
}
