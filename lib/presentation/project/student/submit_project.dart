import 'package:boilerplate/core/widgets/appBar.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/domain/usecase/proposal/create_proposal.dart';
import 'package:flutter/material.dart';

class SubmitProject extends StatefulWidget {
  final int? projectId;
  const SubmitProject({required this.projectId});

  @override
  _SubmitProjectState createState() => _SubmitProjectState();
}

class _SubmitProjectState extends State<SubmitProject> {
  CreateProposalUseCase _createProposalUseCase = getIt<CreateProposalUseCase>();
  final coverLetterController = TextEditingController();

  @override
  void dispose() {
    coverLetterController.dispose();
    super.dispose();
  }

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
                    "Cover letter",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Describe why do you fit to this project",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: coverLetterController,
                    maxLines: 10,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.grey,
                        width: 5,
                      )),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                            onPressed: () {
                              // Navigator.pushNamed(context, '/project_post_4');
                            },
                            child: const Text(
                                style: TextStyle(fontSize: 16), "Cancel")),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 30),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                            onPressed: () {
                              _createProposalUseCase.call(
                                  params: CreateProposalParam(widget.projectId!,
                                      coverLetterController.text, 0));
                              Navigator.pop(context);
                            },
                            child: const Text(
                                style: TextStyle(fontSize: 16),
                                "Submit proposal")),
                      ),
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}
