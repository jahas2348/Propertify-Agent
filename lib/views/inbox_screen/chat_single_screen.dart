import 'package:flutter/material.dart';
import 'package:propertify_for_agents/views/inbox_screen/chat_message_widget.dart';
import 'package:propertify_for_agents/views/inbox_screen/chat_model.dart';
import 'package:propertify_for_agents/views/inbox_screen/socket_manager.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatScreen extends StatefulWidget {
  final String chatEntryId;

  ChatScreen({required this.chatEntryId});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late IO.Socket socket;
  TextEditingController messageController = TextEditingController();
  List<ChatMessage> messages = [];

  @override
  void initState() {
    super.initState();
    socket = SocketManager().socket;
    socket.emit('joinChatRoom', {'chatEntryId': widget.chatEntryId});
    socket.emit('loadMessages', {'chatEntryId': widget.chatEntryId});
    socket.on('message', handleMessage);
    socket.on('loadMessages', handleLoadMessages);
  }

  void handleMessage(dynamic data) {
    print('Received message: $data');
    if (data is Map<String, dynamic>) {
      if (mounted) {
        final message = ChatMessage.fromJson(data);
        addMessageToList(message);
      }
    }
  }

  void handleLoadMessages(dynamic data) {
    print('Received loadMessages: $data');
    if (data is List) {
      if (mounted) {
        setState(() {
          messages.clear(); // Clear existing messages
          addMessagesToList(
              data.map((item) => ChatMessage.fromJson(item)).toList());
        });
      }
    }
  }

  void addMessageToList(ChatMessage message) {
    setState(() {
      messages.add(message);
    });
  }

  void addMessagesToList(List<ChatMessage> newMessages) {
    setState(() {
      messages.addAll(newMessages);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return CustomChatMessage(message: messages[index]);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                        hintText: 'Enter your message...',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      socket.emit('message', {
                        'message': messageController.text,
                        'sender': 'agent',
                        'time': DateTime.now().toIso8601String(),
                        'chatEntryId': widget.chatEntryId,
                        'isUser':
                            false, // Set isUser to false for user messages
                      });

                      messageController.clear();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // No need to disconnect here
    super.dispose();
  }
}
