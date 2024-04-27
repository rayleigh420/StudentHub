import 'dart:developer';
import 'dart:io';

import 'package:boilerplate/core/stores/error/error_store.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/network/socket_client.dart';
import 'package:boilerplate/data/network/socket_client_list.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/domain/entity/message/message.dart';
import 'package:boilerplate/domain/entity/message/message_list.dart';
import 'package:boilerplate/domain/entity/message/message_project.dart';
import 'package:boilerplate/domain/entity/message/message_user.dart';
import 'package:boilerplate/domain/usecase/message/get_all_message_usecase.dart';
import 'package:boilerplate/domain/usecase/message/get_project_message.dart';
import 'package:boilerplate/presentation/chat/store/message_store.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';
import 'package:mobx/mobx.dart';

part 'socket_store.g.dart';

class SocketIndex {
  int index;
  Socket socketClient;

  SocketIndex(this.index, this.socketClient);

  factory SocketIndex.fromJson(Map<String, dynamic> json) {
    return SocketIndex(json['index'], json['socketClient']);
  }

  Map<String, dynamic> toJson() => {
        'index': index,
        'socketClient': socketClient,
      };
}

class SocketStore = _SocketStore with _$SocketStore;

abstract class _SocketStore with Store {
  _SocketStore();

  final MessageStore _messageStore = getIt<MessageStore>();
  List<SocketIndex> socketLists = [];

  void init(List<MessageListItem> item) {
    item.forEach((element) {
      final finalurl = Endpoints.baseUrl + '?project_id=${element.project.id}';
      log("Connecting to $finalurl");
      Socket socket = IO.io(
          finalurl,
          OptionBuilder()
              // .setExtraHeaders({'Authorization': 'Bearer $token'})
              .disableAutoConnect()
              .build());
      // socket.io.options?['extraHeaders'] = {
      //   'Authorization': 'Bearer ${token}',
      // };
      socket.io.options?['extraHeaders'] = {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MzEsImZ1bGxuYW1lIjoiTG9uZyIsImVtYWlsIjoia2xvbmcxMDAwMDBAZ21haWwuY29tIiwicm9sZXMiOlsxXSwiaWF0IjoxNzE0MDI2OTY4LCJleHAiOjE3MTUyMzY1Njh9.H_1SMIBOKOUQLXEgJKmjwenFEzrdpueGAxR3os09SU0',
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
      socket.connect();
    });
  }
}
