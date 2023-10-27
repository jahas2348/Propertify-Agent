import 'package:flutter/material.dart';
import 'package:propertify_for_agents/resources/fonts/app_fonts/app_fonts.dart';
import 'package:propertify_for_agents/views/notification_screens/notification_single_screen.dart';
import 'package:propertify_for_agents/resources/constants/spaces%20&%20paddings/paddings.dart';
import 'package:propertify_for_agents/resources/constants/spaces%20&%20paddings/spaces.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customSpaces.verticalspace40,
            Padding(
              padding: customPaddings.horizontalpadding20,
              child: Text(
                "Notifications",
                style: AppFonts.SecondaryColorText28,
              ),
            ),
            customSpaces.verticalspace10,
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => NotificationSingleScreen(),));
              },
              child: Padding(
                padding: customPaddings.horizontalpadding20,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(),
                      Text('You have a new request from a buyer'),
                      Icon(Icons.arrow_forward)
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
