import 'package:boilerplate/core/widgets/projects/project_company_item.dart';
import 'package:boilerplate/core/widgets/toogle_filter.dart';
import 'package:boilerplate/di/service_locator.dart';
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_projectCompanyStore.loading) {
      _projectCompanyStore.getCompanyProjects();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5))),
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute(
                                builder: (context) => ProjectPost1(),
                                maintainState: false));
                      },
                      child: const Text(
                          style: TextStyle(fontSize: 16), "Post a job")),
                ],
              ),

              Container(
                margin: EdgeInsets.only(top: 20),
                child: FilterButtons(),
              ),
              const SizedBox(
                height: 16,
              ),
              // ProjectItem(),
              // ListProjectCompany(),
              buildProjectsContent(),
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
    )));
  }

  Widget buildProjectsContent() {
    return Observer(builder: (context) {
      return _projectCompanyStore.loading
          ? Center(child: CircularProgressIndicator())
          : buildProjectsList();
    });
  }

  Widget buildProjectsList() {
    return Observer(
      builder: (context) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: _projectCompanyStore.companyProjects!.projects!.length,
          itemBuilder: (context, index) {
            return ProjectItemCompany(
              project: _projectCompanyStore.companyProjects!.projects![index],
            );
          },
        );
      },
    );
  }
}
