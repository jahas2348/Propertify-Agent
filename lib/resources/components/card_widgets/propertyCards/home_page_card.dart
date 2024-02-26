import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertify_for_agents/models/agent_model.dart';
import 'package:propertify_for_agents/models/property_model.dart';
import 'package:propertify_for_agents/resources/assets/propertify_icons.dart';
import 'package:propertify_for_agents/resources/colors/app_colors.dart';
import 'package:propertify_for_agents/resources/components/card_widgets/propertyCards/home_page_single_card.dart';
import 'package:propertify_for_agents/resources/constants/spaces%20&%20paddings/paddings.dart';
import 'package:propertify_for_agents/resources/constants/spaces%20&%20paddings/spaces.dart';
import 'package:propertify_for_agents/resources/fonts/app_fonts/app_fonts.dart';
import 'package:propertify_for_agents/view_models/controllers/agent_view_model.dart';

class homePageCard extends StatelessWidget {
  List<Rx<PropertyModel>> properties;
  homePageCard({super.key, required this.properties});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetBuilder<AgentViewModel>(
        builder: (controller) {
          print("Agent Properties: ${properties}");
          return properties.isEmpty
              ? Center(
                  child: Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text('No Properties')))
              : Container(
                  child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 1 / 1,
                  ),
                  itemBuilder: (context, index) {
                    return homePageCardSingle(
                      cardwidth: 210,
                      agent: controller.agent,
                      property: properties[index],
                    );
                  },
                  itemCount: properties.length,
                ));
        },
      ),
    );
  }
}

class HomePageSoldProperties extends StatelessWidget {
  List<Rx<PropertyModel>> properties;
  HomePageSoldProperties({super.key, required this.properties});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetBuilder<AgentViewModel>(
        builder: (controller) {
          print("Agent Properties: ${properties}");
          return properties.isEmpty
              ? Center(
                  child: Container(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text('No Properties')))
              : Container(
                  child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return SoldPropertyCard(
                      agent: controller.agent,
                      property: properties[index],
                    );
                  },
                  itemCount: properties.length,
                ));
        },
      ),
    );
  }
}

class SoldPropertyCard extends StatelessWidget {
  final Rx<PropertyModel> property;
  Rx<AgentModel>? agent;

  SoldPropertyCard({super.key, required this.property, this.agent});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: customPaddings.horizontalpadding20,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(4)),
        child: Row(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4),
                    bottomLeft: Radius.circular(4),
                  ),
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: Image(
                      width: 110,
                      height: 90,
                      image: NetworkImage(
                          property.value.propertyCoverPicture!.path),
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
                              property.value.propertyCategory,
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
                                property.value.propertyCity,
                                style: AppFonts.greyText12,
                              ),
                            ],
                          ),
                        ],
                      ),
                      customSpaces.verticalspace5,
                      Text(
                        property.value.propertyName,
                        style: AppFonts.SecondaryColorText14,
                      ),
                      customSpaces.verticalspace5,
                      Text(
                        '₹ ${property.value.propertyPrice}',
                        style: AppFonts.SecondaryColorText16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
