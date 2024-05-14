import 'package:boilerplate/core/widgets/filter_search_project_modal.dart';
import 'package:boilerplate/core/widgets/project_item.dart';

import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/domain/entity/project_2/project.dart';
import 'package:boilerplate/domain/entity/project_2/project_list.dart';

import 'package:boilerplate/presentation/home/store/theme/theme_store.dart';
import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';

class SearchProjectScreen extends StatefulWidget {
  final ProjectList? projectList;
  final String searchQuery;
  const SearchProjectScreen(
      {super.key, required this.searchQuery, this.projectList});

  @override
  State<SearchProjectScreen> createState() => _SearchProjectScreenState();
}

class _SearchProjectScreenState extends State<SearchProjectScreen> {
  String searchQuery = "";
  List<Project> projects = [];
  @override
  void initState() {
    super.initState();
    setState(() {
      projects = widget.projectList!.projects!;
    });
    searchQuery = widget.searchQuery;
  }

  ThemeStore _themeStore = getIt<ThemeStore>();

  void searchProject(ProjectList result) {
    setState(() {
      projects = result.projects!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text(AppLocalizations.of(context)
                  .translate('search_project_text')),
            ),
            resizeToAvoidBottomInset: false,
            body: Container(
                child: Column(
              children: [
                buildSearchBar(context),
                Expanded(
                  // height: DeviceUtils.getScaledHeight(context, 0.7),
                  child: CustomScrollView(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    slivers: [
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 16,
                            ),
                            if (projects.isEmpty)
                              Center(
                                child: Text(
                                  AppLocalizations.of(context)
                                      .translate('no_project_text'),
                                  // style: TextStyle(
                                  //     color: _themeStore.darkMode
                                  //         ? Colors.white
                                  //         : Colors.black),
                                ),
                              )
                            else
                              ...projects
                                  .map((e) => ProjectItem(projDat: e))
                                  .toList(),
                            // ProjectItem(projDat: projDat),
                            // ProjectItem(projDat: projDat),
                            // ProjectItem(projDat: projDat),
                            // ProjectItem(projDat: projDat),
                            // ProjectItem(projDat: projDat),
                            const SizedBox(
                              height: 16,
                            )
                            // buildProjectItem()
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ))));
  }

  Widget buildSearchBar(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
              child: Container(
            padding: EdgeInsets.only(left: 8),
            margin: EdgeInsets.fromLTRB(0, 10, 10, 10),
            decoration: BoxDecoration(
              // border: Border.all(color: Colors.grey),
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
            ),
            child: TextFormField(
              maxLines: 1,
              onTapOutside: (event) {
                DeviceUtils.hideKeyboard(context);
              },
              initialValue: searchQuery,
              decoration: InputDecoration(
                border: InputBorder.none,

                // hintText: "Search for projects âs",
                prefixIcon: Icon(Icons.search, color: Colors.grey),
              ),
              onTap: () => {Navigator.of(context).pop()},
            ),
          )),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                isDismissible: true,
                context: context,
                isScrollControlled: true,
                useRootNavigator: true,
                enableDrag: true,
                backgroundColor: Colors.transparent,
                builder: (context) {
                  return FilterSearchProjectModal(
                      searchProject: searchProject, searchQuery: searchQuery);
                },
              );
            },
            child: Container(
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Color(0xFFE91E63),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Icon(Icons.filter_alt_outlined,
                  color: Colors.white,
                  size: MediaQuery.of(context).size.height * 0.023),
            ),
          )
        ],
      ),
    );
  }

  int dateDiff(DateTime date1, DateTime date2) {
    Duration difference = date1.difference(date2);
    return difference.inDays;
  }
}
