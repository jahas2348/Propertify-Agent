import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertify_for_agents/data/shared_preferences/shared_preferences.dart';
import 'package:propertify_for_agents/models/agent_model.dart';
import 'package:propertify_for_agents/resources/colors/app_colors.dart';
import 'package:propertify_for_agents/services/api_services.dart';
import 'package:propertify_for_agents/view_models/controllers/agent_view_model.dart';
import 'package:propertify_for_agents/view_models/controllers/notification_view_model.dart';
import 'package:propertify_for_agents/views/navigation/navigation.dart';
import 'package:propertify_for_agents/views/welcome_screen/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    validateAgent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image(
              image: AssetImage(
                'assets/images/logo/propertify-logo-agents.png',
              ),
              fit: BoxFit.cover,
              height: 140,
            ),
          )
        ],
      ),
    );
  }

  void validateAgent() async {
    final agentPhone = await SharedPref.instance.getAgent();
    if (agentPhone != null) {
      try {
        final agentData = await ApiServices.instance.getAgentData(agentPhone);
        if (!agentData['status']) {
          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => WelcomeScreen(),));
          Get.off(WelcomeScreen());
        } else {
          final agent = AgentModel.fromJson(agentData['agent']);
          print(agent);
          await Get.find<AgentViewModel>().setAgent(agent);
            
          await Get.find<AgentViewModel>().getAgentProperties();
          
          await Get.find<NotificationViewModel>().getAgentRequests();
          print('after request');
          AgentViewModel().update();
          Get.off(NavigationItems());
          //  Navigator.of(context).push(MaterialPageRoute(builder: (context) => NavigationItems(),));
        }
      } catch (e) {
        //  Navigator.of(context).push(MaterialPageRoute(builder: (context) => WelcomeScreen(),));
        Get.off(WelcomeScreen());
      }
    } else {
      //  Navigator.of(context).push(MaterialPageRoute(builder: (context) => WelcomeScreen(),));
      Get.off(WelcomeScreen());
    }
  }
}
