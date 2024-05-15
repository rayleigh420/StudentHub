import 'dart:developer';

import 'package:boilerplate/core/widgets/projects/list_project_company.dart';
import 'package:boilerplate/core/widgets/projects/project_company_item.dart';
import 'package:boilerplate/core/widgets/projects/submited_project_item.dart';
import 'package:boilerplate/core/widgets/toogle_filter.dart';
import 'package:boilerplate/core/widgets/toggle_button.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/domain/entity/project_2/project.dart';
import 'package:boilerplate/domain/entity/proposal/itemProposal.dart';
import 'package:boilerplate/domain/usecase/proposal/get_proposal_student.dart';
import 'package:boilerplate/presentation/browse_project/store/project_store.dart';
import 'package:boilerplate/presentation/project/company/project_post_1.dart';
import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';

class DashboardStudentScreen extends StatefulWidget {
  @override
  _DashboardStudentScreenState createState() => _DashboardStudentScreenState();
}

class _DashboardStudentScreenState extends State<DashboardStudentScreen> {
  GetProposalsStudentUseCase _getProposalsStudentUseCase =
      getIt<GetProposalsStudentUseCase>();
  final ProjectStore _projectStore = getIt<ProjectStore>();
  final Map<int, int> offer = {};

  int selectedIndex = 0;

  List<ItemProposal> _proposals = [];
  List<Project> _projects = [];

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   // check to see if already called api
  //   if (!_projectStore.loading) {
  //     _projectStore.getProjects();
  //     // getProposalStudent();
  //   }
  // }

  @override
  void initState() {
    super.initState();
    // initializeData();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      // getProposalStudent();
      initializeData();
    });
  }

  @override
  void dispose() {
    super.dispose();
    log("cc");
  }

  void initializeData() async {
    if (_projectStore.projects == null) {
      await getProject();
    }
    await getProposalStudent();
  }

  Future<void> getProject() async {
    await _projectStore.getProjects();
  }

  Future<void> getProposalStudent() async {
    log("cc");
    final proposals = await _getProposalsStudentUseCase.call(params: null);
    setState(() {
      _proposals = proposals;
      _projects = [];
      filterProject();
    });
  }

  void filterProject() {
    _proposals.forEach((proposal) => proposal.statusFlag == 2
        ? offer[proposal.projectId] = proposal.id
        : {});
    final matchingProjects = _projectStore.projects?.projects!
        .where((project) =>
            _proposals.any((proposal) => proposal.projectId == project.id))
        .toList();
    setState(() {
      _projects = matchingProjects ?? [];
    });
    print("Filter success");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text('StudentHub'),
            ),
            body: RefreshIndicator(
              onRefresh: getProposalStudent,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Builder(
                  builder: ((context) {
                    if (_projects.isEmpty) {
                      return Container(
                        alignment: Alignment.topCenter,
                        height: MediaQuery.of(context).size.height * 1,
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          'Havent apply any project yet, pull down to refresh.',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      );
                    } else {
                      return Container(
                          padding: EdgeInsets.fromLTRB(18, 10, 20, 0),
                          // height: DeviceUtils.getScaledHeight(context, 1),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                      AppLocalizations.of(context)
                                          .translate('your_projects_text')),
                                ],
                              ),

                              Container(
                                margin: EdgeInsets.only(top: 20),
                                child: ToggleButtonsCompany(
                                  selected: selectedIndex,
                                  setSelected: (index) {
                                    setState(() {
                                      selectedIndex = index;
                                    });
                                  },
                                ),
                              ),
                              // ProjectItem(),
                              Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(top: 20),
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Color(0xFF121212)
                                      : Colors.yellow,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  AppLocalizations.of(context)
                                      .translate('you_have_new_message_text'),
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                              if (_projects.isNotEmpty)
                                if (selectedIndex == 0)
                                  ..._projects
                                      .toList()
                                      .map((project) => SubmitedProjectItem(
                                            offer: offer[project.id] ?? null,
                                            projDat: project,
                                          ))
                                else if (selectedIndex == 1)
                                  ..._projects
                                      .where((item) => item.typeFlag == 1)
                                      .toList()
                                      .map((project) => SubmitedProjectItem(
                                            projDat: project,
                                          ))
                                else if (selectedIndex == 2)
                                  ..._projects
                                      .where((item) => item.typeFlag == 2)
                                      .toList()
                                      .map((project) => SubmitedProjectItem(
                                            projDat: project,
                                          )),

                              // SubmitedProjectItem(
                              //   projDat: _projects[0],
                              // ),
                              // SubmitedProjectItem(),
                              // SubmitedProjectItem(),
                              // SubmitedProjectItem(),
                              const SizedBox(height: 20),
                            ],
                          ));
                    }
                  }),
                ),
              ),
            )));
  }
}
