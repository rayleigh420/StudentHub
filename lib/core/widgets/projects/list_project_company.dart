import 'package:boilerplate/core/widgets/projects/project_company_item.dart';
import 'package:flutter/cupertino.dart';

class ListProjectCompany extends StatefulWidget {
  @override
  _ListProjectCompanyState createState() => _ListProjectCompanyState();
}

class _ListProjectCompanyState extends State<ListProjectCompany> {
  final List<Project> projects = [
    Project(
        name: "Senior frontend developer (Fintech)",
        day: "Created 3 days ago",
        criteria: ["- Clear expectation about your project or deliverables"],
        proposals: 0,
        messages: 2,
        hired: 8)
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [1, 2, 3, 4]
            .map((e) => ProjectItemCompany(project: projects[0]))
            .toList(),
      ),
    );
  }
}
