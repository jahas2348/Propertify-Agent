// socket_manager.dart
import 'package:propertify_for_agents/resources/constants/spaces%20&%20paddings/paddings.dart';
import 'package:propertify_for_agents/resources/constants/spaces%20&%20paddings/spaces.dart';
import 'package:propertify_for_agents/resources/fonts/app_fonts/app_fonts.dart';
import 'package:propertify_for_agents/views/inbox_screen/chat_model.dart';
import 'package:propertify_for_agents/views/inbox_screen/chat_single_screen.dart';
import 'package:propertify_for_agents/views/inbox_screen/socket_manager.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
// main.dart
import 'package:flutter/material.dart';

class InboxScreen extends StatefulWidget {
  @override
  _InboxScreenState createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  late IO.Socket socket;
  late List<ChatEntry> chatEntries;

  @override
  void initState() {
    super.initState();
    socket = SocketManager().socket;
    chatEntries = SocketManager().chatEntries;
    socket.emit('loadChatEntries');
    socket.on('chatEntries', handleLoadChatEntries);
    socket.on('newChatEntry', handleNewChatEntry);
  }

  void handleLoadChatEntries(dynamic data) {
    print('Received chatEntries: $data');
    if (data is List) {
      setState(() {
        chatEntries = data.map((item) => ChatEntry.fromJson(item)).toList();
      });
    }
  }

  void handleNewChatEntry(dynamic data) {
    print('Received new chat entry: $data');
    if (data is List) {
      setState(() {
        chatEntries.addAll(data.map((item) => ChatEntry.fromJson(item)));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: customPaddings.horizontalpadding20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customSpaces.verticalspace20,
                  Text(
                    "Inbox",
                    style: AppFonts.SecondaryColorText28,
                  ),
                ],
              ),
            ),
            customSpaces.verticalspace10,
            Divider(),
            customSpaces.verticalspace10,
            Expanded(
              child: ListView.builder(
                itemCount: chatEntries.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(chatEntries[index].id),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ChatScreen(chatEntryId: chatEntries[index].id),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          socket.emit('createChatEntry');
          
        },
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    socket.off('chatEntries', handleLoadChatEntries);
    socket.off('newChatEntry', handleNewChatEntry);
    super.dispose();
  }
}
