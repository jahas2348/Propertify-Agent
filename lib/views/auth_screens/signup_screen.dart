import 'package:flutter/material.dart';
import 'package:propertify_for_agents/resources/colors/app_colors.dart';
import 'package:propertify_for_agents/resources/components/buttons/custombuttons.dart';
import 'package:propertify_for_agents/resources/components/input_fileds/custom_Input_Fields.dart';
import 'package:propertify_for_agents/resources/components/text_models/customSpanTextModels.dart';
import 'package:propertify_for_agents/resources/constants/spaces%20&%20paddings/paddings.dart';
import 'package:propertify_for_agents/resources/constants/spaces%20&%20paddings/spaces.dart';
import 'package:propertify_for_agents/views/auth_screens/login_screen.dart';


class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: customPaddings.horizontalpadding20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customSpaces.verticalspace20,
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 50,
                width: 50,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.arrow_back,
                    size: 24,
                  ),
                ),
              ),
              customSpaces.verticalspace20,
              Text(
                'Get Started!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: AppColors.secondaryColor,
                ),
              ),
              Text(
                'Create an account to continue.',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade400,
                ),
              ),
              customSpaces.verticalspace20,
              MobileInputField(),
              customSpaces.verticalspace20,
              CustomInputField(
                fieldIcon: Icons.person_outline,
                hintText: 'Enter your username',
              ),
              customSpaces.verticalspace20,
              CustomInputField(
                fieldIcon: Icons.lock_outline,
                hintText: 'Enter your password',
              ),
              customSpaces.verticalspace20,
              CustomInputField(
                fieldIcon: Icons.lock_outline,
                hintText: 'Confirm password',
              ),
              customSpaces.verticalspace20,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check_box,
                    size: 20,
                    color: AppColors.primaryColor,
                  ),
                  customSpaces.horizontalspace20,
                  CustomSpanTextVertical(
                    firstText: 'By creating an account, you agree to our',
                    spanText: 'Terms and Conditions',
                  )
                ],
              ),
              customSpaces.verticalspace20,
              PrimaryButton(
                buttonText: 'Sign Up',
                buttonFunction: () {},
              ),
              customSpaces.verticalspace20,
              Container(
                child: Row(
                  children: [
                    customSpaces.horizontalspace10,
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.grey.shade300,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'OR',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade500),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 1,
                        color: Colors.grey.shade300,
                      ),
                    ),
                    customSpaces.horizontalspace10,
                  ],
                ),
              ),
              customSpaces.verticalspace20,
              Row(
                children: [
                  Expanded(
                    child: SocialButton(
                        buttonText: 'Sign Up with Google',
                        buttonIcon: 'assets/icons/google-icon.svg'),
                  ),
                  customSpaces.horizontalspace10,
                  Expanded(
                    child: SocialButton(
                        buttonText: 'Sign Up with Facebook',
                        buttonIcon: 'assets/icons/facebook-icon.svg'),
                  ),
                ],
              ),
              customSpaces.verticalspace20,
              CustomSpanText(
                firstText: 'Already have an account ?',
                spanText: 'Login',
                spanFunction: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ));
                },
              ),
              customSpaces.verticalspace40,
            ],
          ),
        ),
      ),
    );
  }
}
