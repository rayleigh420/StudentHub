// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:boilerplate/core/widgets/proposal/proposalItem.dart';
import 'package:boilerplate/core/widgets/toggle_button.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/domain/entity/proposal/itemProposal.dart';
import 'package:boilerplate/domain/entity/proposal/proposal.dart';
import 'package:boilerplate/domain/usecase/proposal/get_proposal_usecase.dart';

class HireOffer extends StatefulWidget {
  @override
  _HireOfferState createState() => _HireOfferState();
}

class _HireOfferState extends State<HireOffer> {
  final GetProposalsByProjectIdUseCase _getProposalsByProjectIdUseCase =
      getIt<GetProposalsByProjectIdUseCase>();
  List<ItemProposal> listItemProposal = [];
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    getItem();
  }

  void getItem() async {
    print("Hello");
    final res = await _getProposalsByProjectIdUseCase.call(params: 53);
    setState(() {
      listItemProposal = res.items!;
      log(listItemProposal.toString());
    });
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
                    selectedIndex == 0
                        ? Proposal1(
                            listItem: listItemProposal,
                          )
                        : ProjectDetail_2(
                            selected: selectedIndex,
                            setSelected: (p0) {
                              print(p0);
                              setState(() {
                                selectedIndex = p0;
                              });
                            },
                          )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}

class Proposal1 extends StatelessWidget {
  final List<ItemProposal> listItem;
  Proposal1({
    super.key,
    required this.listItem,
  });

  @override
  Widget build(BuildContext context) {
    //final String res123 =listItem[0].student!.userId.toString();
    return Column(
      children: [
        ...listItem.map((e) => ProposalItems(itemProposal: e)).toList(),
        SizedBox(
          height: 50,
        ),
      ],
    );
  }
   Widget buildProposalItemContent(){
    return Observer(builder: (context) {
      return listItemProposal.isEmpty
          ? Center(child: CircularProgressIndicator())
          : buildProposalItem();
    });
  }
  Widget buildProposalItem(){
    return ListView.builder(
      shrinkWrap: true,
      itemCount: listItemProposal.length,
      itemBuilder: (context,index){
        return ProposalItems(itemProposal: listItemProposal[index]);
      },
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
