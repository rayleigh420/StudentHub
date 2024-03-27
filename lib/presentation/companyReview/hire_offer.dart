import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:boilerplate/core/widgets/toggle_button.dart';

class HireOffer extends StatefulWidget {
  @override
  _HireOfferState createState() => _HireOfferState();
}

class _HireOfferState extends State<HireOffer> {
  int selectedIndex = 0;
  List<Widget> _widgetOptions = [];
  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
      Proposal(
        // selected: selectedIndex,
        setSelected: (p0) {
          print(p0);
          setState(() {
            selectedIndex = p0;
          });
        },
      ),
      ProjectDetail_2(
        selected: selectedIndex,
        setSelected: (p0) {
          print(p0);
          setState(() {
            selectedIndex = p0;
          });
        },
      ),
      Text("Message"),
      Text("Hired"),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Hire Offer"),
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
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
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Text(
                        "Senior frontend developer (Fintech)",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: ToggleButtonsCompanyDetail(
                        selected: selectedIndex,
                        setSelected: (value) {
                          print(value);
                          setState(() {
                            selectedIndex = value;
                          });
                        },
                      ),
                    ),
                    // Proposal()
                    _widgetOptions[selectedIndex]
                  ],
                ),
              )),
        ),
      ),
    );
  }
}

class Proposal extends StatelessWidget {
  final Function(int) setSelected;
  const Proposal({super.key, required this.setSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 15),
          padding: EdgeInsets.only(top: 10, bottom: 10),
          decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(width: 1.0), top: BorderSide(width: 1.0)),
          ),
          child: Wrap(
            children: [
              Text(
                "Students are looking for",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                "- Clear expectation about your project or deliverables",
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "- The skills required for your project",
                style: TextStyle(fontSize: 14),
              ),
              Text(
                "- Detail about your project",
                style: TextStyle(fontSize: 14),
              )
            ],
          ),
        ),
        Container(
            margin: const EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      child: Icon(
                        Icons.person,
                        size: 70,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hung Le",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "4th year student",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Full Stack Engineer",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      "Excellent",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Text(
                    "I have gone through your project and it seem like a great project. I will commit for your project... ",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 30,
                      width: 160,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  side: BorderSide(color: Colors.black))),
                          onPressed: () {
                            setSelected(2);
                          },
                          child: const Text(
                              style: TextStyle(fontSize: 16), "Message")),
                    ),
                    SizedBox(
                      height: 30,
                      width: 160,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  side: BorderSide(color: Colors.black))),
                          onPressed: () {
                            // setSelected(3);
                            showCupertinoDialog(
                                context: context,
                                builder: (context) {
                                  return CupertinoAlertDialog(
                                    title: Text("Hired offer"),
                                    content: Text(
                                        "Do you really want to send hired offer for student to do this project?"),
                                    actions: <Widget>[
                                      CupertinoDialogAction(
                                        child: Text("Cancel", style: TextStyle(color: Colors.red)),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      CupertinoDialogAction(
                                        child: Text("Send"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          setSelected(3);
                                        },
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: const Text(
                              style: TextStyle(fontSize: 16), "Hire")),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            )),
        SizedBox(
          height: 20,
        ),
        Container(
            margin: const EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      child: Icon(
                        Icons.person,
                        size: 70,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Quan Nguyen",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "3th year student",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Full Stack Engineer",
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      "Excellent",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Text(
                    "I have gone through your project and it seem like a great project. I will commit for your project... ",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 30,
                      width: 160,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  side: BorderSide(color: Colors.black))),
                          onPressed: () {
                            setSelected(2);
                          },
                          child: const Text(
                              style: TextStyle(fontSize: 16), "Message")),
                    ),
                    SizedBox(
                      height: 30,
                      width: 160,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  side: BorderSide(color: Colors.black))),
                          onPressed: () {
                            // setSelected(3);
                            showCupertinoDialog(
                                context: context,
                                builder: (context) {
                                  return CupertinoAlertDialog(
                                    title: Text("Hired offer"),
                                    content: Text(
                                        "Do you really want to send hired offer for student to do this project?"),
                                    actions: <Widget>[
                                      CupertinoDialogAction(
                                        child: Text("Cancel", style: TextStyle(color: Colors.red)),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      CupertinoDialogAction(
                                        child: Text("Send"),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          setSelected(3);
                                        },
                                      ),
                                    ],
                                  );
                                });
                          },
                          child: const Text(
                              style: TextStyle(fontSize: 16), "Hired")),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            )),
        SizedBox(
          height: 50,
        ),
      ],
    );
  }
}

class ProjectDetail_2 extends StatelessWidget {
  final int selected;
  final Function(int) setSelected;
  const ProjectDetail_2(
      {super.key, required this.selected, required this.setSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 15),
          padding: EdgeInsets.only(top: 10, bottom: 10),
          decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(width: 1.0), top: BorderSide(width: 1.0)),
          ),
          child: Wrap(
            children: [
              Text(
                "Students are looking for",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                "- Clear expectation about your project or deliverables",
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "- The skills required for your project",
                style: TextStyle(fontSize: 14),
              ),
              Text(
                "- Detail about your project",
                style: TextStyle(fontSize: 14),
              )
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.access_alarm,
              size: 30,
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Project scope"),
                Text(
                  "- 3 to 6 month",
                  style: TextStyle(fontSize: 14),
                )
              ],
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.people,
              size: 30,
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Student required:"),
                Text(
                  "- 6 students",
                  style: TextStyle(fontSize: 14),
                )
              ],
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 30),
          alignment: Alignment.bottomRight,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(color: Colors.black))),
              onPressed: () {},
              child: const Text(style: TextStyle(fontSize: 16), "Post job")),
        ),
      ],
    );
  }
}
