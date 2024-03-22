import 'package:flutter/material.dart';

class MessageDetail extends StatefulWidget {
  const MessageDetail({super.key});

  @override
  State<MessageDetail> createState() => _MessageDetailState();
}

class _MessageDetailState extends State<MessageDetail> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Luis Pham'),
        ),
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Container(
            padding: EdgeInsets.fromLTRB(18, 10, 20, 0),
            child: Column(
              children: [
                  SingleChildScrollView(
                  
                  child: Column(
                    children: [
                      Container(
                  margin: EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("6/62024"),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Divider(
                          color: Colors.black,),
                      ),
             
                    ],
                  )
                ),
                SizedBox(height: 10,),
                Container(
                  
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
            
                        children:[
                          Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: AssetImage('assets/images/student.png'),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(child: Text('Luis Pham', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),)),
                                        SizedBox(width: 20,),
                                        Container(child: Text('12:27 AM', style: TextStyle(fontSize: 15),)),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                              
                                  Text('Hello', style: TextStyle(fontSize: 15),),
                                  SizedBox(height: 10,),
                              
                                  
                              
                              
                                ],
                              ),
                            ),
                                  
                          ],
                        )
                                  
                        ]   
                      )
                ),
                
                SizedBox(height: 10,),
                Container(
                  
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
            
                        children:[
                          Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: AssetImage('assets/images/student.png'),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(child: Text('Alex Vu', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),)),
                                        SizedBox(width: 20,),
                                        Container(child: Text('12:27 AM', style: TextStyle(fontSize: 15),)),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                              
                                   Text('Hello', style: TextStyle(fontSize: 15),),
                                  SizedBox(height: 10,),
                              
                                  
                              
                              
                                ],
                              ),
                            ),
                                  
                          ],
                        )
                                  
                        ]   
                      )
                ),
                SizedBox(height: 10,),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("6/62024"),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Divider(
                          color: Colors.black,),
                      ),
             
                    ],
                  )
                ),
                SizedBox(height: 10,),
                Container(
                  
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
            
                        children:[
                          Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: AssetImage('assets/images/student.png'),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Container(child: Text('Luis Pham', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),)),
                                        SizedBox(width: 20,),
                                        Container(child: Text('12:27 AM', style: TextStyle(fontSize: 15),)),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                              
                                   Text('Hello', style: TextStyle(fontSize: 15),),
                                  SizedBox(height: 10,),
                              
                                  
                              
                              
                                ],
                              ),
                            ),
                                  
                          ],
                        )
                                  
                        ]   
                      )
                ),
                    ],
                  ),

                ),

                
                
                Spacer(),
                //chat content
               Container(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.all(10),
                 decoration: BoxDecoration(
                          border: Border(
                              
                              top: BorderSide(width: 1.0),
                              bottom: BorderSide(width: 1.0),
              
                              ),
                        ),
               
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      child: IconButton(
                        padding: EdgeInsets.all(10),
                        constraints: BoxConstraints(),
                        icon:const Icon(Icons.calendar_today),
                         color: Colors.black,
                      iconSize: 30,
                      onPressed: (){})
                      ),
            
                     Expanded(
                  child: TextField(
                    keyboardType: TextInputType.text,
                    maxLines: 3,
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  decoration: const InputDecoration(
                    hintText: 'Chat content',
                    
                    border: OutlineInputBorder(
                     
                      )
                  
                    ,
                    contentPadding: EdgeInsets.all(10),

                    
                    
                  ),
                  onChanged: (value){
                    
                    
                  },
                              
                    ),
                ),
                
                Container(
                  child:IconButton(
                  padding: EdgeInsets.all(10),
                  constraints: BoxConstraints(),
                  icon:const Icon(Icons.send), 
                  color: Colors.black,
                    iconSize: 30,
                    onPressed: (){}
                    )
                    ),
                      
                    
                  ],
            
                ), 
            ),
                      )
                      ),
                      SizedBox(
                  height: MediaQuery.of(context).viewInsets.bottom,
                      ),
            
            
                
               
            
              ],
            ),
          
          ),
        ),

      )
    );
  }
}