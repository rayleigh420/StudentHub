import 'package:boilerplate/core/widgets/skill_set_widget.dart';
import 'package:flutter/material.dart';

class ExpItem {
  final String title;
  final String time;
  final String? description;

  ExpItem({required this.title, required this.time, this.description});
}

class ExpWidget extends StatefulWidget {
  final Color borderColor;
  final String educationText;
  final List<ExpItem> educationItems;

  final bool isProject;

  ExpWidget(
      {required this.borderColor,
      required this.educationText,
      required this.educationItems,
      required this.isProject});

  @override
  _ExpWidgetState createState() => _ExpWidgetState();
}

class _ExpWidgetState extends State<ExpWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.65,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.educationText,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: widget.borderColor,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          padding: const EdgeInsets.all(4.0),
                          child: IconButton(
                            icon: Icon(
                              Icons.add,
                              size: 17,
                            ),
                            onPressed: _addExperience,
                          )),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 16),
        for (var item in widget.educationItems) buildExpItem(context, item),
      ],
    );
  }

  void _addExperience() {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    DateTime? startMonth;
    DateTime? endMonth;

    void _selectDate(BuildContext context, bool isStartMonth) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101),
      );
      if (picked != null)
        setState(() {
          if (isStartMonth) {
            startMonth = picked;
          } else {
            endMonth = picked;
          }
        });
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
              child: Container(
            child: Text(
              'Add a experience',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
          )),
          content: Container(
            height: MediaQuery.of(context).size.height * 2 / 3,
            width: MediaQuery.of(context).size.width * 14 / 15,
            child: Column(
              children: <Widget>[
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(hintText: "Title"),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(hintText: "Description"),
                ),
                TextField(
                  readOnly: true,
                  onTap: () => _selectDate(context, true),
                  controller: TextEditingController(
                      text: startMonth?.toIso8601String()),
                  decoration: InputDecoration(hintText: "Start Month"),
                ),
                TextField(
                  readOnly: true,
                  onTap: () => _selectDate(context, false),
                  controller:
                      TextEditingController(text: endMonth?.toIso8601String()),
                  decoration: InputDecoration(hintText: "End Month"),
                ),
                SizedBox(height: 20.0),
                SkillSetWidget(borderColor: widget.borderColor)
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Done'),
              onPressed: () {
                setState(() {
                  // Replace this with your actual code to add the experience to the list
                  // experiences.add(Experience(
                  //   title: titleController.text,
                  //   description: descriptionController.text,
                  // ));
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget buildExpItem(BuildContext context, ExpItem item) {
    return Container(
        margin: EdgeInsets.only(bottom: 15),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      item.time,
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: widget.borderColor,
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
                        const SizedBox(width: 10),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: widget.borderColor,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.delete,
                            size: 17,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.description!,
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 20.0),
                SkillSetWidget(borderColor: widget.borderColor)
              ],
            )
          ],
        ));
  }

  // void addSkillSet() {
  //   final newSkillSet = skillSetTextController.text.trim();
  //   if (newSkillSet.isNotEmpty && !skillsets.contains(newSkillSet)) {
  //     setState(() {
  //       skillsets.add(newSkillSet);
  //     });
  //     skillSetTextController.clear();
  //     skillSetFocusNode.requestFocus();
  //   }
  // }

  // void _removeTag(int index) {
  //   setState(() {
  //     skillsets.removeAt(index);
  //   });
  // }

  // Widget buildTags(BuildContext context) {
  //   return Row(
  //     children: [
  //       Wrap(
  //         spacing: 8.0,
  //         runSpacing: 8.0,
  //         children: List<Widget>.generate(
  //           skillsets.length,
  //           (i) => buildSkillsetItem(context, i),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // Widget buildSkillsetSection(BuildContext context, Color borderColor) {
  //   return Container(
  //     padding: const EdgeInsets.all(8.0),
  //     decoration: BoxDecoration(
  //       border: Border.all(
  //         color: borderColor,
  //         width: 1,
  //       ),
  //     ),
  //     child: Column(
  //       children: [
  //         Wrap(
  //           children: [
  //             for (int i = 0; i < skillsets.length; i++)
  //               Padding(
  //                 padding: const EdgeInsets.symmetric(horizontal: 4.0),
  //                 child: Chip(
  //                   label: Text(skillsets[i]),
  //                   deleteIcon: Icon(
  //                     Icons.close,
  //                     size: 15,
  //                   ),
  //                   onDeleted: () => _removeTag(i),
  //                 ),
  //               ),
  //             Row(
  //               children: [
  //                 Expanded(
  //                   child: TextField(
  //                     focusNode: skillSetFocusNode,
  //                     onTapOutside: (event) {
  //                       FocusScope.of(context).unfocus();
  //                     },
  //                     controller: skillSetTextController,
  //                     decoration: InputDecoration(
  //                       border: InputBorder.none,
  //                       hintText: 'Enter a tag',
  //                     ),
  //                     onSubmitted: (_) {
  //                       addSkillSet();
  //                     },
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         )
  //       ],
  //     ),
  //   );
  // }

  // Widget buildSkillsetItem(BuildContext context, int i) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 4.0),
  //     child: Chip(
  //       label: Text(skillsets[i]),
  //       deleteIcon: Icon(Icons.close),
  //       onDeleted: () => _removeTag(i),
  //     ),
  //   );
  // }
}
