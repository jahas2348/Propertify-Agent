import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertify_for_agents/resources/components/card_widgets/propertyCards/home_page_card.dart';
import 'package:propertify_for_agents/resources/constants/spaces%20&%20paddings/paddings.dart';
import 'package:propertify_for_agents/resources/constants/spaces%20&%20paddings/spaces.dart';
import 'package:propertify_for_agents/resources/fonts/app_fonts/app_fonts.dart';
import 'package:propertify_for_agents/view_models/controllers/agent_view_model.dart';

class SoldPropertiesScreen extends StatelessWidget {
  SoldPropertiesScreen({super.key});
  final controller = Get.find<AgentViewModel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
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
                  Text(
                    "Sold Properties",
                    style: AppFonts.SecondaryColorText28,
                  ),
                  CircleAvatar(
                    radius: 16,
                    child: Text(
                      controller.soldagentProperties.length.toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
                    ),
                  )
                ],
              ),
            ),
            customSpaces.verticalspace10,
            Divider(),
            customSpaces.verticalspace10,
            HomePageSoldProperties(
              properties: controller.soldagentProperties,
            ),
            customSpaces.verticalspace20,
          ],
        ),
      ),
    );
  }
}
