import 'dart:developer';

import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/domain/entity/message/message.dart';
import 'package:boilerplate/domain/entity/message/message_project.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

class SocketProject {
  IO.Socket socket;
  MessageProject messageProject;

  SocketProject(this.socket, this.messageProject);
}

class SocketClientList {
  List<MessageProject> messages;
  late List<SocketProject> socketList = [];
  SocketClientList({required this.messages});
  void connect(String token) {
    log("okeok");
    messages.forEach((element) {
      final finalurl = Endpoints.baseUrl + '?project_id=${element.project.id}';
      log("Connecting to $finalurl");
      try {
        final _socket =
            IO.io(finalurl, OptionBuilder().disableAutoConnect().build());
        _socket.io.options?['extraHeaders'] = {
          'Authorization': 'Bearer ${token}',
        };
        socketList.add(SocketProject(_socket, element));
        _socket.connect();
        _socket.onConnect((data) {
          // print('Connected');
          log("Connected to $finalurl");
        });

        _socket.onDisconnect((data) => {
              print('Disconnected'),
            });
        
        _socket.onConnectError((data) => print('$data'));
        _socket.onError((data) => print(data));
        _socket.on("ERROR", (data) => print(data));
      } catch (e) {
        // print("Error connecting to $url");
        print(e);
      }
    });
  }

  int findSocket(int senderId, int receiverId, int projectId) {
    return socketList.indexWhere((element) =>
        element.messageProject.project.id == projectId &&
            element.messageProject.messages.first.sender.id == senderId &&
            element.messageProject.messages.first.receiver.id == receiverId ||
        element.messageProject.messages.first.sender.id == receiverId &&
            element.messageProject.messages.first.receiver.id == senderId);
  }

  void sendMessage(Message message, int projectId) {
    dynamic ctn = {
      "content": message.content,
      "senderId": message.sender.id,
      "receiverId": message.receiver.id,
      "projectId": message.interview.id,
      "messageFlag": 0
    };
    log(ctn.toString());
    final index = findSocket(
        message.sender.id, message.receiver.id, message.interview.id);
    socketList[index].socket.emit("SEND_MESSAGE", ctn);
  }

  void disconnect() {
    socketList.forEach((element) {
      element.socket.disconnect();
      element.socket.close();
      element.socket.dispose();
    });
    log("disposed sockets");
  }

  void listen(String event, Function(dynamic) callback) {
    log("mày nghe cho tao");
    log(socketList.length.toString());
    socketList.forEach((element) {
      element.socket.on(event, callback);
    });
  }
}
