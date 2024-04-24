import 'dart:io';
import 'dart:developer';

class SocketClient2 {
  int projectId;
  late Socket socket;
  SocketClient2({required this.projectId});

  void connect(String url, String token) async {
    log("Connecting to $url");
    try {
      socket = await Socket.connect(url, 80);
    } catch (e) {
      print("Error connecting to $url");
      print(e);
    }
  }

  void sendMessage(String message) {
    socket.write(message);
  }

  void listen(Function(dynamic) callback) {
    socket.listen((event) {
      callback(event);
    });
  }

  void disconnect() {
    socket.destroy();
  }
}
