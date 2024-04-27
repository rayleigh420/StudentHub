import 'dart:developer';
import 'package:boilerplate/domain/entity/message/message.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

class SocketClient {
  int projectId;
  late IO.Socket socket;
  SocketClient(this.projectId);
  void connect(String url, String token) {
    // final String? token = await _sharedPreferenceHelper.authToken;
    final finalurl = url + '?project_id=$projectId';
    log("Connecting to $finalurl");
    socket = IO.io(
        url,
        OptionBuilder()
            // .setExtraHeaders({'Authorization': 'Bearer $token'})
            .disableAutoConnect()
            .build());

    // socket.io.options?['extraHeaders'] = {
    //   'Authorization': 'Bearer ${token}',
    // };
    socket.io.options?['extraHeaders'] = {
      'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MzEsImZ1bGxuYW1lIjoiTG9uZyIsImVtYWlsIjoia2xvbmcxMDAwMDBAZ21haWwuY29tIiwicm9sZXMiOlsxXSwiaWF0IjoxNzE0MDI2OTY4LCJleHAiOjE3MTUyMzY1Njh9.H_1SMIBOKOUQLXEgJKmjwenFEzrdpueGAxR3os09SU0',
    };
    socket.io.options?['query'] = {'project_id': projectId};
    // socket.connect();
    // socket.connect();
    // socket.io
    //   ..disconnect()
    //   ..connect();
    // ;

    socket.onConnect((data) {
      print('Connected');
      log("Connected to $finalurl");
    });

    socket.onDisconnect((data) => {
          print('Disconnected'),
        });
    // socket.on("RECEIVE_MESSAGE", callback);
    socket.onConnectError((data) => print('$data'));
    socket.onError((data) => print(data));
    socket.on("ERROR", (data) => print(data));
  }

  void sendMessage(Message message) {
    dynamic ctn = {
      "content": message.content,
      "senderId": message.sender.id,
      "receiverId": message.receiver.id,
      "projectId": projectId,
      "messageFlag": 0
    };
    log(ctn.toString());
    log(socket.connected.toString());
    socket.emit("SEND_MESSAGE", ctn);
  }

  void listen(String event, Function(dynamic) callback) {
    log("nghe nè ");
    socket.on(event, callback);
  }

  void emit(String event, dynamic data) {
    socket.emit(event, data);
  }

  void disconnect() {
    socket.disconnect();
    socket.close();
    socket.dispose();
    log("disposed socket");
  }
}
