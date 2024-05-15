import 'dart:developer';
import 'dart:math';

import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/domain/entity/experiences/experience.dart';
import 'package:boilerplate/domain/entity/experiences/experience_list.dart';
import 'package:boilerplate/domain/usecase/experience/udpate_experience_by_student_id.dart';
import 'package:boilerplate/presentation/home/store/theme/theme_store.dart';
import 'package:boilerplate/core/widgets/exp_widget.dart';
import 'package:boilerplate/presentation/profile/store/profile_store.dart';
import 'package:boilerplate/presentation/profile_input/student/resume_upload.dart';
import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:textfield_tags/textfield_tags.dart';

class ProfileStudentExperince extends StatefulWidget {
  const ProfileStudentExperince({super.key});

  @override
  State<ProfileStudentExperince> createState() =>
      _ProfileStudentExperinceState();
}

const List<String> techStacks = <String>[
  'Full Stack Developer',
  'Dev Ops',
  'Flutter Developer',
  'React Native Developer',
  'Android Developer',
  'IOS Developer',
];

class _ProfileStudentExperinceState extends State<ProfileStudentExperince> {
  final ProfileStore _profileStore = getIt<ProfileStore>();
  final UpdateExperienceByStudentIdUseCase updateExperienceByStudentIdUseCase =
      getIt<UpdateExperienceByStudentIdUseCase>();
  List<Experience> experiences = [];

  final TextEditingController skillSetTextController = TextEditingController();
  final FocusNode skillSetFocusNode = FocusNode();
  final ThemeStore _themeStore = getIt<ThemeStore>();
  Color borderColor = Colors.grey;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // check to see if already called api
    if (!_profileStore.loading) {
      _profileStore.getProfile();
    }
  }

  @override
  void initState() {
    super.initState();

    // _themeStore.changeBrightnessToDark(false);
    if (_themeStore.darkMode) {
      borderColor = Colors.white;
    } else {
      borderColor = Colors.black;
    }

    if (_profileStore.profile != null) {
      setState(() {
        experiences = _profileStore.profile!.student!.experiences!;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void AddExperience(Experience experience) {
    setState(() {
      experiences.add(experience);
    });
  }

  void RemoveExperience(Experience experience) {
    setState(() {
      experiences.remove(experience);
    });
  }

  void UpdateExperienceByStudentId() async {
    print('Updating experiences:');
    for (var experience in experiences) {
      print('Title: ${experience.title}');
      print('Description: ${experience.description}');
      print('Start Month: ${experience.startMonth}');
      print('End Month: ${experience.endMonth}');
      print(
          'Skill Sets: ${experience.skillSets!.map((e) => e.id.toString()).join(', ')}');
      print('---');
    }

    final result = await updateExperienceByStudentIdUseCase.call(
        params: ExperienceReqList(
      experiences: experiences.map((experience) {
        return ExperienceReq(
          id: null,
          title: experience.title,
          description: experience.description,
          startMonth: experience.startMonth,
          endMonth: experience.endMonth,
          skillSets: experience.skillSets!.map((e) => e.id.toString()).toList(),
        );
      }).toList(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              //height: DeviceUtils.getScaledHeight(context, 0.9),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  // padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 17.0),
                      Text(
                        'Experiences',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Text(
                        'Tell us about your self and you will be on your way connect with real-world project',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 20.0),
                      buildProject(context),
                      const SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: () {
                          UpdateExperienceByStudentId();
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) {
                            return const ResumeUpload();
                          }));
                        },
                        child: Text("Next",
                            style: TextStyle(
                                color: _themeStore.darkMode
                                    ? Colors.black
                                    : Colors.white)),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(borderColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0),
                                      side: BorderSide(color: borderColor))),
                          padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            // const Spacer(),
            // buildNext(context)
          ],
        ),
      ),
    ));
  }

  Widget buildProject(BuildContext context) {
    return ExpWidget(
      borderColor: borderColor,
      educationText: "Projects",
      isProject: true,
      experienceItems: experiences,
      addExperience: AddExperience,
    );
  }

  Widget buildNext(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: () {
            UpdateExperienceByStudentId();
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) {
              return const ResumeUpload();
            }));
          },
          child: Text("Next",
              style: TextStyle(
                  color: _themeStore.darkMode ? Colors.black : Colors.white)),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(borderColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                    side: BorderSide(color: borderColor))),
            padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(horizontal: 60, vertical: 15),
            ),
          ),
        )
      ],
    );
  }
}
