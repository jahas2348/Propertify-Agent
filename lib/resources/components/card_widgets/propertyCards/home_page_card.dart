import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:propertify_for_agents/models/property_model.dart';
import 'package:propertify_for_agents/resources/components/card_widgets/propertyCards/home_page_single_card.dart';
import 'package:propertify_for_agents/resources/constants/spaces%20&%20paddings/spaces.dart';
import 'package:propertify_for_agents/view_models/controllers/agent_view_model.dart';

class homePageCard extends StatelessWidget {
  List<Rx<PropertyModel>> properties;
   homePageCard({
    super.key,
    required this.properties
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetBuilder<AgentViewModel>(
        builder: (controller) {
          print("Agent Properties: ${properties}");
          return properties.isEmpty
              ? Center(child: Text('No Properties Added'))
              // : Container(
              //   height: 200,
              //   color: Colors.amber,
              // );
              :
              // ListView.separated(
              //     itemCount: controller.agentProperties.length,
              //     // physics: NeverScrollableScrollPhysics(),
              //     scrollDirection: Axis.horizontal,
              //     shrinkWrap: true,
              //     itemBuilder: (context, index) {
              //       return homePageCardSingle(
              //         cardwidth: 210,
              //         agent: controller.agent,
              //         property: controller.agentProperties[index],
              //       );
              //     },
              //     separatorBuilder: (context, index) {
              //       return customSpaces.horizontalspace10;
              //     },
              //   );
              Container(
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
        // Use the length of the properties list
      ),
    );
  }
}
