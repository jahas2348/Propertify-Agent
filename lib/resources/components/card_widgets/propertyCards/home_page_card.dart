import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:propertify_for_agents/resources/components/card_widgets/propertyCards/home_page_single_card.dart';
import 'package:propertify_for_agents/resources/constants/spaces%20&%20paddings/spaces.dart';
import 'package:propertify_for_agents/view_models/controllers/agent_view_model.dart';

class homePageCard extends StatelessWidget {
  const homePageCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      child: GetBuilder<AgentViewModel>(
        builder: (controller) {
          return controller.agentProperties.isEmpty
              ? Center(child: Text('No Properties Added'))
              : ListView.separated(
                  itemCount: controller.agentProperties.length > 4
                      ? 4
                      : controller.agentProperties.length,
                  // physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return homePageCardSingle(
                      cardwidth: 210,
                      agent: controller.agent,
                      property: controller.agentProperties[index],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return customSpaces.horizontalspace10;
                  },
                );
        },
      ),
    );
  }
}
