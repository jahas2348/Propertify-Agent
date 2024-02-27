import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:propertify_for_agents/resources/colors/app_colors.dart';
import 'package:propertify_for_agents/resources/fonts/app_fonts/app_fonts.dart';
import 'package:propertify_for_agents/views/inbox_screen/chat_model.dart';

class CustomChatMessage extends StatelessWidget {
  final ChatMessage message;

  CustomChatMessage({required this.message});

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('dd-MM-yyyy').format(message.time.toLocal());
    String formattedTime = DateFormat.jm().format(message.time.toLocal());

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16),
      child: Row(
        mainAxisAlignment: message.isUser
            ? MainAxisAlignment.start
            : MainAxisAlignment.end, // Adjusted for both true and false cases
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: message.isUser
                  ? BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )
                  : BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
              color: message.isUser
                  ? AppColors.primaryColor
                  : AppColors.secondaryColor,
            ),
            padding: EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${message.sender}",
                  style: AppFonts.WhiteColorText12Bold,
                ),
                SizedBox(height: 4),
                Container(
                  width: 200,
                  child: Text(
                    message.message,
                    textAlign: TextAlign.left,

                    maxLines: 10, // Set maximum lines to 2
                    // Handle overflow with ellipsis
                    style: AppFonts.WhiteColorText16,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '$formattedDate $formattedTime',
                  style: AppFonts.WhiteColorText12Bold,
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
