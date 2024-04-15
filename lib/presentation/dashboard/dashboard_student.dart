import 'package:boilerplate/core/widgets/projects/list_project_company.dart';
import 'package:boilerplate/core/widgets/projects/project_company_item.dart';
import 'package:boilerplate/core/widgets/projects/submited_project_item.dart';
import 'package:boilerplate/core/widgets/toogle_filter.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/domain/entity/project_2/project.dart';
import 'package:boilerplate/domain/entity/proposal/itemProposal.dart';
import 'package:boilerplate/domain/usecase/proposal/get_proposal_student.dart';
import 'package:boilerplate/presentation/browse_project/store/project_store.dart';
import 'package:boilerplate/presentation/project/company/project_post_1.dart';
import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:flutter/material.dart';

class DashboardStudentScreen extends StatefulWidget {
  @override
  _DashboardStudentScreenState createState() => _DashboardStudentScreenState();
}

class _DashboardStudentScreenState extends State<DashboardStudentScreen> {
  GetProposalsStudentUseCase _getProposalsStudentUseCase =
      getIt<GetProposalsStudentUseCase>();
  final ProjectStore _projectStore = getIt<ProjectStore>();

  List<ItemProposal> _proposals = [];
  List<Project> _projects = [];

  @override
  void initState() {
    super.initState();
    getProposalStudent();
  }

  void getProposalStudent() async {
    final proposals = await _getProposalsStudentUseCase.call(params: null);
    setState(() {
      _proposals = proposals;
      filterProject();
    });
  }

  void filterProject() {
    final matchingProjects = _projectStore.projects!.projects!
        .where((project) => _proposals
            .any((proposal) => proposal.projectId == project.projectId))
        .toList();
    setState(() {
      _projects = matchingProjects;
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
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                  padding: EdgeInsets.fromLTRB(18, 10, 20, 0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                              style: TextStyle(fontWeight: FontWeight.w600),
                              "Your Projects"),
                          // ElevatedButton(
                          //     style: ElevatedButton.styleFrom(
                          //         shape: RoundedRectangleBorder(
                          //             borderRadius: BorderRadius.circular(5))),
                          //     onPressed: () {
                          //       Navigator.of(context, rootNavigator: true).push(
                          //           MaterialPageRoute(
                          //               builder: (context) => ProjectPost1(),
                          //               maintainState: false));
                          //       // Navigator.pushNamed(context, '/project_post_1');
                          //     },
                          //     child: const Text(
                          //         style: TextStyle(fontSize: 16), "Post a job")),
                        ],
                      ),
                      // Row(
                      //   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   mainAxisSize: MainAxisSize.min,
                      //   children: [
                      //   ],
                      // ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: FilterButtons(),
                      ),
                      // ProjectItem(),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 20),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Color(0xFF121212)
                              : Colors.yellow,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          "You have a new message",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      if (_projects.isNotEmpty)
                        ..._projects.map((project) => SubmitedProjectItem(
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
                  )),
            )));
  }
}
