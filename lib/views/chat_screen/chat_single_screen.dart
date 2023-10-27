import 'package:flutter/material.dart';
import 'package:propertify_for_agents/resources/components/iconbox/customIconBox.dart';
import 'package:propertify_for_agents/resources/constants/spaces%20&%20paddings/paddings.dart';
import 'package:propertify_for_agents/resources/constants/spaces%20&%20paddings/spaces.dart';
import 'package:propertify_for_agents/resources/fonts/app_fonts/app_fonts.dart';

class ChatSingleScreen extends StatelessWidget {
  ChatSingleScreen({super.key});

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
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
                  CustomIconBox(
                    iconFunction: () {
                      
                    },
                          boxheight: 40,
                          boxwidth: 40,
                          boxIcon: Icons.more_vert_outlined,
                          radius: 8,
                          boxColor: Colors.transparent,
                          iconSize: 20),

                      
                ],
              ),
            ),
            customSpaces.verticalspace20,
            Padding(
              padding: customPaddings.horizontalpadding20,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(),
                  customSpaces.horizontalspace20,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'This property is mostly wooded',
                            style: AppFonts.SecondaryColorText14,
                          ),
                        ),
                      ),
                      customSpaces.verticalspace10,
                      Text(
                        '12:15 PM',
                        style: AppFonts.greyText14,
                      )
                    ],
                  ),
                ],
              ),
            ),
            customSpaces.verticalspace20,
            Padding(
              padding: customPaddings.horizontalpadding20,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            'Located right in the heart of Upstate',
                            style: AppFonts.SecondaryColorText14,
                          ),
                        ),
                      ),
                      customSpaces.verticalspace10,
                      Text(
                        '12:18 PM',
                        style: AppFonts.greyText14,
                      )
                    ],
                  ),
                  customSpaces.horizontalspace20,
                  CircleAvatar(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
