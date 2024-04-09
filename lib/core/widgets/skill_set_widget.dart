import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/domain/entity/skillSet/skillSet.dart';
import 'package:boilerplate/domain/usecase/skillSet/get_skill_set.dart';
import 'package:flutter/material.dart';

class SkillSetWidget extends StatefulWidget {
  final Color borderColor;
  final Function? changeSkillSet;
  final List<SkillSet>? skillPrev;
  const SkillSetWidget(
      {Key? key,
      required this.borderColor,
      this.changeSkillSet,
      this.skillPrev})
      : super(key: key);

  @override
  _SkillSetWidgetState createState() => _SkillSetWidgetState();
}

class _SkillSetWidgetState extends State<SkillSetWidget> {
  final GetSkillSetUC _getSkillSetUC = getIt<GetSkillSetUC>();
  List<SkillSet> skillSets = [];
  int? skillSetId;
  final List<SkillSet> skills = [];

  final FocusNode skillSetFocusNode = FocusNode();
  final TextEditingController skillSetTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      if (widget.skillPrev != null) {
        skills.addAll(widget.skillPrev!);
      }
    });
    getSkillSet();
  }

  void getSkillSet() async {
    final skillSetList = await _getSkillSetUC.call(params: null);

    setState(() {
      skillSets = skillSetList.SkillSets!;
    });
    // log(techStackList.techStacks.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Skill Set:',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20.0),
        buildSkillsetSection(context, widget.borderColor)
      ],
    );
  }

  void addSkillSet() {
    final newSkillSet = skillSetTextController.text.trim();
    if (newSkillSet.isNotEmpty &&
        skillSets.any((skill) => skill.name == newSkillSet) &&
        !skills.any((skill) => skill.name == newSkillSet)) {
      print("Hello");
      setState(() {
        skills.add(skillSets.firstWhere((skill) => skill.name == newSkillSet));
      });
      if (widget.changeSkillSet != null) {
        widget.changeSkillSet!(skills);
      }
      skillSetTextController.clear();
      skillSetFocusNode.requestFocus();
    }
    skillSetTextController.clear();
    skillSetFocusNode.requestFocus();
  }

  void _removeTag(int index) {
    setState(() {
      skills.removeWhere((skill) => skill.id! == index);
    });
    widget.changeSkillSet!(skills);
  }

  Widget buildTags(BuildContext context) {
    return Row(
      children: [
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: List<Widget>.generate(
            skills.length,
            (i) => buildSkillsetItem(context, i),
          ),
        ),
      ],
    );
  }

  Widget buildSkillsetSection(BuildContext context, Color borderColor) {
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
              for (int i = 0; i < skills.length; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Chip(
                    label: Text(skills[i].name!),
                    deleteIcon: Icon(
                      Icons.close,
                      size: 15,
                    ),
                    onDeleted: () => _removeTag(skills[i].id!),
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
        label: Text(skills[i].name!),
        deleteIcon: Icon(Icons.close),
        onDeleted: () => _removeTag(skills[i].id!),
      ),
    );
  }
}
