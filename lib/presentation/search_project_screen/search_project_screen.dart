import 'package:boilerplate/core/widgets/filter_search_project_modal.dart';
import 'package:boilerplate/core/widgets/project_item.dart';
import 'package:boilerplate/core/widgets/search_project_modal.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/domain/entity/project/project.dart';
import 'package:boilerplate/presentation/home/store/theme/theme_store.dart';
import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:flutter/material.dart';

class SearchProjectScreen extends StatefulWidget {
  const SearchProjectScreen({super.key});

  @override
  State<SearchProjectScreen> createState() => _SearchProjectScreenState();
}

class _SearchProjectScreenState extends State<SearchProjectScreen> {
  ThemeStore _themeStore = getIt<ThemeStore>();

  final data = {
    "title": "Senior frontend developer (Fintech)",
    "props": [
      "Students are looking for",
      "Clear expectation about your project or deliverables",
      "React",
      "Redux",
      "TypeScript",
      "GraphQL",
      "Node.js",
      "AWS",
    ],
    "scopeFrom": 1,
    "scopeFrom2": "month",
    "scopeTo": 3,
    "scopeTo2": "months",
    "quantityRequired": "6",
    "createdDate": DateTime.now().add(Duration(days: -3)),
    "proposal": 6
  };
  final projDat = Project(
      title: "Senior frontend developer (Fintech)",
      props: [
        "Students are looking for",
        "Clear expectation about your project or deliverables",
        "React",
        "Redux",
        "TypeScript",
        "GraphQL",
        "Node.js",
        "AWS",
      ],
      scopeFrom: 1,
      scopeFrom2: "month",
      scopeTo: 3,
      scopeTo2: "month",
      proposal: 6,
      createdDate: DateTime.now().add(Duration(days: -3)),
      isSaved: false);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text("Search Project"),
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

                            ProjectItem(projDat: projDat),
                            ProjectItem(projDat: projDat),
                            ProjectItem(projDat: projDat),
                            ProjectItem(projDat: projDat),
                            ProjectItem(projDat: projDat),
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
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Search for projects",
                prefixIcon: Icon(Icons.search, color: Colors.grey),
              ),
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
                  return FilterSearchProjectModal();
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
