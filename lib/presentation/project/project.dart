import 'package:flutter/material.dart';

class ProjectScreen extends StatefulWidget {
  final bool isNew;

  ProjectScreen({required this.isNew});

  @override
  _ProjectScreenState createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.isNew) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showDialog();
      });
    }
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Popup Title"),
          content: Text("This is the content of the popup."),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(18, 10, 20, 0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: Container(
                  height: 40,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search for projects',
                      contentPadding: EdgeInsets.fromLTRB(16, 17, 16, 0),
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                )),
                SizedBox(
                  width: 10,
                ),
                IconButton(
                  icon: Icon(Icons.favorite),
                  onPressed: () {
                    // Handle button press
                  },
                )
              ],
            )
          ],
        ));
  }
}
