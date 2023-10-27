import 'package:flutter/material.dart';
import 'package:propertify_for_agents/resources/components/buttons/custombuttons.dart';
import 'package:propertify_for_agents/resources/components/iconbox/customIconBox.dart';
import 'package:propertify_for_agents/resources/constants/spaces%20&%20paddings/paddings.dart';
import 'package:propertify_for_agents/resources/constants/spaces%20&%20paddings/spaces.dart';
import 'package:propertify_for_agents/resources/fonts/app_fonts/app_fonts.dart';

class NotificationSingleScreen extends StatelessWidget {
  NotificationSingleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customSpaces.verticalspace20,
            Padding(
              padding: customPaddings.horizontalpadding20,
              child: Row(
                children: [
                  CustomIconBox(
                      boxheight: 40,
                      boxwidth: 40,
                      boxIcon: Icons.arrow_back,
                      radius: 8,
                      boxColor: Colors.grey.shade300,
                      iconSize: 20),
                  customSpaces.horizontalspace20,
                  Text(
                    "David James",
                    style: AppFonts.SecondaryColorText20,
                  ),
                ],
              ),
            ),
            customSpaces.verticalspace20,
            Padding(
              padding: customPaddings.horizontalpadding20,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(),
                        customSpaces.horizontalspace10,
                        Text(
                          'David James',
                          style: AppFonts.SecondaryColorText14,
                        ),
                        customSpaces.verticalspace20,
                      ],
                    ),
                    customSpaces.verticalspace10,
                    // homePageCardSingle(),
                    customSpaces.verticalspace10,
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: CustomColorButton(
                              buttonText: 'Decline',
                              buttonFunction: () {},
                              buttonColor: Colors.green,
                            ),
                          ),
                        ),
                        customSpaces.horizontalspace10,
                        Expanded(
                          child: Container(
                            child: CustomColorButton(
                              buttonText: 'Accept',
                              buttonFunction: () {},
                              buttonColor: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
