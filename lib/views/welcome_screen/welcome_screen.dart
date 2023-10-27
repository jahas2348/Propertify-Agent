import 'package:flutter/material.dart';
import 'package:propertify_for_agents/resources/colors/app_colors.dart';
import 'package:propertify_for_agents/resources/components/buttons/custombuttons.dart';
import 'package:propertify_for_agents/views/auth_screens/login_screen.dart';
import 'package:propertify_for_agents/resources/constants/spaces%20&%20paddings/paddings.dart';
import 'package:propertify_for_agents/resources/constants/spaces%20&%20paddings/spaces.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: customPaddings.horizontalpadding20,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            customSpaces.verticalspace40,
            customSpaces.verticalspace40,
            Center(
              child: Image(
                image: AssetImage('assets/images/welcome-image2.png'),
                fit: BoxFit.cover,
                height: 300,
              ),
            ),
            customSpaces.verticalspace20,
            Center(
              child: Image(
                image: AssetImage('assets/images/logo/propertify-logo-agents-dark.png'),
                fit: BoxFit.cover,
                height: 200,
              ),
            ),
            customSpaces.verticalspace20,
            Text(
              'Agent Login ',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: AppColors.secondaryColor,
              ),
            ),
            customSpaces.verticalspace20,
            PrimaryButtonwithIcon(buttonText: 'Login with Phone Number',buttonIcon: Icons.phone,buttonFunction: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen(),));
            },),
            customSpaces.verticalspace40,
            
           
          ],
        ),
      ),
    );
  }
}




