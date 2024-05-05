import 'package:boilerplate/core/widgets/project_modal.dart';
import 'package:boilerplate/domain/entity/project_2/project.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';

class SubmitedProjectItem extends StatefulWidget {
  final int? offer;
  final Project projDat;
  const SubmitedProjectItem({Key? key, required this.projDat, this.offer})
      : super(key: key);
  @override
  _SubmitedProjectItemState createState() => _SubmitedProjectItemState();
}

class _SubmitedProjectItemState extends State<SubmitedProjectItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          showModalBottomSheet(
            isDismissible: true,
            context: context,
            isScrollControlled: true,
            useRootNavigator: true,
            enableDrag: true,
            backgroundColor: Colors.transparent,
            builder: (context) {
              return ProjectModal(
                apply: true,
                offer: widget.offer,
                project: widget.projDat,
              );
            },
          );
        },
        child: Container(
            padding: EdgeInsets.fromLTRB(12, 16, 8, 16),
            margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Color(0xFF2e3239)
                  : Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey, width: 0.6),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  offset: Offset(0, 2),
                  spreadRadius: 2,
                  blurRadius: 2,
                )
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // decoration: BoxDecoration(
                  //   border: Border.all(color: Colors.grey),
                  //   borderRadius: BorderRadius.circular(8),
                  // ),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.projDat.title!,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "${AppLocalizations.of(context).translate('submitted_text')} 3 ${AppLocalizations.of(context).translate('days_ago_text')}",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                          AppLocalizations.of(context)
                              .translate('student_looking_for_text'),
                          style: TextStyle(fontSize: 13)),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 5.0),
                            child: Text("-   ${widget.projDat.description!}",
                                style: TextStyle(fontSize: 13)),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }
}
