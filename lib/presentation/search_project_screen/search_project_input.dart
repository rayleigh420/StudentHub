import 'package:boilerplate/core/widgets/project_item.dart';
import 'package:boilerplate/core/widgets/search_project_modal.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/domain/usecase/project/search_project_usecase.dart';

import 'package:boilerplate/presentation/home/store/theme/theme_store.dart';
import 'package:boilerplate/presentation/saved_project/saved_project.dart';
import 'package:boilerplate/presentation/search_project_screen/search_project_screen.dart';
import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SearchProjectInput extends StatefulWidget {
  SearchProjectInput({super.key});

  @override
  State<SearchProjectInput> createState() => _SearchProjectInputState();
}

class _SearchProjectInputState extends State<SearchProjectInput> {
  final FocusNode focusNode = FocusNode();
  ThemeStore _themeStore = getIt<ThemeStore>();

  final searchController = TextEditingController();

  SearchProjectsUseCase _searchProjectsUseCase = getIt<SearchProjectsUseCase>();

  @override
  void initState() {
    super.initState();
    focusNode.requestFocus();
  }

  void searchProject() async {
    final searchQuery = searchController.text;
    if (searchQuery.isNotEmpty) {
      final result = await _searchProjectsUseCase.call(
          params: SearchProjectParams(title: searchQuery));
      // print(result);
      Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
          builder: (context) => SearchProjectScreen(
                projectList: result,
                searchQuery: searchQuery,
              ),
          maintainState: false));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
            child: TextField(
              controller: searchController,
              onTapOutside: (event) {
                DeviceUtils.hideKeyboard(context);
              },
              focusNode: focusNode,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: AppLocalizations.of(context)
                    .translate('search_project_text'),
                prefixIcon: Icon(Icons.search, color: Colors.grey),
              ),
              onSubmitted: (value) {
                searchProject();
                // Navigator.of(context, rootNavigator: true).push(
                //     MaterialPageRoute(
                //         builder: (context) => SearchProjectScreen(),
                //         maintainState: true));
              },
            ),
          )),
          GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.all(5),
                child: Text(
                  AppLocalizations.of(context).translate('cancel_text'),
                  style: TextStyle(color: Colors.blue),
                ),
              ))
        ],
      ),
    );
  }

  int dateDiff(DateTime date1, DateTime date2) {
    Duration difference = date1.difference(date2);
    return difference.inDays;
  }
}
