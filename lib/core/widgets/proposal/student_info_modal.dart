import 'dart:developer';

import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/core/widgets/proposal/pdf_view_page.dart';
import 'package:boilerplate/data/network/apis/pdf_api/pdf_api.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/domain/entity/profile/student.dart';
import 'package:boilerplate/domain/entity/project_2/project.dart';
import 'package:boilerplate/domain/entity/proposal/itemProposal.dart';
import 'package:boilerplate/domain/entity/proposal/proposal.dart';
import 'package:boilerplate/domain/usecase/favorite/add_favorite_by_student_id.dart';
import 'package:boilerplate/domain/usecase/proposal/update_proposal.dart';
// import 'package:boilerplate/domain/entity/project/project.dart';
import 'package:boilerplate/presentation/home/store/theme/theme_store.dart';
import 'package:boilerplate/presentation/project/student/submit_project.dart';
import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class StudentInfoModal extends StatefulWidget {
  final int projectId;
  final int studentId;
  final Student student;
  StudentInfoModal(
      {super.key,
      required this.projectId,
      required this.studentId,
      required this.student});
  @override
  State<StudentInfoModal> createState() => _StudentInfoModalState();
}

class _StudentInfoModalState extends State<StudentInfoModal> {
  final ThemeStore _themeStore = getIt<ThemeStore>();
  AddFavoriteByStudentIdUseCase _addFavoriteByStudentIdUseCase =
      getIt<AddFavoriteByStudentIdUseCase>();
  final UpdateProposalUseCase _updateProposalUseCase =
      getIt<UpdateProposalUseCase>();
  final DioClient _dioClient = getIt<DioClient>();
  String resumeUrl = "";
  String transcriptUrl = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getTranscriptAndResume();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _getTranscriptAndResume() async {
    final responseResume = await _dioClient.dio.get(
        Endpoints.baseUrl + '/api/profile/student/${widget.studentId}/resume');
    final responseTranscript = await _dioClient.dio.get(Endpoints.baseUrl +
        '/api/profile/student/${widget.studentId}/transcript');
    if (responseResume.statusCode == 200) {
      setState(() {
        resumeUrl = responseResume.data['result'];
        log("resumeUrl: " + resumeUrl);
      });
    }
    if (responseTranscript.statusCode == 200) {
      setState(() {
        transcriptUrl = responseTranscript.data['result'];
        log("transcriptUrl: " + transcriptUrl);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
            top: BorderSide(
                color:
                    _themeStore.darkMode ? Colors.white : Colors.transparent)),
        color: _themeStore.darkMode ? Color(0xff2E3239) : Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      width: DeviceUtils.getScaledWidth(context, 1),
      height: DeviceUtils.getScaledHeight(context, 0.8),
      child: Container(
        padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildCompanyAndJobTitle(context),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  // buildScope(context),

                  // buildStudentNumber(context),
                  const SizedBox(
                    height: 20,
                  ),
                  buildStudentLookingFor(context),
                  const SizedBox(
                    height: 20,
                  ),
                  buildSkillRequired(context),
                  const SizedBox(
                    height: 20,
                  ),
                  buildExperience(context),
                  const SizedBox(
                    height: 20,
                  ),
                  buildEducations(context),
                  const SizedBox(
                    height: 20,
                  ),
                  buildLanguages(context),

                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
            buildButtons(context)
          ],
        ),
      ),
    );
  }

  Widget buildCompanyAndJobTitle(BuildContext context) {
    final w = DeviceUtils.getScaledWidth(context, 0.14);
    const img = kIsWeb
        ? AssetImage('/images/company.png')
        : AssetImage('assets/images/company.png');
    return Container(
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
            child: Image(
              image: img,
              width: w,
              height: w,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Student",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: DeviceUtils.getScaledWidth(context, 0.7),
                child: Text(
                  widget.student.user!.fullname!,
                  overflow: TextOverflow.fade,
                  // style: TextStyle(fontSize: 14),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget buildStudentLookingFor(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: Colors.grey,
        border: Border(
            top: BorderSide(color: Colors.grey),
            bottom: BorderSide(color: Colors.grey)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20, bottom: 10),
            child: const Text("Resume & Transcript"),
          ),
          Container(
            child: Builder(
              builder: (context) {
                if (resumeUrl == "") {
                  return Container(
                    child: Text("This student has not uploaded resume yet."),
                  );
                } else {
                  return GestureDetector(
                    onTap: () async {
                      if (resumeUrl != "") {
                        // final file = await PDFApi.loadNetwork(resumeUrl);
                        // Navigator.of(context, rootNavigator: true).push(
                        //     MaterialPageRoute(
                        //         builder: (context) => PdfViewerPage(file: file),
                        //         maintainState: true));
                        PDFApi.loadNetwork(resumeUrl).then((file) =>
                            Navigator.of(context, rootNavigator: false).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PdfViewerPage(file: file),
                                    maintainState: false)));
                      }
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.circle,
                          size: 10,
                          color: Colors.blueAccent,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                            child: Text("Tap here to view resume",
                                overflow: TextOverflow.ellipsis))
                      ],
                    ),
                  );
                }
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            child: Builder(
              builder: (context) {
                if (transcriptUrl == "") {
                  return Container(
                    child:
                        Text("This student has not uploaded transcript yet."),
                  );
                } else {
                  return GestureDetector(
                    onTap: () {
                      if (transcriptUrl != "") {
                        // final file = await PDFApi.loadNetwork(transcriptUrl);
                        PDFApi.loadNetwork(transcriptUrl).then((file) =>
                            Navigator.of(context, rootNavigator: true).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        PdfViewerPage(file: file),
                                    maintainState: true)));
                      }
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.circle,
                          size: 10,
                          color: Colors.blueAccent,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                            child: Text("Tap here to view transcript",
                                overflow: TextOverflow.ellipsis))
                      ],
                    ),
                  );
                }
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }

  Widget buildSkillRequired(BuildContext context) {
    Widget a = Container();
    if (widget.student.skillSets!.length != 0) {
      a = Wrap(crossAxisAlignment: WrapCrossAlignment.start, children: [
        ListView.builder(
            itemCount: widget.student.skillSets!.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(right: 10, bottom: 10),
                padding: EdgeInsets.fromLTRB(14, 5, 14, 5),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(100)),
                child: Text(widget.student.skillSets![index].name!),
              );
            }),
      ]);
    } else {
      a = Wrap(crossAxisAlignment: WrapCrossAlignment.start, children: [
        Container(
          margin: EdgeInsets.only(right: 10, bottom: 10),
          padding: EdgeInsets.fromLTRB(14, 8, 14, 8),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(100)),
          child: Text(
            "This student has not added any skills yet.",
            textAlign: TextAlign.center,
          ),
        ),
      ]);
    }

    return Container(
      width: DeviceUtils.getScaledWidth(context, 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Skills: ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 15,
          ),
          a,
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  Widget buildExperience(BuildContext context) {
    Widget a = Container();
    if (widget.student.experiences!.length != 0) {
      a = Wrap(crossAxisAlignment: WrapCrossAlignment.start, children: [
        ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.student.experiences!.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(right: 10, bottom: 10),
                padding: EdgeInsets.fromLTRB(14, 5, 14, 5),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(100)),
                child: Text(widget.student.experiences![index].title!),
              );
            }),
      ]);
    } else {
      a = Wrap(crossAxisAlignment: WrapCrossAlignment.start, children: [
        Container(
          margin: EdgeInsets.only(right: 10, bottom: 10),
          padding: EdgeInsets.fromLTRB(14, 8, 14, 8),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(100)),
          child: Text(
            "This student has not added any experiences yet.",
            textAlign: TextAlign.center,
          ),
        ),
      ]);
    }

    return Container(
      width: DeviceUtils.getScaledWidth(context, 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Experiences: ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 15,
          ),
          a,
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  Widget buildEducations(BuildContext context) {
    Widget a = Container();
    if (widget.student.educations!.length != 0) {
      a = Wrap(crossAxisAlignment: WrapCrossAlignment.start, children: [
        ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: widget.student.educations!.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(right: 10, bottom: 10),
                padding: EdgeInsets.fromLTRB(14, 5, 14, 5),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(100)),
                child: Text(widget.student.educations![index].schoolName!),
              );
            }),
      ]);
    } else {
      a = Wrap(crossAxisAlignment: WrapCrossAlignment.start, children: [
        Container(
          margin: EdgeInsets.only(right: 10, bottom: 10),
          padding: EdgeInsets.fromLTRB(14, 8, 14, 8),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(100)),
          child: Text(
            "This student has not added any educations yet.",
            textAlign: TextAlign.center,
          ),
        ),
      ]);
    }

    return Container(
      width: DeviceUtils.getScaledWidth(context, 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Education: ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 15,
          ),
          a,
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  Widget buildLanguages(BuildContext context) {
    Widget a = Container();
    if (widget.student.languages!.length != 0) {
      a = Wrap(crossAxisAlignment: WrapCrossAlignment.start, children: [
        ListView.builder(
            itemCount: widget.student.languages!.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(right: 10, bottom: 10),
                padding: EdgeInsets.fromLTRB(14, 5, 14, 5),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(100)),
                child: Text(widget.student.languages![index].languageName!),
              );
            }),
      ]);
    } else {
      a = Wrap(crossAxisAlignment: WrapCrossAlignment.start, children: [
        Container(
          margin: EdgeInsets.only(right: 10, bottom: 10),
          padding: EdgeInsets.fromLTRB(14, 8, 14, 8),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(100)),
          child: Text(
            "This student has not added any languages yet.",
            textAlign: TextAlign.center,
          ),
        ),
      ]);
    }

    return Container(
      width: DeviceUtils.getScaledWidth(context, 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Languages: ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 15,
          ),
          a,
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  Widget buildButtons(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey)),
      ),
      width: DeviceUtils.getScaledWidth(context, 1),
      padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
      alignment: Alignment.center,
      child: Container(),
    );
  }
}
