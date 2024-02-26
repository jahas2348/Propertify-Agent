import 'package:propertify_for_agents/views/inbox_screen/chat_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketManager {
  static final SocketManager _instance = SocketManager._internal();
  late IO.Socket socket;
  List<ChatEntry> chatEntries = [];
  factory SocketManager() {
    return _instance;
  }

  SocketManager._internal() {
    socket = IO.io('http://192.168.64.11:4000', <String, dynamic>{
      'transports': ['websocket'],
    });
  }
}