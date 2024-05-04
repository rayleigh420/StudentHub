import 'package:boilerplate/core/widgets/projects/project_company_item.dart';
import 'package:boilerplate/core/widgets/toggle_button.dart';
import 'package:boilerplate/core/widgets/toogle_filter.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/domain/entity/project_2/project.dart';
import 'package:boilerplate/presentation/browse_project/store/project_company_store.dart';
import 'package:boilerplate/presentation/project/company/project_post_1.dart';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class DashboardCompanyScreen extends StatefulWidget {
  @override
  _DashboardCompanyScreenState createState() => _DashboardCompanyScreenState();
}

class _DashboardCompanyScreenState extends State<DashboardCompanyScreen> {
  final ProjectCompanyStore _projectCompanyStore = getIt<ProjectCompanyStore>();
  int? selectedIndex = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // _projectCompanyStore.getCompanyProjects();
    // if (!_projectCompanyStore.loading) {}
  }

  @override
  void initState() {
    super.initState();
    _projectCompanyStore.getCompanyProjects();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: RefreshIndicator(
                onRefresh: _projectCompanyStore.getCompanyProjects,
                child: SingleChildScrollView(
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
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5))),
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .push(MaterialPageRoute(
                                            builder: (context) =>
                                                ProjectPost1(),
                                            maintainState: false));
                                  },
                                  child: const Text(
                                      style: TextStyle(fontSize: 16),
                                      "Post a job")),
                            ],
                          ),

                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: ToggleButtonsCompany(
                              selected: selectedIndex!,
                              setSelected: (index) {
                                setState(() {
                                  selectedIndex = index;
                                });
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          // ProjectItem(),
                          // ListProjectCompany(),
                          buildProjectsContent(selectedIndex!),
                          // Container(
                          //   margin: EdgeInsets.only(
                          //       top: DeviceUtils.getScaledHeight(context, 0.35)),
                          //   child: Center(
                          //       child: Column(
                          //     children: [
                          //       const Text(
                          //           style: TextStyle(fontWeight: FontWeight.w500),
                          //           "Welcome Duy!"),
                          //       const Text(
                          //           style: TextStyle(fontWeight: FontWeight.w500),
                          //           "You have no jobs!"),
                          //     ],
                          //   )),
                          // ),
                        ],
                      )),
                ))));
  }

  Widget buildProjectsContent(int selected) {
    return Observer(builder: (context) {
      return _projectCompanyStore.loading
          ? Center(child: CircularProgressIndicator())
          : buildProjectsList();
      // buildProjectsList(project);
    });
  }

  Widget buildProjectsList() {
    // final project = selectedIndex != 1
    //     ? _projectCompanyStore.companyProjects!.projects!
    //         .where((item) => item.typeFlag != 1)
    //         .toList()
    //     : _projectCompanyStore.companyProjects!.projects!
    //         .where((item) => item.typeFlag == 1)
    //         .toList();
    return ListView.builder(
      shrinkWrap: true,
      itemCount: selectedIndex == 0
          ? _projectCompanyStore.companyProjects!.projects!.length
          : _projectCompanyStore.companyProjects!.projects!
              .where((item) => item.typeFlag == 1)
              .toList()
              .length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        if (selectedIndex == 0) {
          return ProjectItemCompany(
            project: _projectCompanyStore.companyProjects!.projects![index],
          );
        } else {
          if (_projectCompanyStore.companyProjects!.projects![index].typeFlag ==
              1) {
            return ProjectItemCompany(
              project: _projectCompanyStore.companyProjects!.projects![index],
            );
          }
        }
      },
    );
  }
}
