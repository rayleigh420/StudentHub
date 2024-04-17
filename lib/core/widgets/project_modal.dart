import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/domain/entity/project_2/project.dart';
import 'package:boilerplate/domain/usecase/favorite/add_favorite_by_student_id.dart';
// import 'package:boilerplate/domain/entity/project/project.dart';
import 'package:boilerplate/presentation/home/store/theme/theme_store.dart';
import 'package:boilerplate/presentation/project/student/submit_project.dart';
import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProjectModal extends StatefulWidget {
  Project project;
  ProjectModal({super.key, required this.project});
  @override
  State<ProjectModal> createState() => _ProjectModalState();
}

class _ProjectModalState extends State<ProjectModal> {
  final ThemeStore _themeStore = getIt<ThemeStore>();
  AddFavoriteByStudentIdUseCase _addFavoriteByStudentIdUseCase =
      getIt<AddFavoriteByStudentIdUseCase>();
  @override
  void initState() {
    super.initState();
    // _themeStore.changeBrightnessToDark(true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
            top: BorderSide(
                color:
                    _themeStore.darkMode ? Colors.white : Colors.transparent)),
        color: _themeStore.darkMode ? Color(0xff2E3239) : Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      width: DeviceUtils.getScaledWidth(context, 1),
      height: DeviceUtils.getScaledHeight(context, 0.8),
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildCompanyAndJobTitle(context),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  buildScope(context),
                  const SizedBox(
                    height: 20,
                  ),
                  buildStudentNumber(context),
                  const SizedBox(
                    height: 20,
                  ),
                  buildStudentLookingFor(context),
                  const SizedBox(
                    height: 20,
                  ),
                  buildSkillRequired(context),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
            buildButtons(context)
          ],
        ),
      ),
    );
  }

  Widget buildCompanyAndJobTitle(BuildContext context) {
    final w = DeviceUtils.getScaledWidth(context, 0.14);
    const img = kIsWeb
        ? AssetImage('/images/company.png')
        : AssetImage('assets/images/company.png');
    return Container(
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
            child: Image(
              image: img,
              width: w,
              height: w,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.project.companyName!,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: DeviceUtils.getScaledWidth(context, 0.7),
                child: Text(
                  widget.project.title!,
                  overflow: TextOverflow.fade,
                  // style: TextStyle(fontSize: 14),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Salary goes here",
                // style: TextStyle(fontSize: 14),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget buildStudentLookingFor(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: Colors.grey,
        border: Border(
            top: BorderSide(color: Colors.grey),
            bottom: BorderSide(color: Colors.grey)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20, bottom: 10),
            child: const Text("Top 3 reasons to join us"),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.circle,
                size: 10,
                color: Colors.blueAccent,
              ),
              const SizedBox(
                width: 10,
              ),
              Flexible(child: Text("Very competitive remuneration package"))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.circle,
                size: 10,
                color: Colors.blueAccent,
              ),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                  child:
                      Text("Build products for millions of users in Australia"))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.circle,
                size: 10,
                color: Colors.blueAccent,
              ),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                child: Text("Hybrid and flexible working environment"),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }

  Widget buildScope(BuildContext context) {
    return Container(
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.timer,
            color: Colors.grey,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            "${widget.project.projectScopeFlag == 0 ? "One to three months" : "Three to six months"}",
          ),
        ],
      ),
    );
  }

  Widget buildStudentNumber(BuildContext context) {
    String studentStr;
    if (widget.project.numberOfStudents == 1) {
      studentStr = "1 - 1 student";
    } else if (widget.project.numberOfStudents == null) {
      studentStr = "0 student";
    } else {
      studentStr = "1 - ${widget.project.numberOfStudents} students";
    }
    return Container(
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.supervised_user_circle_outlined,
            color: Colors.grey,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(studentStr),
        ],
      ),
    );
  }

  Widget buildSkillRequired(BuildContext context) {
    return Container(
      width: DeviceUtils.getScaledWidth(context, 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Skills: ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 15,
          ),
          Wrap(crossAxisAlignment: WrapCrossAlignment.start, children: [
            Container(
              margin: EdgeInsets.only(right: 10, bottom: 10),
              padding: EdgeInsets.fromLTRB(14, 5, 14, 5),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(100)),
              child: Text("Skill 1 Skill 1 Skill 1 Skill 1 Skill 1 "),
            ),
            Container(
              margin: EdgeInsets.only(right: 10, bottom: 10),
              padding: EdgeInsets.fromLTRB(14, 5, 14, 5),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(100)),
              child: Text("Skill 2"),
            ),
            Container(
              margin: EdgeInsets.only(right: 10, bottom: 10),
              padding: EdgeInsets.fromLTRB(14, 5, 14, 5),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(100)),
              child: Text("Skill 3 "),
            ),
          ])
        ],
      ),
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
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        SubmitProject(projectId: widget.project.projectId!)),
              );
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
          GestureDetector(
            onTap: () {
              _addFavoriteByStudentIdUseCase.call(
                  params: AddProjectParams(
                      projectId: widget.project.projectId != null
                          ? widget.project.projectId!
                          : widget.project.id!,
                      disableFlag: widget.project.isFavorite! ? 1 : 0));
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
                "Save",
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
