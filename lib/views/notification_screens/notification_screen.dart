import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertify_for_agents/resources/fonts/app_fonts/app_fonts.dart';
import 'package:propertify_for_agents/view_models/controllers/notification_view_model.dart';
import 'package:propertify_for_agents/views/notification_screens/notification_single_screen.dart';
import 'package:propertify_for_agents/resources/constants/spaces%20&%20paddings/paddings.dart';
import 'package:propertify_for_agents/resources/constants/spaces%20&%20paddings/spaces.dart';

import '../../models/request_model.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({Key? key}) : super(key: key);

  Future<void> _refresh() async {
    final controller = Get.find<NotificationViewModel>();
    await controller.getAgentRequests(); // Fetch new data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate([
                  Column(
                    
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      customSpaces.verticalspace20,
                      Padding(
                        padding: customPaddings.horizontalpadding20,
                        child: Text(
                          "Notifications",
                          style: AppFonts.SecondaryColorText28,
                        ),
                      ),
                      customSpaces.verticalspace10,
                      Column(
                        children: [
                          GetX<NotificationViewModel>(
                            initState: (_) {
                              final controller = Get.find<NotificationViewModel>();
                              controller.getAgentRequests().then((_) {
                                controller.isLoading.value = false;
                              });
                            },
                            builder: (controller) {
                              if (controller.isLoading.value) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(child: CircularProgressIndicator()),
                                  ],
                                );
                              } else if (controller.agentRequests.isEmpty) {
                                return Center(
                                  child: Column(
                                    children: [
                                      customSpaces.verticalspace40,
                                      Text('No Requests Received'),
                                    ],
                                  ),
                                );
                              } else {
                                return ListView.separated(
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return NotificationWidget(
                                      request: controller.agentRequests[index],
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return customSpaces.verticalspace10;
                                  },
                                  itemCount: controller.agentRequests.length,
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class NotificationWidget extends StatelessWidget {
  final Rx<RequestModel> request;
  NotificationWidget({Key? key, required this.request});

  @override
  Widget build(BuildContext context) {
    // Extract the first letter of the agent's name
    String firstLetter = request.value.user?.username?[0].toUpperCase() ?? '';

    return InkWell(
      onTap: () {
        Get.to(() => NotificationSingleScreen(request: request));
      },
      child: Padding(
        padding: customPaddings.horizontalpadding20,
        child: Container(

          decoration: BoxDecoration(
            color: Colors.white,
            // border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                child: Text(
                  firstLetter,
                  style: AppFonts.WhiteColorText14Bold,
                ),
              ),
              Text(
                  'You have a new request from ${request.value.user?.username ?? "Unknown agent"}'),
              Icon(Icons.arrow_forward_ios_outlined, size: 16,),
            ],
          ),
        ),
      ),
    );
  }
}
