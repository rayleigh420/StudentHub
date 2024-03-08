import 'dart:developer';

import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/home/store/theme/theme_store.dart';
import 'package:boilerplate/core/widgets/exp_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:textfield_tags/textfield_tags.dart';

class ProfileInput1 extends StatefulWidget {
  const ProfileInput1({super.key});

  @override
  State<ProfileInput1> createState() => _ProfileInput1State();
}

const List<String> techStacks = <String>[
  'Full Stack Developer',
  'Dev Ops',
  'Flutter Developer',
  'React Native Developer',
  'Android Developer',
  'IOS Developer',
];

class _ProfileInput1State extends State<ProfileInput1> {
  String techStacksValue = techStacks.first;
  final List<String> skillsets = [];
  final TextEditingController skillSetTextController = TextEditingController();
  final FocusNode skillSetFocusNode = FocusNode();
  final ThemeStore _themeStore = getIt<ThemeStore>();
  Color borderColor = Colors.grey;
  @override
  void initState() {
    super.initState();

    // _themeStore.changeBrightnessToDark(false);
    if (_themeStore.darkMode) {
      borderColor = Colors.white;
    } else {
      borderColor = Colors.black;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.all(20.0),
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
            const SizedBox(height: 20.0),
            Text(
              'Tell us about your self and you will be on your way connect with real-world project',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
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
            DropdownMenu<String>(
              onSelected: (value) {
                setState(() {
                  techStacksValue = value!;
                });
              },
              width: MediaQuery.of(context).size.width * 0.9,
              initialSelection: techStacks.first,
              dropdownMenuEntries: techStacks
                  .map<DropdownMenuEntry<String>>(
                      (String value) => DropdownMenuEntry<String>(
                            value: value,
                            label: value,
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
            buildNext(context),
            // Container(
            //   height: 500,
            //   decoration: BoxDecoration(
            //     border: Border.all(
            //       color: Colors.grey,
            //       width: 1,
            //     ),
            //   ),
            // ),
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
          width: 1,
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
                        child: Icon(
                          Icons.add,
                          size: 17,
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
        const SizedBox(height: 16),
        const Text(
          'Ennglish: Native',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  Widget buildEducation(BuildContext context) {
    return ExpWidget(
      borderColor: borderColor,
      educationText: "Education",
      educationItems: [
        ExpItem(title: "Le Hong Phong High School", time: '2008-2010'),
        ExpItem(title: "Ho Chi Minh University of Science", time: '2010-2014'),
      ],
      isProject: false,
    );
  }

  Widget buildNext(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ElevatedButton(
            onPressed: () {},
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
      // child: Column(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   children: [
      //     Container(
      //       alignment: Alignment.bottomCenter,
      //       child: Text("Dont have Student Hub account?"),
      //     ),
      //     GestureDetector(
      //       onTap: () {
      //         log("push");
      //         // Navigator.of(context)
      //         //     .pushReplacement(MaterialPageRoute(builder: (context) {
      //         //   return const SignUpIdentity();
      //         // }));
      //       },
      //       child: const Text(
      //         "Sign Up",
      //         style: TextStyle(
      //           color: Color(0xFF4285F4),
      //           fontWeight: FontWeight.bold,
      //         ),
      //       ),
      //     )
      //   ],
      // ),
    );
  }
}
