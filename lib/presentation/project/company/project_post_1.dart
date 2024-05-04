import 'package:boilerplate/core/widgets/appBar.dart';
import 'package:boilerplate/presentation/project/company/project_post_2.dart';
import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProjectPost1 extends StatefulWidget {
  @override
  _ProjectPost1State createState() => _ProjectPost1State();
}

class _ProjectPost1State extends State<ProjectPost1> {
  final TextEditingController _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarItem(),
      body: SafeArea(
        child: Container(
            padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
            child: GestureDetector(
              onTap: () {
                final currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "1/4 Let's start with a strong title",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "This helps your post stand out to the right students. It's the first thing they'll see, so make it impressive!",
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _titleController,
                    onTapOutside: (event) {
                      DeviceUtils.hideKeyboard(context);
                    },
                    decoration: InputDecoration(
                      hintText: 'Write a title for jour post',
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Example titles",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Container(
                      margin: EdgeInsets.fromLTRB(15, 10, 0, 0),
                      child: Wrap(
                        children: [
                          Text(
                            "- Build responsive WordPress site with booking/payment functionality",
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            "- Facebook ad specialist need for product launch",
                            style: TextStyle(fontSize: 14),
                          )
                        ],
                      )),
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5))),
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true)
                              .push(MaterialPageRoute(
                                  builder: (context) => ProjectPost2(
                                        title: _titleController.text,
                                      ),
                                  maintainState: false));
                          // Navigator.pushNamed(context, '/project_post_2');
                        },
                        child: const Text(
                            style: TextStyle(fontSize: 16), "Next: Scope")),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
