import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertify_for_agents/resources/components/card_widgets/propertyCards/home_page_card.dart';
import 'package:propertify_for_agents/resources/components/iconbox/customIconBox.dart';
import 'package:propertify_for_agents/resources/fonts/app_fonts/app_fonts.dart';
import 'package:propertify_for_agents/views/add_property_screen/add_property_screen.dart';
import 'package:propertify_for_agents/views/notification_screens/notification_screen.dart';
import 'package:propertify_for_agents/resources/constants/spaces%20&%20paddings/paddings.dart';
import 'package:propertify_for_agents/resources/constants/spaces%20&%20paddings/spaces.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(shrinkWrap: true, children: [
          //AppBar
          customSpaces.verticalspace20,
          Padding(
            padding: customPaddings.horizontalpadding20,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CustomIconBox(
                        boxheight: 50,
                        boxwidth: 50,
                        boxIcon: Icons.add_box_outlined,
                        radius: 8,
                        boxColor: Colors.grey.shade300,
                        iconSize: 24,
                        iconFunction: () {
                          Get.to(()=>AddPropertyScreen());
                        },
                      ),
                      customSpaces.horizontalspace20,
                      Text(
                        'Add New Property',
                        style: AppFonts.SecondaryColorText18,
                      ),
                    ],
                  ),
                  CustomIconBox(
                    boxheight: 50,
                    boxwidth: 50,
                    boxIcon: Icons.notifications_none_outlined,
                    radius: 8,
                    boxColor: Colors.grey.shade300,
                    iconSize: 24,
                    iconFunction: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => NotificationScreen(),
                      ));
                    },
                  ),
                ],
              ),
            ),
          ),
          customSpaces.verticalspace20,
          //Recently Added Properties
          Padding(
            padding: customPaddings.horizontalpadding20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Recently Added',
                  style: AppFonts.SecondaryColorText20,
                ),
                Text(
                  'See All',
                  style: AppFonts.PrimaryColorText14,
                ),
              ],
            ),
          ),
          customSpaces.verticalspace20,
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: homePageCard(),
          ),
          customSpaces.verticalspace20,
          //Sold Properties
          Padding(
            padding: customPaddings.horizontalpadding20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Sold',
                  style: AppFonts.SecondaryColorText20,
                ),
                Text(
                  'See All',
                  style: AppFonts.PrimaryColorText14,
                ),
              ],
            ),
          ),
          customSpaces.verticalspace20,
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: homePageCard(),
          ),
          customSpaces.verticalspace20,
        ]),
      ),
    );
  }
}
