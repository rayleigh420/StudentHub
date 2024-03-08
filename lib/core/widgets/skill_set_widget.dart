import 'package:flutter/material.dart';

class SkillSetWidget extends StatefulWidget {
  final Color borderColor;
  const SkillSetWidget({Key? key, required this.borderColor}) : super(key: key);

  @override
  _SkillSetWidgetState createState() => _SkillSetWidgetState();
}

class _SkillSetWidgetState extends State<SkillSetWidget> {
  final List<String> skillsets = [];
  final FocusNode skillSetFocusNode = FocusNode();
  final TextEditingController skillSetTextController = TextEditingController();

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

  Widget buildSkillsetSection(BuildContext context, Color borderColor) {
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
}
