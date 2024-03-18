import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart';
import '../../models/request_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../resources/app_urls/app_urls.dart';
class ChatSingleScreen extends StatefulWidget {
  final Rx<RequestModel> request;
  
  ChatSingleScreen({Key? key, required this.request, })
      : super(key: key);

  @override
  _ChatSingleScreenState createState() => _ChatSingleScreenState();
}

class _ChatSingleScreenState extends State<ChatSingleScreen> {
  TextEditingController messageController = TextEditingController();
  final RxList<String> messages = <String>[].obs;

  // Create a chat room and inform the server
  final roomName = 'unique_room_name'; // Generate a unique room name

  // Use the same room name as in NotificationSingleScreen
  late  IO.Socket socket;
  @override
  void initState() {
    super.initState();

   socket = IO.io(AppUrl.baseUrl,OptionBuilder()
      .setTransports(['websocket']) // for Flutter or Dart VM
      .disableAutoConnect()  // disable auto-connection
      .setExtraHeaders({'foo': 'bar'}) // optional
      .build()
  );
socket.connect(); // Replace with your server URL
    
    print('Connection Established');
    
    // Identify the user or agent role
    final role = 'agent'; // Replace with 'user' for user app
    socket.emit('identify', role);
   
    // Create a chat room and inform the server
    final roomName = 'unique_room_name'; // Generate a unique room name
    socket.emit('createRoom', roomName);


    socket.on('message', (data) {
      // Add the new message to the list
      messages.add(data['message']);
    });
  }

  sendMessage(String message) async {
    // Send the message to the server
    socket.emit('message', {
      'roomName': roomName,
      'message': message,
    });
    socket.on('message', (data) {
      // Add the new message to the list
      messages.add(data['message']);
      print(messages);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ${widget.request.value.user!.username}'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return Container(
                color: Colors.grey.shade200,
                height: 500,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return Text(messages[index], style: TextStyle(
                      color: Colors.black,
                    ),);
                    
                  },
                ),
              );
            }),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: messageController,
                  decoration: InputDecoration(labelText: 'Type a message'),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () async {
                  final message = messageController.text;
                  if (message.isNotEmpty) {
                    print(message);
                   
                    await sendMessage(message,);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}