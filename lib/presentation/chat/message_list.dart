import 'package:flutter/material.dart';

class MessageList extends StatefulWidget {
  const MessageList({super.key});

  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.fromLTRB(18, 10, 20, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    maxLines: 1,
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  decoration: const InputDecoration(
                    hintText: 'Search ',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))
                      )
                  
                    ,
                    contentPadding: EdgeInsets.all(10),
                    
                    
                  ),
                  onChanged: (value){
                    
                    
                  },
                              
                    ),
                ),
                SizedBox(height: 20,),
                Container(
                    decoration: BoxDecoration(
                        border: Border(
                            
                            top: BorderSide(width: 1.0),
                            bottom: BorderSide(width: 1.0),
            
                            ),
                      ),
                      child: InkWell(
                        onTap:(){},
                      
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: AssetImage('assets/images/student.png'),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(child: Text('Luis Pham', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),)),
                                     
                                        Container(child: Text('6/6/2024', style: TextStyle(fontSize: 15),)),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                              
                                   Text('Senior frontend developer (Fintech)', style: TextStyle(fontSize: 15),),
                                  SizedBox(height: 10,),
                              
                                    
                                    Text('Clear expectation about your project or deliverable', style: TextStyle(fontSize: 15),),
                              
                              
                                ],
                              ),
                            ),
            
                          ],
                        )
            
            
                      ),
            
                )
                ),
                Container(
                    decoration: BoxDecoration(
                        border: Border(
                            
                            top: BorderSide(width: 1.0),
                            bottom: BorderSide(width: 1.0),
            
                            ),
                      ),
                      child: InkWell(
                        onTap:(){},
                      
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: AssetImage('assets/images/student.png'),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(child: Text('Luis Pham', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),)),
                                     
                                        Container(child: Text('6/6/2024', style: TextStyle(fontSize: 15),)),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                              
                                   Text('Senior frontend developer (Fintech)', style: TextStyle(fontSize: 15),),
                                  SizedBox(height: 10,),
                              
                                    
                                    Text('Clear expectation about your project or deliverable', style: TextStyle(fontSize: 15),),
                              
                              
                                ],
                              ),
                            ),
            
                          ],
                        )
            
            
                      ),
            
                )
                )
            
              ],
            ),
          ),

        ),

      )
    );
  }
}