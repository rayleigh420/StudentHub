import 'package:flutter/material.dart';

class ExpItem {
  final String title;
  final String time;

  ExpItem({required this.title, required this.time});
}

class ExpWidget extends StatefulWidget {
  final Color borderColor;
  final String educationText;
  final List<ExpItem> educationItems;

  ExpWidget(
      {required this.borderColor,
      required this.educationText,
      required this.educationItems});

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
                        child: Icon(
                          Icons.add,
                          size: 17,
                        ),
                      ),
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

  Widget buildExpItem(BuildContext context, ExpItem item) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Row(
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
          )
        ],
      ),
    );
  }
}
