import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertify_for_agents/resources/assets/propertify_icons.dart';
import 'package:propertify_for_agents/resources/colors/app_colors.dart';
import 'package:propertify_for_agents/resources/components/card_widgets/propertyCards/home_page_card.dart';
import 'package:propertify_for_agents/resources/components/iconbox/customIconBox.dart';
import 'package:propertify_for_agents/resources/fonts/app_fonts/app_fonts.dart';
import 'package:propertify_for_agents/view_models/controllers/agent_view_model.dart';
import 'package:propertify_for_agents/views/add_property_screen/add_property_screen.dart';
import 'package:propertify_for_agents/views/notification_screens/notification_screen.dart';
import 'package:propertify_for_agents/resources/constants/spaces%20&%20paddings/paddings.dart';
import 'package:propertify_for_agents/resources/constants/spaces%20&%20paddings/spaces.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final controller = Get.find<AgentViewModel>();
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
                        IconColor: AppColors.whiteColor,
                        boxheight: 40,
                        boxwidth: 40,
                        boxIcon: Icons.add,
                        radius: 8,
                        boxColor: AppColors.secondaryColor,
                        iconSize: 20,
                        iconFunction: () {
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
                    boxheight: 40,
                    boxwidth: 40,
                    boxIcon: Icons.notifications_none_outlined,
                    radius: 8,
                    boxColor: Colors.grey.shade200,
                    iconSize: 24,
                    iconFunction: () {
                      Get.to(() => NotificationScreen());
                      // Navigator.of(context).push(MaterialPageRoute(
                      //   builder: (context) => NotificationScreen(),
                      // ));
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: dashboardBox(
                          dashboardIcon: PropertifyIcons.home,
                          dashboardTitle: 'Properties',
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
                          dashboardIcon: Icons.currency_rupee_outlined,
                          dashboardTitle: 'Revenue',
                          dashboardValue: '₹ 20,000'),
                    ),
                    customSpaces.horizontalspace10,
                    Expanded(
                      child: dashboardBox(
                          dashboardIcon: PropertifyIcons.user,
                          dashboardTitle: 'Clients',
                          dashboardValue: '1'),
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
          Padding(
            padding: customPaddings.horizontalpadding20,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4)),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4),
                      bottomLeft: Radius.circular(4),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: Image(
                        height: 80,
                        width: 110,
                        image: NetworkImage(
                            'https://images.unsplash.com/photo-1678575326996-a1bf09b86158?auto=format&fit=crop&q=80&w=1000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxjb2xsZWN0aW9uLXBhZ2V8NHxhUk9zQ3pQM1F0b3x8ZW58MHx8fHx8'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: customPaddings.horizontalpadding20,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                  color: AppColors.secondaryColor,
                                  borderRadius: BorderRadius.circular(50)),
                              child: Text(
                                "Category",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            customSpaces.horizontalspace10,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  PropertifyIcons.location,
                                  color: Colors.grey,
                                  size: 12,
                                ),
                                customSpaces.horizontalspace5,
                                Text(
                                  "City",
                                  style: AppFonts.greyText12,
                                ),
                              ],
                            ),
                          ],
                        ),
                        customSpaces.verticalspace5,
                        Text(
                          "Luxury House in Mukkam",
                          style: AppFonts.SecondaryColorText14,
                        ),
                        customSpaces.verticalspace5,
                        Text(
                          '₹ 20,000',
                          style: AppFonts.SecondaryColorText16,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          customSpaces.verticalspace20,
          Padding(
            padding: customPaddings.horizontalpadding20,
            child: homePageCard(properties: controller.soldagentProperties),
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
