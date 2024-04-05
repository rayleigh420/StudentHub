import 'dart:developer';

import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/domain/entity/educations/education.dart';
import 'package:boilerplate/domain/entity/language/language_student.dart';
import 'package:boilerplate/domain/entity/language/language_student_list.dart';
import 'package:boilerplate/domain/entity/educations/education_list.dart';
import 'package:boilerplate/domain/entity/skillSet/skillSet.dart';
import 'package:boilerplate/domain/usecase/experience/get_experience_by_student_id.dart';
import 'package:boilerplate/domain/usecase/profile/create_profile_student_usecase.dart';
import 'package:boilerplate/domain/usecase/profile/profile_test_uc.dart';
import 'package:boilerplate/domain/usecase/skillSet/get_skill_set.dart';
import 'package:boilerplate/domain/entity/techStack/teachStack.dart';
import 'package:boilerplate/domain/usecase/common/get_tech_stack.dart';
import 'package:boilerplate/domain/usecase/education/get_education_by_student_id.dart';
import 'package:boilerplate/domain/usecase/language/get_language_by_student_id.dart';
import 'package:boilerplate/presentation/home/store/theme/theme_store.dart';
import 'package:boilerplate/core/widgets/exp_widget.dart';
import 'package:boilerplate/presentation/profile_input/profile_input_2.dart';
import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:textfield_tags/textfield_tags.dart';

class ProfileInput1 extends StatefulWidget {
  const ProfileInput1({super.key});

  @override
  State<ProfileInput1> createState() => _ProfileInput1State();
}

// const List<String> techStacks = <String>[
//   'Full Stack Developer',
//   'Dev Ops',
//   'Flutter Developer',
//   'React Native Developer',
//   'Android Developer',
//   'IOS Developer',
// ];

class _ProfileInput1State extends State<ProfileInput1> {
  final GetTechStackUseCase _getTechStackUseCase = getIt<GetTechStackUseCase>();
  List<TechStack> techStacks = [];
  int? techStacksValue;

  final GetSkillSetUC _getSkillSetUC = getIt<GetSkillSetUC>();
  List<SkillSet> skillSets = [];
  int? skillSetId;

  final GetLanguageByStudentIdUseCase _getLanguageByStudentIdUseCase =
      getIt<GetLanguageByStudentIdUseCase>();

  final GetEducationByStudentIdUseCase _getEducationByStudentIdUseCase =
      getIt<GetEducationByStudentIdUseCase>();

  final GetExperienceByStudentIdUseCase _getExperienceByStudentIdUseCase =
      getIt<GetExperienceByStudentIdUseCase>();

  final CreateProfileStudentUC _createProfileStudentUC =
      getIt<CreateProfileStudentUC>();

  final List<String> skillsets = [];
  final TextEditingController skillSetTextController = TextEditingController();

  final LanguageStudentList languages =
      LanguageStudentList(languageStudents: []);

  final EducationList educations = EducationList(educations: []);

  final FocusNode skillSetFocusNode = FocusNode();
  final ThemeStore _themeStore = getIt<ThemeStore>();
  Color borderColor = Colors.black;

  @override
  void initState() {
    super.initState();

    // _themeStore.changeBrightnessToDark(false);
    if (_themeStore.darkMode) {
      borderColor = Colors.white;
    } else {
      borderColor = Colors.black;
    }

    // getTechStacks();
    // getSkillSet();

    // getLanguageByStudentId();
    // getEducationByStudentId();
    // getExperienceByStudentId();

    // createProfileStudent();
  }

  void getTechStacks() async {
    final techStackList = await _getTechStackUseCase.call(params: null);
    setState(() {
      techStacks = techStackList.techStacks!;
      techStacksValue = techStacks.first.id;
    });
    // log(techStackList.techStacks.toString());
  }

  void getLanguageByStudentId() async {
    final languageList =
        await _getLanguageByStudentIdUseCase.call(params: null);
    // setState(() {
    //   languageList = languageList;
    // });
  }

  void getEducationByStudentId() async {
    final educationList =
        await _getEducationByStudentIdUseCase.call(params: null);
    // setState(() {
    //   educationList = educationList;
    // });
  }

  void getExperienceByStudentId() async {
    final experienceList =
        await _getExperienceByStudentIdUseCase.call(params: null);
    // setState(() {
    //   experienceList = experienceList;
    // });
  }

  void createProfileStudent() async {
    final result = await _createProfileStudentUC.call(
        params: CreateProfileStudentParams(
      techStackId: 1,
      skillSets: ['1', '2'],
    ));
    log(result.toString());
  }

  @override
  void dispose() {
    super.dispose();
  }

  // void handlePress() {
  //   _profileTestUC.call();
  // }

  void getSkillSet() async {
    final skillSetList = await _getSkillSetUC.call(params: null);
    // log(skillSetList.SkillSets.toString());

    setState(() {
      skillSets = skillSetList.SkillSets!;
      skillSetId = skillSets.first.id;
    });
    // log(techStackList.techStacks.toString());
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
            SizedBox(
              height: DeviceUtils.getScaledHeight(context, 0.8),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 17.0),

                    Text(
                      'Welcome to Student Hub',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // const SizedBox(height: 20.0),
                    // Text(
                    //   'Tell us about your self and you will be on your way connect with real-world project',
                    //   textAlign: TextAlign.center,
                    //   style:
                    //       TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                    // ),
                    // const SizedBox(height: 20.0),
                    // // const SizedBox(height: 17.0),
                    // Text(
                    //   'Tech Stack:',
                    //   textAlign: TextAlign.start,
                    //   style: TextStyle(
                    //     fontSize: 16,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    // const SizedBox(height: 10.0),
                    // DropdownMenu<String>(
                    //   onSelected: (value) {
                    //     setState(() {
                    //       techStacksValue = value!;
                    //     });
                    //   },
                    //   width: MediaQuery.of(context).size.width * 0.9,
                    //   initialSelection: techStacks!.first,
                    //   dropdownMenuEntries: techStacks
                    //       .map<DropdownMenuEntry<String>>(
                    //           (String value) => DropdownMenuEntry<String>(
                    //                 value: value,
                    //                 label: value,
                    //               ))
                    //       .toList(),
                    // ),
                    // const SizedBox(height: 20.0),
                    // Text(
                    //   'Skill Set:',
                    //   textAlign: TextAlign.start,
                    //   style: TextStyle(
                    //     fontSize: 16,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    // const SizedBox(height: 10.0),
                    // buildSkillsetSection(context),
                    // const SizedBox(height: 30),
                    // buildLanguage(context),
                    // const SizedBox(height: 30),
                    // buildEducation(context),
                    // const SizedBox(height: 30),
                    // buildEducation(context),
                    // const SizedBox(height: 30),
                    // buildEducation(context),

                    const SizedBox(height: 20.0),
                    Text(
                      'Tell us about your self and you will be on your way connect with real-world project',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 20.0),
                    // const SizedBox(height: 17.0),
                    Text(
                      'Tech Stack:',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    DropdownMenu<int>(
                      onSelected: (int? value) {
                        setState(() {
                          techStacksValue = value!;
                        });
                      },
                      width: MediaQuery.of(context).size.width * 0.9,
                      initialSelection: techStacksValue,
                      dropdownMenuEntries: techStacks
                          .map<DropdownMenuEntry<int>>(
                              (TechStack techStack) => DropdownMenuEntry<int>(
                                    value: techStack.id!,
                                    label: techStack.name!,
                                  ))
                          .toList(),
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      'Skill Set:',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    buildSkillsetSection(context),
                    const SizedBox(height: 30),
                    buildLanguage(context),
                    const SizedBox(height: 30),
                    buildEducation(context),
                  ],
                ),
              ),
            ),
            const Spacer(),
            buildNext(context),
          ],
        ),
      ),
    ));
  }

  void addSkillSet() {
    final newSkillSet = skillSetTextController.text.trim();
    if (newSkillSet.isNotEmpty && !skillsets.contains(newSkillSet)) {
      setState(() {
        skillsets.add(newSkillSet);
      });
      skillSetTextController.clear();
      skillSetFocusNode.requestFocus();
    }
  }

  void _removeTag(int index) {
    setState(() {
      skillsets.removeAt(index);
    });
  }

  Widget buildTags(BuildContext context) {
    return Row(
      children: [
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: List<Widget>.generate(
            skillsets.length,
            (i) => buildSkillsetItem(context, i),
          ),
        ),
      ],
    );
  }

  Widget buildSkillsetSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor,
          width: 0.05,
        ),
      ),
      child: Column(
        children: [
          Wrap(
            children: [
              for (int i = 0; i < skillsets.length; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Chip(
                    label: Text(skillsets[i]),
                    deleteIcon: Icon(
                      Icons.close,
                      size: 15,
                    ),
                    onDeleted: () => _removeTag(i),
                  ),
                ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      focusNode: skillSetFocusNode,
                      onTapOutside: (event) {
                        FocusScope.of(context).unfocus();
                      },
                      controller: skillSetTextController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter a tag',
                      ),
                      onSubmitted: (_) {
                        addSkillSet();
                      },
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildSkillsetItem(BuildContext context, int i) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Chip(
        label: Text(skillsets[i]),
        deleteIcon: Icon(Icons.close),
        onDeleted: () => _removeTag(i),
      ),
    );
  }

  Widget buildLanguage(BuildContext) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.65,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Language",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(right: 10),
                  // width: MediaQuery.of(context).size.width * 0.2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: borderColor,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(Icons.add, size: 17),
                        // ElevatedButton(
                        //     child: Icon(Icons.add, size: 17),
                        //     onPressed: _addLanguage,
                        //     style: ButtonStyle(
                        //       shape: MaterialStateProperty.all<
                        //           RoundedRectangleBorder>(
                        //         RoundedRectangleBorder(
                        //           borderRadius: BorderRadius.circular(999),
                        //         ),
                        //       ),
                        //     )),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: borderColor,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        padding: const EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.edit,
                          size: 17,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: languages.languageStudents!.map((language) {
            return Text(
              '${language.languageName}: ${language.level}',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 15,
              ),
            );
          }).toList(),
        )
      ],
    );
  }

  Widget buildEducation(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.65,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Education",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(right: 10),
                  // width: MediaQuery.of(context).size.width * 0.2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: borderColor,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        padding: const EdgeInsets.all(4.0),
                        child: IconButton(
                          icon: Icon(
                            Icons.add,
                            size: 17,
                            weight: 100,
                          ),
                          onPressed: _addEducation,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: educations.educations!.map((education) {
            return buildEducationItem(context, education);
          }).toList(),
        )
      ],
    );
  }

  void _addLanguage() {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController levelController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add a language'),
          content: Column(
            children: <Widget>[
              TextField(
                controller: nameController,
                decoration: InputDecoration(hintText: "Language name"),
              ),
              TextField(
                controller: levelController,
                decoration: InputDecoration(hintText: "Language level"),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Done'),
              onPressed: () {
                setState(() {
                  // Replace this with your actual code to add the language to the list
                  languages.languageStudents!.add(LanguageStudent(
                    id: null,
                    languageName: nameController.text,
                    level: levelController.text,
                  ));
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _addEducation() {
    final TextEditingController schoolController = TextEditingController();
    final TextEditingController startYearController = TextEditingController();
    final TextEditingController endYearController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add education'),
          content: Column(
            children: <Widget>[
              TextField(
                controller: schoolController,
                decoration: InputDecoration(hintText: "School name"),
              ),
              TextField(
                controller: startYearController,
                decoration: InputDecoration(hintText: "Start year"),
              ),
              TextField(
                controller: endYearController,
                decoration: InputDecoration(hintText: "End year"),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Done'),
              onPressed: () {
                setState(() {
                  // Replace this with your actual code to add the education to the list
                  educations.educations!.add(Education(
                    id: null,
                    schoolName: schoolController.text,
                    startYear: DateTime(int.parse(startYearController.text)),
                    endYear: DateTime(int.parse(endYearController.text)),
                  ));
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget buildEducationItem(BuildContext context, Education education) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                education.schoolName!,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '${education.startYear!.year} - ${education.endYear!.year}',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(right: 10),
              // width: MediaQuery.of(context).size.width * 0.2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: borderColor,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: const EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.edit,
                      size: 17,
                      weight: 100,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: borderColor,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    padding: const EdgeInsets.all(4.0),
                    child: IconButton(
                      icon: Icon(
                        Icons.delete,
                        size: 17,
                        weight: 100,
                      ),
                      onPressed: () {
                        setState(() {
                          educations.educations!.removeWhere((item) =>
                              item.schoolName == education.schoolName);
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildNext(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ElevatedButton(
            onPressed: () {
              log("push");
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) {
                return const ProfileInput2();
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
      ),
    );
  }
}
