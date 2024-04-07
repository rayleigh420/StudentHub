import 'package:boilerplate/core/widgets/skill_set_widget.dart';
import 'package:boilerplate/domain/entity/experiences/experience.dart';
import 'package:boilerplate/domain/entity/skillSet/skillSet.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpItem {
  final String title;
  final String time;
  final String? description;

  ExpItem({required this.title, required this.time, this.description});
}

class ExpWidget extends StatefulWidget {
  final Color borderColor;
  final String educationText;
  final List<Experience> experienceItems;
  Function addExperience;

  final bool isProject;

  ExpWidget(
      {required this.borderColor,
      required this.educationText,
      required this.experienceItems,
      required this.isProject,
      required this.addExperience});

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
        for (var item in widget.experienceItems) buildExpItem(context, item),
      ],
    );
  }

  void _addExperience() {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    List<SkillSet> skills = [];

    DateTime? startMonth;
    DateTime? endMonth;

    final startMonthController = TextEditingController();
    final endMonthController = TextEditingController();

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
            startMonthController.text = DateFormat('yyyy-MM-dd').format(picked);
          } else {
            endMonth = picked;
            endMonthController.text = DateFormat('yyyy-MM-dd').format(picked);
          }
        });
    }

    void changeSkillSet(List<SkillSet> skillSet) {
      skills = skillSet;
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
            height: MediaQuery.of(context).size.height * 1 / 2,
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
                  controller: startMonthController,
                  decoration: InputDecoration(hintText: "Start Month"),
                ),
                TextField(
                  readOnly: true,
                  onTap: () => _selectDate(context, false),
                  controller: endMonthController,
                  decoration: InputDecoration(hintText: "End Month"),
                ),
                SizedBox(height: 20.0),
                SkillSetWidget(
                    borderColor: widget.borderColor,
                    changeSkillSet: changeSkillSet)
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Done'),
              onPressed: () {
                widget.addExperience(Experience(
                  id: null,
                  title: titleController.text,
                  description: descriptionController.text,
                  startMonth: startMonth,
                  endMonth: endMonth,
                  skillSets: skills,
                ));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget buildExpItem(BuildContext context, Experience item) {
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
                      item.title!,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${DateFormat('yyyy-MM-dd').format(item.startMonth!)} - ${DateFormat('yyyy-MM-dd').format(item.endMonth!)}',
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
                SkillSetWidget(
                    borderColor: widget.borderColor, skillPrev: item.skillSets!)
              ],
            )
          ],
        ));
  }
}
