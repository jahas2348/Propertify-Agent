import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:propertify_for_agents/resources/assets/image_assets.dart';
import 'package:propertify_for_agents/resources/colors/app_colors.dart';
import 'package:propertify_for_agents/resources/components/buttons/custombuttons.dart';
import 'package:propertify_for_agents/resources/components/input_fileds/custom_Input_Fields.dart';
import 'package:propertify_for_agents/resources/components/text_models/customSpanTextModels.dart';
import 'package:propertify_for_agents/view_models/controllers/login_view_model.dart';
import 'package:propertify_for_agents/resources/constants/spaces%20&%20paddings/paddings.dart';
import 'package:propertify_for_agents/resources/constants/spaces%20&%20paddings/spaces.dart';
import 'package:propertify_for_agents/views/auth_screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginController = Get.put(LoginViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: customPaddings.horizontalpadding20,
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customSpaces.verticalspace40,
                customSpaces.verticalspace40,
                Center(
                  child: Image(
                    image: AssetImage(ImageAssets.welcomeImage),
                    fit: BoxFit.cover,
                    height: 300,
                  ),
                ),
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
                  "Let's sign you in",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: AppColors.secondaryColor,
                  ),
                ),
                Text(
                  "Welcome Back, You've been missed!",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade400,
                  ),
                ),
                customSpaces.verticalspace20,
                MobileInputField(
                  controller: loginController.phoneNumberController.value,
                ),
                customSpaces.verticalspace20,
                Row(
                  children: [
                    Expanded(
                      child: PrimaryButton(
                        buttonText: 'Send OTP',
                        buttonFunction: () {
                          loginController.verifyPhoneNumber();
                        },
                      ),
                    ),
                  ],
                ),
                customSpaces.verticalspace20,
                CustomSpanText(
                  firstText: 'Trouble Logging In ?',
                  spanText: 'Contact us',
                  spanFunction: () {
                    Get.off(() => SignUpScreen());
                  },
                ),
                customSpaces.verticalspace40,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
