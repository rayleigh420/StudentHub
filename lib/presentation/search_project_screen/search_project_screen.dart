import 'package:boilerplate/core/widgets/filter_search_project_modal.dart';
import 'package:boilerplate/core/widgets/project_item.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/domain/entity/project_2/project.dart';
import 'package:boilerplate/domain/entity/project_2/project_list.dart';
import 'package:boilerplate/domain/usecase/project/search_project_usecase.dart';
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
  final SearchProjectsUseCase _searchProjectsUseCase =
      getIt<SearchProjectsUseCase>();
  bool _isLastPage = false;
  bool _loading = false;
  int _pageNumber = 1;
  late int? choosenTime = null;
  late int? studentNeeded = null;
  late int? proposalsLessThan = null;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // if (widget.projectList != null) {
    //   setState(() {
    //     projects = widget.projectList!.projects!;
    //   });
    // }
    searchQuery = widget.searchQuery;
    _scrollController.addListener(_scrollListener);
    callApiProject();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void searchProject(ProjectList result) {
    setState(() {
      projects = result.projects!;
    });
  }

  Future<void> callApiProject() async {
    if (searchQuery.isNotEmpty && !_loading && !_isLastPage) {
      setState(() {
        _loading = true;
      });

      try {
        final result = await _searchProjectsUseCase.call(
          params: SearchProjectParams(
            title: searchQuery,
            page: _pageNumber,
            perPage: 10,
            projectScopeFlag: choosenTime,
            numberOfStudents: studentNeeded,
          ),
        );

        setState(() {
          if (result.projects != null && result.projects!.isNotEmpty) {
            projects.addAll(result.projects!);
            _isLastPage = result.projects!.length < 10;
            _pageNumber++;
          } else {
            _isLastPage = true;
          }
        });
      } catch (e) {
        // Handle error (e.g., show a snackbar or dialog)
      } finally {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      callApiProject();
    }
  }

  void setFilter(
      int? time, int? student, int? proposal, int page, bool isLastPage) {
    setState(() {
      page = page;
      choosenTime = time;
      studentNeeded = student;
      proposalsLessThan = proposal;
      _isLastPage = isLastPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              AppLocalizations.of(context).translate('search_project_text')),
        ),
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            buildSearchBar(context),
            Expanded(
              child: CustomScrollView(
                controller: _scrollController,
                physics: BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        if (projects.isEmpty && !_loading)
                          Center(
                            child: Text(AppLocalizations.of(context)
                                .translate('no_project_text')),
                          )
                        else
                          ...projects
                              .map((e) => ProjectItem(projDat: e))
                              .toList(),
                        if (_loading)
                          Center(child: CircularProgressIndicator()),
                        const SizedBox(height: 16),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSearchBar(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
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
                color: Colors.grey[200],
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
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                ),
                onTap: () => {Navigator.of(context).pop()},
              ),
            ),
          ),
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
                      choosenTime: choosenTime,
                      studentNeeded: studentNeeded,
                      proposalsLessThan: proposalsLessThan,
                      searchProject: searchProject,
                      searchQuery: searchQuery,
                      setFilter: setFilter);
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
          ),
        ],
      ),
    );
  }
}
