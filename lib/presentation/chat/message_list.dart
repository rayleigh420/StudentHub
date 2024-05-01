import 'dart:developer';
import 'dart:io';

import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/network/socket_client.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/domain/entity/message/message.dart';
import 'package:boilerplate/domain/entity/message/message_list.dart';
import 'package:boilerplate/domain/entity/message/message_project.dart';
import 'package:boilerplate/domain/usecase/message/get_all_message_usecase.dart';
import 'package:boilerplate/presentation/chat/message_detail.dart';
import 'package:boilerplate/presentation/chat/message_project_item.dart';
import 'package:boilerplate/presentation/chat/store/message_store.dart';


import 'package:boilerplate/presentation/input_login/input_login.dart';
import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

class MessageList extends StatefulWidget {
  const MessageList({super.key});

  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  final GetAllMessageUseCase _getAllMessageUseCase =
      getIt<GetAllMessageUseCase>();
  final SharedPreferenceHelper _sharedPreferenceHelper =
      getIt<SharedPreferenceHelper>();
  // final SocketStore _socketStore = getIt<SocketStore>();
  late String token = '';
  final _messageStore = getIt<MessageStore>();
  late List<Socket> _socketClientList = [];
  // late int myId = -1;+

  @override
  void initState() {
    super.initState();
    // _connectSockets();
    _loadId();
  }

  @override
  void dispose() {
    // _socketClientList.forEach((element) {
    //   element.dispose();
    //   element.disconnect();
    // });
    super.dispose();
  }

  _loadId() async {
    final userToken = await _sharedPreferenceHelper.authToken;
    log(token.toString());
    setState(
      () {
        token = userToken!;
      },
    );
    // _initSocket();
  }

  _initSocket() {
    // _socketStore.init(_messageStore.messageList!);
    _messageStore.messageList!.forEach((element) {
      final finalurl = Endpoints.baseUrl + '?project_id=${element.project.id}';

      log("Connecting to $finalurl");
      IO.Socket socket = IO.io(
          Endpoints.baseUrl, // Server url
          OptionBuilder()
              .setTransports(['websocket'])
              .disableAutoConnect()
              .build());
      log("token kết nối " + token);
      socket.io.options?['extraHeaders'] = {
        'Authorization': 'Bearer $token',
      };
      socket.io.options?['query'] = {'project_id': element.project.id};

      socket.onConnect((data) {
        print('Connected');
        log("Connected to $finalurl");
      });

      socket.onDisconnect((data) => {
            print('Disconnected'),
          });
      socket.onConnectError((data) => print('$data'));
      socket.onError((data) => print(data));
      socket.on("ERROR", (data) => print(data));
      socket.on("RECEIVE_MESSAGE", (data) {
        log("RECEIVE_MESSAGE");
        print(data);
        dynamic msg = data;
        msg['projectId'] = element.project.id;
        _messageStore.receiveMessage(data);
      });
      // socket.connect();
      _socketClientList.add(socket);
      // socket.io
      //   ..disconnect()
      //   ..connect();
    });
    _connectSocket();
  }

  _connectSocket() {
    _socketClientList.forEach((element) {
      element.connect();
    });
  }

  Future<void> _pullRefresh() async {
    _messageStore.refreshMessage();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('StudentHub'),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(18, 10, 20, 0),
        child: buildMainContent(),
      ),
    ));
  }

  Widget buildMainContent() {
    return Observer(
      builder: (context) {
        if (_messageStore.loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return RefreshIndicator(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: DeviceUtils.getScaledHeight(context, 1),
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
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      contentPadding: EdgeInsets.all(10),
                    ),
                    onChanged: (value) {},
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: _messageStore.messageList!.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return MessageProjectItem(
                      messageListItem: _messageStore.messageList![index],
                      index: index,
                    );
                  },
                )

                // MessageProjectItem(),
              ],
            ),
          ),
        ),
        onRefresh: _pullRefresh);
        }
      },
    );
  }
}
