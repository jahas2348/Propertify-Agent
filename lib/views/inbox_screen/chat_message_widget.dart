import 'package:flutter/material.dart';
import 'package:propertify_for_agents/views/inbox_screen/chat_model.dart';

class CustomChatMessage extends StatelessWidget {
  final ChatMessage message;

  CustomChatMessage({required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: message.isUser
            ? MainAxisAlignment.start
            : MainAxisAlignment.end, // Adjusted for both true and false cases
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: message.isUser ? Colors.blue[100] : Colors.green[100],
            ),
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message.message,
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: 4),
                Text(
                  '${message.sender} - ${message.time.toLocal()}',
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}