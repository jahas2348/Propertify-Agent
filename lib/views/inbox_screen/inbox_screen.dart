import 'package:flutter/material.dart';
import 'package:propertify_for_agents/resources/constants/spaces%20&%20paddings/paddings.dart';
import 'package:propertify_for_agents/resources/constants/spaces%20&%20paddings/spaces.dart';
import 'package:propertify_for_agents/resources/fonts/app_fonts/app_fonts.dart';
import 'package:propertify_for_agents/views/chat_screen/chat_single_screen.dart';



class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
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
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChatSingleScreen(),));
                  },
                  contentPadding: EdgeInsets.all(0),
                  leading: CircleAvatar(),
                  title: Text('David James', style: AppFonts.SecondaryColorText18,),
                  subtitle: Text('This property is mostly wooded...',style: AppFonts.SecondaryColorText12,),
                  trailing: Text('12:15 PM', style: AppFonts.PrimaryColorText12,),
                ),
                
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
