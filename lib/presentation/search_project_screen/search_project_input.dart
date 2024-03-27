import 'package:boilerplate/core/widgets/project_item.dart';
import 'package:boilerplate/core/widgets/search_project_modal.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/domain/entity/project/project.dart';
import 'package:boilerplate/presentation/home/store/theme/theme_store.dart';
import 'package:boilerplate/presentation/saved_project/saved_project.dart';
import 'package:boilerplate/presentation/search_project_screen/search_project_screen.dart';
import 'package:boilerplate/utils/device/device_utils.dart';
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

  @override
  void initState() {
    super.initState();
    focusNode.requestFocus();
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
              onTapOutside: (event){
                DeviceUtils.hideKeyboard(context);
              },
              focusNode: focusNode,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Search for projects",
                prefixIcon: Icon(Icons.search, color: Colors.grey),
              ),
              onSubmitted: (value) {
                Navigator.of(context, rootNavigator: false).push(MaterialPageRoute(
                    builder: (context) => SearchProjectScreen(),
                    maintainState: false));
              },
            ),
          )),
          GestureDetector(
              onTap: () {
                // showModalBottomSheet(
                //   isDismissible: true,
                //   context: context,
                //   isScrollControlled: true,
                //   useRootNavigator: true,
                //   enableDrag: true,
                //   backgroundColor: Colors.transparent,
                //   builder: (context) {
                //     return FilterSearchProjectModal();
                //   },
                // );
                Navigator.of(context, rootNavigator: false).pop();
              },
              child: Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.all(5),
                child: Text(
                  "Cancel",
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

  Widget buildProjectItem() {
    return Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Created ${dateDiff(DateTime.now(), projDat.createdDate!)} days ago",
                    style: TextStyle(fontSize: 12),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    projDat.title,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Text(
                          "${projDat.scopeFrom} ${projDat.scopeFrom2} - ${projDat.scopeTo} ${projDat.scopeTo2}",
                          style: TextStyle(fontSize: 13)),
                      Text(", ", style: TextStyle(fontSize: 13)),
                      Text(
                          "${projDat.quantityRequired != null ? projDat.quantityRequired : 0}  students",
                          style: TextStyle(fontSize: 13)),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text("Student are looking for",
                      style: TextStyle(fontSize: 13)),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 5.0),
                        child: Text("-   ${projDat.props[index]}",
                            style: TextStyle(fontSize: 13)),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text("Proposals: ${projDat.proposal} proposals",
                      style: TextStyle(fontSize: 13)),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child:
                    Icon(Icons.favorite_border, color: Colors.grey, size: 30),
              ),
            ),
          ],
        ));
  }
}
