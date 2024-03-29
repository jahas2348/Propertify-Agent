import 'package:flutter/material.dart';
import 'package:propertify_for_agents/repositories/agent_repository/agent_repository.dart';
import 'package:propertify_for_agents/resources/assets/image_assets.dart';
import 'package:propertify_for_agents/resources/colors/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    AgentRepository.validateAgent();
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
                ImageAssets.propertifylogoSplash,
              ),
              fit: BoxFit.cover,
              height: 140,
            ),
          )
        ],
      ),
    );
  }
}
