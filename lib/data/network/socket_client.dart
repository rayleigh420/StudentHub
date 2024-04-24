import 'dart:developer';

import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/domain/entity/message/message.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

class SocketClient {
  // final SharedPreferenceHelper _sharedPreferenceHelper;
  int projectId;
  late final IO.Socket _socket;
  // SocketClient(this._sharedPreferenceHelper);
  SocketClient(this.projectId);
  void connect(String url, String token) {
    // final String? token = await _sharedPreferenceHelper.authToken;
    final finalurl = url + '?projectId=$projectId';
    log("Connecting to $finalurl");
    try {
      _socket = IO.io(finalurl, OptionBuilder().disableAutoConnect().build());
      _socket.io.options?['extraHeaders'] = {
        'Authorization': 'Bearer ${token}',
      };
      // _socket.io.options?['query'] = {'project_id': 471};
      _socket.connect();
      _socket.onConnect((data) {
        print('Connected');
        log("Connected to $finalurl");
      });

      _socket.onDisconnect((data) => {
            print('Disconnected'),
          });
      _socket.onConnectError((data) => print('$data'));
      _socket.onError((data) => print(data));
      _socket.on("ERROR", (data) => print(data));
    } catch (e) {
      print("Error connecting to $url");
      print(e);
    }
  }

  void sendMessage(Message message) {
    dynamic ctn = {
      "content": message.content,
      "sender_id": message.sender.id,
      "receiver_id": message.receiver.id,
      "project_id": projectId,
      "messageFlag": 0
    };
    log(ctn.toString());
    log(_socket.connected.toString());
    _socket.emit("SEND_MESSAGE", ctn);
  }

  void listen(String event, Function(dynamic) callback) {
    _socket.on(event, callback);
  }

  void emit(String event, dynamic data) {
    _socket.emit(event, data);
  }

  void disconnect() {
    _socket.disconnect();
  }
}
