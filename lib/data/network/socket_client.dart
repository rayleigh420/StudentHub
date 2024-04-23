import 'dart:developer';

import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/domain/entity/message/message.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

class SocketClient {
  // final SharedPreferenceHelper _sharedPreferenceHelper;
  late Socket _socket;
  // SocketClient(this._sharedPreferenceHelper);
  SocketClient();
  void connect(String url) {
    // final String? token = await _sharedPreferenceHelper.authToken;
    log("Connecting to $url");
    _socket = IO.io(url, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    _socket.connect();
    _socket.onConnect((data) => {
          print('Connected'),
        });

    _socket.onDisconnect((data) => {
          print('Disconnected'),
        });
  }

  void setToken(String token) {
    _socket.io.options?['extraHeaders'] = {
      'Authorization': 'Bearer ${token}',
    };
  }

  void sendMessage(String event, Message message) {
    _socket.emit(event, message.toJson());
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
