import 'package:boilerplate/core/widgets/appBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProjectPost1 extends StatefulWidget {
  @override
  _ProjectPost1State createState() => _ProjectPost1State();
}

class _ProjectPost1State extends State<ProjectPost1> {
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
                      ))
                ],
              ),
            )),
      ),
    );
  }
}