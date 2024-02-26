import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertify_for_agents/models/property_model.dart';
import 'package:propertify_for_agents/resources/assets/propertify_icons.dart';
import 'package:propertify_for_agents/resources/colors/app_colors.dart';
import 'package:propertify_for_agents/resources/components/card_widgets/propertyCards/home_page_card.dart';
import 'package:propertify_for_agents/resources/components/iconbox/customIconBox.dart';
import 'package:propertify_for_agents/resources/fonts/app_fonts/app_fonts.dart';
import 'package:propertify_for_agents/view_models/controllers/agent_view_model.dart';
import 'package:propertify_for_agents/view_models/controllers/notification_view_model.dart';
import 'package:propertify_for_agents/view_models/controllers/property_view_model.dart';
import 'package:propertify_for_agents/views/add_property_screen/add_property_screen.dart';
import 'package:propertify_for_agents/views/notification_screens/notification_screen.dart';
import 'package:propertify_for_agents/resources/constants/spaces%20&%20paddings/paddings.dart';
import 'package:propertify_for_agents/resources/constants/spaces%20&%20paddings/spaces.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final controller = Get.find<AgentViewModel>();
  final ProperyController = Get.find<PropertyViewModel>();
  final NotificationController = Get.find<NotificationViewModel>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
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
                        iconColor: AppColors.whiteColor,
                        boxheight: 40,
                        boxwidth: 40,
                        boxIcon: Icons.add,
                        radius: 8,
                        boxColor: AppColors.secondaryColor,
                        iconSize: 20,
                        iconFunction: () {
                          ProperyController.propertyLatitude.clear();
                          ProperyController.propertyLongitude.clear();
                          Get.to(() => AddPropertyScreen());
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
                    count: NotificationController.agentRequests.length,
                    boxheight: 40,
                    boxwidth: 40,
                    boxIcon: Icons.notifications_none_outlined,
                    radius: 8,
                    boxColor: Colors.grey.shade200,
                    iconSize: 24,
                    iconFunction: () {
                      Get.to(() => NotificationScreen());
                    },
                  ),
                ],
              ),
            ),
          ),
          customSpaces.verticalspace20,

          Padding(
            padding: customPaddings.horizontalpadding20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dashboard',
                  style: AppFonts.SecondaryColorText20,
                ),
                customSpaces.verticalspace20,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: dashboardBox(
                          dashboardIcon: PropertifyIcons.home,
                          dashboardTitle: 'Approved',
                          dashboardValue: '2'),
                    ),
                    customSpaces.horizontalspace10,
                    Expanded(
                      child: dashboardBox(
                          dashboardIcon: Icons.check_outlined,
                          dashboardTitle: 'Sold',
                          dashboardValue: '2'),
                    ),
                  ],
                ),
                customSpaces.verticalspace10,
                Row(
                  children: [
                    Expanded(
                      child: dashboardBox(
                          dashboardIcon: PropertifyIcons.recent,
                          dashboardTitle: 'Pending',
                          dashboardValue: '1'),
                    ),
                    customSpaces.horizontalspace10,
                    Expanded(
                      child: dashboardBox(
                          dashboardIcon: Icons.currency_rupee_outlined,
                          dashboardTitle: 'Revenue',
                          dashboardValue: '₹ 20,000'),
                    ),
                  ],
                ),
              ],
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
            padding: customPaddings.horizontalpadding20,
            child: homePageCard(properties: controller.unsoldagentProperties),
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
          HomePageSoldProperties(
            properties: controller.soldagentProperties,
          ),
          customSpaces.verticalspace20,
        ]),
      ),
    );
  }
}

class dashboardBox extends StatelessWidget {
  IconData? dashboardIcon;
  String? dashboardTitle;
  String? dashboardValue;
  dashboardBox({
    super.key,
    this.dashboardIcon,
    this.dashboardTitle,
    this.dashboardValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //  ...List.generate(3, (index) => null),
            CircleAvatar(
              backgroundColor: Colors.grey.shade100,
              child: Icon(
                dashboardIcon,
                size: 20,
                color: AppColors.secondaryColor,
              ),
            ),
            customSpaces.horizontalspace10,
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dashboardTitle ?? 'Title',
                  style: AppFonts.greyText12,
                ),
                Text(
                  this.dashboardValue ?? 'Value',
                  style: AppFonts.SecondaryColorText20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
