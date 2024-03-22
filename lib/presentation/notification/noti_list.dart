import 'package:flutter/material.dart';

class NotiList extends StatefulWidget {
  const NotiList({super.key});

  @override
  State<NotiList> createState() => _NotiListState();
}

class _NotiListState extends State<NotiList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(18, 10, 20, 0),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.circle_notifications_outlined,
                          size: 30,
                          color: Colors.black,
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            child:Text('You have submitted to join project "Javis - AI Copilot "',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                            ),
                            )
                            ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Container(
                        margin: EdgeInsets.only(left: 40),
                        child: Text("6/6/2024")),
                      SizedBox(height: 10,),
                      Divider(
                        color: Colors.black,
                        thickness: 1,

                      ),
                    ],
                  )
                ),
                SizedBox(height: 20,),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.circle_notifications_outlined,
                          size: 30,
                          color: Colors.black,
                          ),
                          SizedBox(width: 10,),
                          Expanded(
                            child:Text('You have submitted to join project "Javis - AI Copilot "',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                            ),
                            )
                            ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Container(
                        margin: EdgeInsets.only(left: 40),
                        child: Text("6/6/2024")),
                        Container(
                          margin: EdgeInsets.only(left: 40),
                          child: SizedBox(
                            width: 150,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                               
                                shape: RoundedRectangleBorder(
                                 
                                ),
                                side: BorderSide(color: Colors.black, width: 1),
                              ),
                              onPressed: (){},
                              child: Text('Join',style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              
                              ),
                            )),
                          )
                        ),
                      SizedBox(height: 10,),
                      Divider(
                        color: Colors.black,
                        thickness: 1,

                      ),
                    ],
                  )
                ),


              ],
            ),
          ),
        ),
      ));
  }
}