import 'package:boilerplate/core/widgets/projects/project_company_item.dart';
import 'package:boilerplate/core/widgets/toggle_button.dart';
import 'package:boilerplate/core/widgets/toogle_filter.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/domain/entity/project_2/project.dart';
import 'package:boilerplate/presentation/browse_project/store/project_company_store.dart';
import 'package:boilerplate/presentation/project/company/project_post_1.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';

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
                              Text(
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                  AppLocalizations.of(context)
                                      .translate('your_projects_text')),
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
                                  child: Text(
                                      style: TextStyle(fontSize: 16),
                                      AppLocalizations.of(context)
                                          .translate('post_a_job_text'))),
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
    if (_projectCompanyStore.companyProjects!.projects!.isEmpty) {
      return Container(
        alignment: Alignment.topCenter,
        height: MediaQuery.of(context).size.height * 1,
        padding: EdgeInsets.all(20.0),
        child: Text(
          AppLocalizations.of(context).translate('no_project_text'),
          style: TextStyle(fontSize: 16),
        ),
      );
    } else {
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
            if (_projectCompanyStore
                    .companyProjects!.projects![index].typeFlag ==
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
}
