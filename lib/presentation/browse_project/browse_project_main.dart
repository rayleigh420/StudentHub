import 'package:boilerplate/core/widgets/project_item.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/domain/entity/project/project.dart';
import 'package:boilerplate/presentation/browse_project/store/project_store.dart';
import 'package:boilerplate/presentation/home/store/theme/theme_store.dart';
import 'package:boilerplate/presentation/saved_project/saved_project.dart';
import 'package:boilerplate/presentation/search_project_screen/search_project_input.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class BrowseProjectScreen extends StatefulWidget {
  BrowseProjectScreen({super.key});

  @override
  State<BrowseProjectScreen> createState() => _BrowseProjectScreenState();
}

class _BrowseProjectScreenState extends State<BrowseProjectScreen> {
  final ThemeStore _themeStore = getIt<ThemeStore>();
  final ProjectStore _projectStore = getIt<ProjectStore>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // check to see if already called api
    if (!_projectStore.loading) {
      _projectStore.getProjects();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text(AppLocalizations.of(context)
                  .translate('browse_project_text')),
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

                            // ProjectItem(projDat: projDat),
                            // ProjectItem(projDat: projDat),
                            // ProjectItem(projDat: projDat),
                            // ProjectItem(projDat: projDat),
                            // ProjectItem(projDat: projDat),
                            // Text("hi"),
                            buildProjectContent(context),
                            const SizedBox(
                              height: 16,
                            ),

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
          GestureDetector(
            onTap: () {
              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                  builder: (context) => SearchProjectInput(),
                  maintainState: true));
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(50),
              ),
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              margin: EdgeInsets.fromLTRB(0, 10, 10, 10),
              width: MediaQuery.of(context).size.width * 0.8,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Icon(Icons.search, color: Colors.grey),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        AppLocalizations.of(context)
                            .translate('search_project_text'),
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ))
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context, rootNavigator: false).push(
                  MaterialPageRoute(
                      builder: (context) => SavedProject(),
                      maintainState: false));
            },
            child: Container(
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Color(0xFFE91E63),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Icon(Icons.favorite,
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

  Widget buildProjectContent(BuildContext context) {
    return Observer(builder: (context) {
      return _projectStore.loading
          ? Center(
              child: CupertinoActivityIndicator(),
            )
          : buildListProjects(context);
    });
  }

  Future<void> _pullRefresh() async {
    _projectStore.getProjects();
  }

  Widget buildListProjects(BuildContext context) {
    return _projectStore.projects != null
        ? RefreshIndicator(
            child: SingleChildScrollView(
                child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: _projectStore.projects!.projects!.length,
              itemBuilder: (context, index) {
                return ProjectItem(
                    projDat: _projectStore.projects!.projects![index]);
              },
            )),
            onRefresh: _pullRefresh)
        : Center(
            child: Text(
                AppLocalizations.of(context).translate('no_project_found_text'),
                style: TextStyle(fontSize: 16, color: Colors.grey)),
          );
  }
}
