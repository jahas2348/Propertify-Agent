import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:propertify_for_agents/data/shared_preferences/shared_preferences.dart';
import 'package:propertify_for_agents/models/request_model.dart';
import 'package:propertify_for_agents/resources/colors/app_colors.dart';
import 'package:propertify_for_agents/resources/constants/spaces%20&%20paddings/paddings.dart';
import 'package:propertify_for_agents/resources/constants/spaces%20&%20paddings/spaces.dart';
import 'package:propertify_for_agents/views/inbox_screen/chat_message_widget.dart';
import 'package:propertify_for_agents/views/inbox_screen/chat_model.dart';
import 'package:propertify_for_agents/views/inbox_screen/socket_manager.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatScreen extends StatefulWidget {
  final String chatEntryId;
  Rx<RequestModel>? request;
  ChatScreen({required this.chatEntryId, this.request});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late IO.Socket socket;
  TextEditingController messageController = TextEditingController();
  List<ChatMessage> messages = [];
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    socket = SocketManager().socket;
    socket.emit('joinChatRoom', {'chatEntryId': widget.chatEntryId});
    socket.emit('loadMessages', {'chatEntryId': widget.chatEntryId});
    socket.on('message', handleMessage);
    socket.on('loadMessages', handleLoadMessages);
    Future.delayed(Duration(milliseconds: 300), () {
      scrollToBottom();
    });
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
          messages.clear();
          addMessagesToList(
              data.map((item) => ChatMessage.fromJson(item)).toList());
        });
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          scrollToBottom();
        });
      }
    }
  }

  void addMessageToList(ChatMessage message) {
    setState(() {
      messages.add(message);
    });
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      scrollToBottom();
    });
  }

  void addMessagesToList(List<ChatMessage> newMessages) {
    setState(() {
      messages.addAll(newMessages);
    });
  }

  void scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    String senderName =
        messages.isNotEmpty ? messages.first.sender.toString() : "";
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        title: Text('${senderName}'),
      ),
      body: Column(
        children: [
          customSpaces.verticalspace10,
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return CustomChatMessage(message: messages[index]);
              },
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: Colors.grey.shade300))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter your message...',
                          hintStyle: TextStyle(
                              color: Colors.grey.shade400,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send_outlined),
                    onPressed: () {
                      if (messageController.text.trim().isNotEmpty) {
                        socket.emit('message', {
                          'message': messageController.text,
                          'sender': SharedPref.instance.sharedPref
                              .getString('agentName'),
                          'time': DateTime.now().toIso8601String(),
                          'chatEntryId': widget.chatEntryId,
                          'isUser':
                              false, // Set isUser to false for user messages
                        });

                        messageController.clear();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
