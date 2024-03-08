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
    return Center(
      child: const Text("ProjectScreen"),
    );
  }
}
