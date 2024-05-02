import 'dart:developer';

import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/domain/entity/notification/notification.dart';
import 'package:boilerplate/presentation/browse_project/store/project_company_store.dart';
import 'package:boilerplate/presentation/chat/message_project_item.dart';
import 'package:boilerplate/presentation/chat/store/message_store.dart';

import 'package:boilerplate/presentation/profile/store/profile_store.dart';
import 'package:boilerplate/utils/device/device_utils.dart';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:socket_io_client/socket_io_client.dart';

class MessageList extends StatefulWidget {
  const MessageList({super.key});

  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  // final SocketStore _socketStore = getIt<SocketStore>();

  final _messageStore = getIt<MessageStore>();
  final ProjectCompanyStore _projectCompanyStore = getIt<ProjectCompanyStore>();
  final ProfileStore _profileStore = getIt<ProfileStore>();
  late List<Socket> _socketClientList = [];
  // late int myId = -1;+

  @override
  void initState() {
    super.initState();
    // _connectSockets();
    // _loadId();
    this._initSocket();
  }

  @override
  void dispose() {
    _socketClientList.forEach((element) {
      element.dispose();
      element.disconnect();
    });
    super.dispose();
  }

  void _initSocket() {
    final userRole = _profileStore.profile!.roles[0];
    if (userRole == 0) {
      _initSocketClient();
    } else if (userRole == 1) {
      _initSocketCompany();
    }
  }

  void _initSocketCompany() {
    final token = _profileStore.token;
    if (_projectCompanyStore.companyProjects != null) {
      if (_projectCompanyStore.companyProjects!.projects != null) {
        _projectCompanyStore.companyProjects!.projects!.forEach((element) {
          final socket = io(
              Endpoints.baseUrl,
              OptionBuilder()
                  .setTransports(['websocket'])
                  .enableForceNewConnection()
                  .disableAutoConnect()
                  .build());
          socket.io.options?['extraHeaders'] = {
            'Authorization': 'Bearer ${token}',
          };
          socket.io.options?['query'] = {'project_id': element.id};
          socket.connect();
          socket.onConnect((data) {
            log("Connected to project id ${element.id}");
          });

          socket.onDisconnect((data) => {
                print('Disconnected'),
              });
          socket.onConnectError((data) => print('$data'));
          socket.onError((data) => print(data));

          socket.on("RECEIVE_MESSAGE", (data) {
            log("NOTI FOR RECEIVE_MESSAGE");
            dynamic msg = data;
            Noti notification = Noti(
                id: msg['notification']['id'],
                title: msg['notification']['title'],
                content: msg['notification']['content'],
                createdAt: DateTime.parse(msg['notification']['createdAt']),
                notifyFlag: msg['notification']['notifyFlag'],
                typeNotifyFlag: msg['notification']['typeNotifyFlag']);
            log(notification.toJson().toString());
            // _messageStore.receiveMessage(msg);
          });
          socket.on(
              "NOTI_${_profileStore.profile!.id}",
              (data) => {
                    log("NOTI_${_profileStore.profile!.id}"),
                    log(data.toString())
                  });
          socket.on('RECEIVE_INTERVIEW', (data) {
            log("NOTI FOR RECEIVE_INTERVIEW");
            dynamic msg = data;
            Noti notification = Noti(
                id: msg['notification']['id'],
                title: msg['notification']['title'],
                content: msg['notification']['content'],
                createdAt: DateTime.parse(msg['notification']['createdAt']),
                notifyFlag: msg['notification']['notifyFlag'],
                typeNotifyFlag: msg['notification']['typeNotifyFlag']);
            log(notification.toJson().toString());
          });
          socket.on("ERROR", (data) => print(data));

          _socketClientList.add(socket);
        });
      }
    }
  }

  void handleReceiveMessageCompany(dynamic msg) {
    log("RECEIVE_MESSAGE");
    log(msg.toString());
  }

  void _initSocketClient() {
    final token = _profileStore.token;
    if (_messageStore.messageList != null) {
      final uniqueProjects = _messageStore.messageList!
          .map((message) => message.project)
          .toSet()
          .toList();
      uniqueProjects.forEach((element) {
        Socket socket = io(
            Endpoints.baseUrl,
            OptionBuilder()
                .setTransports(['websocket'])
                .enableForceNewConnection()
                .disableAutoConnect()
                .build());
        socket.io.options?['extraHeaders'] = {
          'Authorization': 'Bearer ${token}',
        };
        socket.io.options?['query'] = {'project_id': element.id};
        socket.connect();
        socket.onConnect((data) {
          print('Connected');
          log("Connected to project id ${element.id}");
        });

        socket.onDisconnect((data) => {
              print('Disconnected'),
            });
        socket.onConnectError((data) => print('$data'));
        socket.onError((data) => print(data));

        socket.on("RECEIVE_MESSAGE", (data) {
          log("RECEIVE_MESSAGE");
          dynamic msg = data['notification']['message'];
          msg['projectId'] = element.id;
          log(msg.toString());
        });

        socket.on("ERROR", (data) => print(data));

        _socketClientList.add(socket);
      });
    }
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
                          onTapOutside: (event) =>
                              FocusScope.of(context).unfocus(),
                          decoration: const InputDecoration(
                            hintText: 'Search ',
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
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
