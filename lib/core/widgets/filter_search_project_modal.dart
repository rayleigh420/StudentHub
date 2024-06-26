import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/domain/usecase/project/search_project_usecase.dart';
import 'package:boilerplate/presentation/home/store/theme/theme_store.dart';
import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';

import 'package:flutter/material.dart';

class FilterSearchProjectModal extends StatefulWidget {
  final Function searchProject;
  final String searchQuery;
  final Function setFilter;
  final int? choosenTime;
  final int? studentNeeded;
  final int? proposalsLessThan;
  const FilterSearchProjectModal(
      {super.key,
      required this.searchProject,
      required this.searchQuery,
      required this.setFilter,
      this.choosenTime,
      this.studentNeeded,
      this.proposalsLessThan});

  @override
  State<FilterSearchProjectModal> createState() =>
      _FilterSearchProjectModalState();
}

class _FilterSearchProjectModalState extends State<FilterSearchProjectModal> {
  ThemeStore _themeStore = getIt<ThemeStore>();
  int? choosenTime = 0;

  final studentNeededController = TextEditingController();
  final proposalLessThanController = TextEditingController();

  @override
  void initState() {
    super.initState();
    choosenTime = widget.choosenTime ?? 0;
    studentNeededController.text =
        widget.studentNeeded == null ? "" : widget.studentNeeded.toString();
    proposalLessThanController.text = widget.proposalsLessThan == null
        ? ""
        : widget.proposalsLessThan.toString();
  }

  SearchProjectsUseCase _searchProjectsUseCase = getIt<SearchProjectsUseCase>();

  void filterSubmit() async {
    // print()
    final result = await _searchProjectsUseCase.call(
        params: SearchProjectParams(
      title: widget.searchQuery,
      projectScopeFlag: choosenTime,
      numberOfStudents: int.parse(studentNeededController.text),
      page: 1,
      perPage: 10,
    ));
    bool _isLastPage = false;
    if (result.projects != null && result.projects!.isNotEmpty) {
      if (result.projects!.length < 10) {
        _isLastPage = true;
      }
    }
    widget.searchProject(result);
    int? proposalLessThan = proposalLessThanController.text.isEmpty
        ? null
        : int.parse(proposalLessThanController.text);
    int? studentNeeded = studentNeededController.text.isEmpty
        ? null
        : int.parse(studentNeededController.text);
    widget.setFilter(
        choosenTime, studentNeeded, proposalLessThan, 1, _isLastPage);
    // widget.setFilter(choosenTime, int.parse(studentNeededController.text),
    //     int.parse(proposalLessThanController.text), 1, _isLastPage);
    Navigator.of(context).pop();
  }

  void clearFilter() async {
    final result = await _searchProjectsUseCase.call(
        params: SearchProjectParams(
      title: widget.searchQuery,
      projectScopeFlag: null,
      numberOfStudents: null,
      page: 1,
      perPage: 10,
    ));

    bool _isLastPage = false;
    if (result.projects != null && result.projects!.isNotEmpty) {
      if (result.projects!.length < 10) {
        _isLastPage = true;
      }
    }
    widget.searchProject(result);
    widget.setFilter(null, null, null, 1, _isLastPage);
    Navigator.of(context).pop();
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
            Text(AppLocalizations.of(context).translate('filter_text'),
                style: TextStyle(fontWeight: FontWeight.bold)),
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
                    Text(
                        AppLocalizations.of(context)
                            .translate('project_length_text'),
                        style: TextStyle()),
                    SizedBox(height: 10),
                    buildRadios(context),
                    SizedBox(height: 20),
                    Text(
                        AppLocalizations.of(context)
                            .translate('input_student_needed_text'),
                        style: TextStyle()),
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
                          hintText: AppLocalizations.of(context)
                              .translate('input_student_needed_text'),
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
                    Text(
                        AppLocalizations.of(context)
                            .translate('proposal_less_than_text'),
                        style: TextStyle()),
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
                          hintText: AppLocalizations.of(context)
                              .translate('input_proposal_amount_text'),
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
              value: 0,
              onChanged: (value) {
                setState(() {
                  choosenTime = 0;
                });
              },
            ),
            const SizedBox(width: 15),
            Text(AppLocalizations.of(context).translate('one_to_three_months'))
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
              value: 1,
              onChanged: (value) {
                setState(() {
                  choosenTime = 1;
                });
              },
            ),
            const SizedBox(width: 15),
            Text(AppLocalizations.of(context).translate('three_to_six_months'))
          ],
        ),
        const SizedBox(height: 10),
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
              filterSubmit(),
              // print("Hello")
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
                "Apply",
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
          GestureDetector(
              onTap: () {
                clearFilter();
              },
              child: Container(
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
                  AppLocalizations.of(context).translate('clear_text'),
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                ),
              )),
        ],
      ),
    );
  }
}
