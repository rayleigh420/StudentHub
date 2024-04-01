import 'package:boilerplate/core/widgets/toggle_button.dart';
import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:flutter/material.dart';

class DashBoardScreen extends StatefulWidget {
  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}


class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
              
      child: Container(
          padding: EdgeInsets.fromLTRB(18, 10, 20, 0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                      style: TextStyle(fontWeight: FontWeight.w600),
                      "Your Projects"),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5))),
                      onPressed: () {},
                      child: const Text(
                          style: TextStyle(fontSize: 16), "Post a projects")),
                ],
              ),

              Container(
                margin: EdgeInsets.only(top: 20),
                child: Container(),
              ),

              InkWell(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.only(
                      top: DeviceUtils.getScaledHeight(context, 0.03)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                              style: TextStyle(fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Color.fromARGB(255, 15, 120, 17)),
                              "Senior front-end developer (Fintech)"),
                          Container(
                            margin: EdgeInsets.only(),
                            child: ElevatedButton(onPressed: (){},
                              style: ElevatedButton.styleFrom(
                
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(0),
                              foregroundColor: Colors.black,
                              side: BorderSide(color: Colors.black, width: 1),
                
                              ),
                             child: Icon(Icons.more_horiz)
                                ),
                          ) 
                        ],
                
                      ),
                      Container(
                        margin: EdgeInsets.only(left:5),
                        child: const Text(
                            style: TextStyle(fontWeight: FontWeight.w500),
                            "Created 3 days ago"),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: const Text(
                            style: TextStyle(fontWeight: FontWeight.w500),
                            "Student are looking for"),
                      ),
                      Container(
                        margin: EdgeInsets.only(left:30),
                        child: const Text(
                            style: TextStyle(fontWeight: FontWeight.w500),
                            ". Clear expectation about your project or deliverable"),
                      
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                  "2"),
                              const Text(
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                  "Proposal"),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                  "8"),
                              const Text(
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                  "Messages"),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                  "2"),
                              const Text(
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                  "Hired"),
                            ],
                          ),
                        ],
                      ),
                      
                      
                    ],
                  ),
                ),
              ),
              Container(
                    margin: EdgeInsets.only(top: 15),
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      border: Border(
                          
                          top: BorderSide(width: 1.0)),
                    ),
                    child: InkWell(
                      onTap: (){},
                      child: Container(
                                      margin: EdgeInsets.only(
                      top: DeviceUtils.getScaledHeight(context, 0.03)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                              style: TextStyle(fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Color.fromARGB(255, 15, 120, 17)),
                              "Senior front-end developer (Fintech)"),
                          Container(
                            margin: EdgeInsets.only(),
                            child: ElevatedButton(onPressed: (){},
                              style: ElevatedButton.styleFrom(
                      
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(0),
                              foregroundColor: Colors.black,
                              side: BorderSide(color: Colors.black, width: 1),
                      
                              ),
                             child: Icon(Icons.more_horiz)
                                ),
                          ) 
                        ],
                      
                      ),
                      Container(
                        margin: EdgeInsets.only(left:5),
                        child: const Text(
                            style: TextStyle(fontWeight: FontWeight.w500),
                            "Created 5 days ago"),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: const Text(
                            style: TextStyle(fontWeight: FontWeight.w500),
                            "Student are looking for"),
                      ),
                      Container(
                        margin: EdgeInsets.only(left:30),
                        child: const Text(
                            style: TextStyle(fontWeight: FontWeight.w500),
                            ". Clear expectation about your project or deliverable"),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                  "0"),
                              const Text(
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                  "Proposal"),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                  "8"),
                              const Text(
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                  "Messages"),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                  "2"),
                              const Text(
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                  "Hired"),
                            ],
                          ),
                        ],
                      ),
                      
                      
                                        ],
                                      ),
                                    ),
                    ),
                    )
            ],
          )),
        )
      )
    );
  }
}