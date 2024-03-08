import 'dart:developer';

import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/home/store/theme/theme_store.dart';
import 'package:boilerplate/core/widgets/exp_widget.dart';
import 'package:boilerplate/presentation/profile/resume_upload.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:textfield_tags/textfield_tags.dart';

class ProfileInput2 extends StatefulWidget {
  const ProfileInput2({super.key});

  @override
  State<ProfileInput2> createState() => _ProfileInput2State();
}

const List<String> techStacks = <String>[
  'Full Stack Developer',
  'Dev Ops',
  'Flutter Developer',
  'React Native Developer',
  'Android Developer',
  'IOS Developer',
];

class _ProfileInput2State extends State<ProfileInput2> {
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
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
        
        SliverToBoxAdapter(

          child: Container(
            padding: const EdgeInsets.all(20.0),
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
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 20.0),
                buildProject(context),

                // const SizedBox(height: 30),
                // const SizedBox(height: 30),

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
        ),
        SliverFillRemaining(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              buildNext(context),
              const SizedBox(height: 20),
            ],
          ),
        )
      ]),
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

  Widget buildProject(BuildContext context) {
    return ExpWidget(
      borderColor: borderColor,
      educationText: "Projects",
      educationItems: [
        ExpItem(
            title: "Intelligent Taxi Dispatching system",
            time: '9/2020 - 12/2020, 4 months',
            description:
                'It is the developer of a super-app for ride-hailing, food delivery, and digital payments services on mobile devices that operates in Singapore, Malaysia, ..'),
        ExpItem(
            title: "Intelligent Taxi Dispatching system",
            time: '9/2020 - 12/2020, 4 months',
            description:
                'It is the developer of a super-app for ride-hailing, food delivery, and digital payments services on mobile devices that operates in Singapore, Malaysia, ..'),
        ExpItem(
            title: "Intelligent Taxi Dispatching system",
            time: '9/2020 - 12/2020, 4 months',
            description:
                'It is the developer of a super-app for ride-hailing, food delivery, and digital payments services on mobile devices that operates in Singapore, Malaysia, ..'),
      ],
      isProject: true,
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
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
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
