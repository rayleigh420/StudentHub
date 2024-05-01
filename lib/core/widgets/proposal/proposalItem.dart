import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/domain/entity/message/message_user.dart';
import 'package:boilerplate/domain/entity/project_2/project.dart';
import 'package:boilerplate/domain/entity/proposal/itemProposal.dart';
import 'package:boilerplate/domain/usecase/proposal/update_proposal.dart';
import 'package:boilerplate/presentation/chat/message_detail.dart';
import 'package:boilerplate/presentation/chat/store/message_store.dart';
import 'package:boilerplate/presentation/navigations/bottomNavigationBar.dart';
import 'package:boilerplate/presentation/profile/store/profile_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProposalItems extends StatefulWidget {
  final ItemProposal? itemProposal;
  final Project project;
  const ProposalItems({super.key, this.itemProposal, required this.project});

  @override
  State<ProposalItems> createState() => _ProposalItemsState();
}

class _ProposalItemsState extends State<ProposalItems> {
  UpdateProposalUseCase _updateProposalUseCase = getIt<UpdateProposalUseCase>();
  final MessageStore _messageStore = getIt<MessageStore>();
  final ProfileStore _profileStore = getIt<ProfileStore>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
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
                            "${widget.itemProposal!.student?.user?.fullname!}",
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
                      widget.itemProposal!.student!.techStack!.name!,
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
                    widget.itemProposal!.coverLetter!,
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
                            //setSelected(2);
                            _updateProposalUseCase.call(
                                params: UpdateProposalParam(
                                    widget.itemProposal!.id,
                                    widget.itemProposal!.coverLetter!,
                                    1));
                            int index = _messageStore.newMessageListItem(
                                MessageUser(
                                    id: _profileStore.profile!.id,
                                    fullname: _profileStore.profile!.fullname),
                                MessageUser(
                                    id: widget.itemProposal!.student!.id,
                                    fullname: widget.itemProposal!.student!
                                            .user!.fullname ??
                                        ""),
                                widget.project);
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (context) => AppBottomNavigationBar(
                            //           selectedIndex: 1,
                            //         ),
                            //     maintainState: true));
                            Navigator.of(context, rootNavigator: true)
                                .push(MaterialPageRoute(
                                    builder: (context) => MessageDetail(
                                          index: index,
                                          projectId: widget.project.id!,
                                          receiverId:
                                              widget.itemProposal!.student!.id,
                                          senderId: _profileStore.profile!.id,
                                        ),
                                    maintainState: true));
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
                              widget.itemProposal?.statusFlag == 0 ||
                                      widget.itemProposal?.statusFlag == 1
                                  ? showCupertinoDialog(
                                      context: context,
                                      builder: (context) {
                                        return CupertinoAlertDialog(
                                          title: Text("Hired offer"),
                                          content: Text(
                                              "Do you really want to send hired offer for student to do this project?"),
                                          actions: <Widget>[
                                            CupertinoDialogAction(
                                              child: Text("Cancel",
                                                  style: TextStyle(
                                                      color: Colors.red)),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            CupertinoDialogAction(
                                              child: Text("Send"),
                                              onPressed: () {
                                                _updateProposalUseCase.call(
                                                    params: UpdateProposalParam(
                                                        widget.itemProposal!.id,
                                                        widget.itemProposal!
                                                            .coverLetter!,
                                                        2));
                                                Navigator.of(context).pop();
                                                //setSelected(3);
                                              },
                                            ),
                                          ],
                                        );
                                      })
                                  : null;
                            },
                            child: widget.itemProposal?.statusFlag == 0 ||
                                    widget.itemProposal?.statusFlag == 1
                                ? const Text(
                                    style: TextStyle(fontSize: 16), "Hire")
                                : widget.itemProposal?.statusFlag == 2
                                    ? const Text(
                                        style: TextStyle(fontSize: 16),
                                        "Send offer")
                                    // : widget.itemProposal?.statusFlag == 1
                                    //     ? const Text(
                                    //         style: TextStyle(fontSize: 16),
                                    //         "Messaged")
                                    : const Text(
                                        style: TextStyle(fontSize: 16),
                                        "Hired"))),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            )));
  }
}
