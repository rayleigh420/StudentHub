import 'package:boilerplate/core/widgets/project_item.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/domain/entity/project_2/project.dart';
import 'package:boilerplate/domain/entity/project_2/project_list.dart';
import 'package:boilerplate/domain/usecase/favorite/get_favorite_by_student_id.dart';

import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';

class SavedProject extends StatefulWidget {
  const SavedProject({super.key});

  @override
  State<SavedProject> createState() => _SavedProjectState();
}

class _SavedProjectState extends State<SavedProject> {
  GetFavoriteByStudentIdUseCase _getFavoriteByStudentIdUseCase =
      getIt<GetFavoriteByStudentIdUseCase>();
  List<Project> projects = [];

  @override
  void initState() {
    super.initState();

    getFavoriteProjectByStudentId();
  }

  void getFavoriteProjectByStudentId() async {
    final projects = await _getFavoriteByStudentIdUseCase.call(params: null);
    setState(() {
      this.projects = projects.projects!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text(AppLocalizations.of(context)
                  .translate('saved_projects_text')),
            ),
            body: Container(
                child: Column(
              children: [
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
                            Text(
                                AppLocalizations.of(context)
                                    .translate('saved_projects_text'),
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            const SizedBox(
                              height: 16,
                            ),
                            ...projects
                                .map((project) => ProjectItem(projDat: project))
                                .toList(),

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
    ;
  }
}
