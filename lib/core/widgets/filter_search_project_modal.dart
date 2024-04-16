import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/domain/usecase/project/search_project_usecase.dart';
import 'package:boilerplate/presentation/home/store/theme/theme_store.dart';
import 'package:boilerplate/utils/device/device_utils.dart';

import 'package:flutter/material.dart';

class FilterSearchProjectModal extends StatefulWidget {
  final Function searchProject;
  const FilterSearchProjectModal({super.key, required this.searchProject});

  @override
  State<FilterSearchProjectModal> createState() =>
      _FilterSearchProjectModalState();
}

class _FilterSearchProjectModalState extends State<FilterSearchProjectModal> {
  ThemeStore _themeStore = getIt<ThemeStore>();
  int? choosenTime = 0;

  final studentNeededController = TextEditingController();
  final proposalLessThanController = TextEditingController();

  SearchProjectsUseCase _searchProjectsUseCase = getIt<SearchProjectsUseCase>();

  void filterSubmit() async {
    final result = await _searchProjectsUseCase.call(
        params: SearchProjectParams(
            projectScopeFlag: choosenTime,
            numberOfStudents: int.parse(studentNeededController.text),
            proposalsLessThan: int.parse(proposalLessThanController.text)));
    widget.searchProject(result);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _themeStore.darkMode ? Color(0xff2E3239) : Colors.white,
        border: Border(
            top: BorderSide(
                color:
                    _themeStore.darkMode ? Colors.grey : Colors.transparent)),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      width: DeviceUtils.getScaledWidth(context, 1),
      height: DeviceUtils.getScaledHeight(context, 0.8),
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text("Filter", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(
              height: DeviceUtils.getScaledHeight(context, 0.6),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 10),
                    const Divider(),
                    SizedBox(height: 10),
                    const Text("Project length", style: TextStyle()),
                    SizedBox(height: 10),
                    buildRadios(context),
                    SizedBox(height: 20),
                    const Text("Students needed", style: TextStyle()),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.only(left: 15),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: _themeStore.darkMode
                                ? Colors.white
                                : Colors.grey),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextField(
                        controller: studentNeededController,
                        scrollPadding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        onTapOutside: (event) {
                          DeviceUtils.hideKeyboard(context);
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Number of students",
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          // Handle search text change
                        },
                        onSubmitted: (value) {},
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("Proposals less than", style: TextStyle()),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.only(left: 15),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: _themeStore.darkMode
                                ? Colors.white
                                : Colors.grey),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextField(
                        controller: proposalLessThanController,
                        scrollPadding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        keyboardType: TextInputType.number,
                        onTapOutside: (event) {
                          DeviceUtils.hideKeyboard(context);
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Input proposal amount",
                        ),
                        onChanged: (value) {
                          // Handle search text change
                        },
                        onSubmitted: (value) {},
                      ),
                    ),
                    SizedBox(height: 100),
                  ],
                ),
              ),
            ),
            const Spacer(),
            buildButtons(context),
          ],
        ),
      ),
    );
    ;
  }

  Widget buildRadios(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Row(
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [
        //     Radio(
        //       visualDensity: const VisualDensity(
        //         horizontal: VisualDensity.minimumDensity,
        //         vertical: VisualDensity.minimumDensity,
        //       ),
        //       groupValue: choosenTime,
        //       value: "Less than 1 month",
        //       onChanged: (value) {
        //         setState(() {
        //           choosenTime = value as String;
        //         });
        //       },
        //     ),
        //     const SizedBox(width: 15),
        //     const Text("Less than 1 month")
        //   ],
        // ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Radio(
              visualDensity: const VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity,
              ),
              groupValue: choosenTime,
              value: "1 to 3 months",
              onChanged: (value) {
                setState(() {
                  choosenTime = 0;
                });
              },
            ),
            const SizedBox(width: 15),
            const Text("1 to 3 months")
          ],
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Radio(
              visualDensity: const VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity,
              ),
              groupValue: choosenTime,
              value: "3 to 6 months",
              onChanged: (value) {
                setState(() {
                  choosenTime = 1;
                });
              },
            ),
            const SizedBox(width: 15),
            const Text("3 to 6 months")
          ],
        ),
        const SizedBox(height: 10),
        // Row(
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [
        //     Radio(
        //       visualDensity: const VisualDensity(
        //         horizontal: VisualDensity.minimumDensity,
        //         vertical: VisualDensity.minimumDensity,
        //       ),
        //       groupValue: choosenTime,
        //       value: "More than 6 months",
        //       onChanged: (value) {
        //         setState(() {
        //           choosenTime = value as String;
        //         });
        //       },
        //     ),
        //     const SizedBox(width: 15),
        //     const Text("More than 6 months")
        //   ],
        // ),
      ],
    );
  }

  Widget buildButtons(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey)),
      ),
      width: DeviceUtils.getScaledWidth(context, 1),
      padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () => {
              // filterSubmit(),
              print("Hello")
            },
            child: Container(
              alignment: Alignment.center,
              height: DeviceUtils.getScaledHeight(context, 0.034),
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(10)
                  // border: Border(top: BorderSide(color: )),
                  ),
              width: DeviceUtils.getScaledWidth(context, 0.4),
              child: Text(
                "Apply Now",
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: DeviceUtils.getScaledHeight(context, 0.034),
            decoration: BoxDecoration(
              // color: Colors.blueAccent,
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey),
            ),
            width: DeviceUtils.getScaledWidth(context, 0.4),
            child: Text(
              "Save",
              textAlign: TextAlign.center,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
