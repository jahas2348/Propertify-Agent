import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertify_for_agents/resources/colors/app_colors.dart';
import 'package:propertify_for_agents/resources/components/buttons/custombuttons.dart';
import 'package:propertify_for_agents/resources/components/iconbox/customIconBox.dart';
import 'package:propertify_for_agents/resources/components/input_fileds/custom_Input_Fields.dart';
import 'package:propertify_for_agents/resources/components/text_models/customSpanTextModels.dart';
import 'package:propertify_for_agents/view_models/controllers/login_view_model.dart';
import 'package:propertify_for_agents/resources/constants/spaces%20&%20paddings/paddings.dart';
import 'package:propertify_for_agents/resources/constants/spaces%20&%20paddings/spaces.dart';
import 'package:propertify_for_agents/views/auth_screens/signup_screen.dart';


class OtpVerification extends StatefulWidget {
  OtpVerification({super.key});
  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  final loginController = Get.put(LoginViewModel());
  final verificationId = Get.arguments;
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
                CustomIconBox(
                    boxheight: 50,
                    boxwidth: 50,
                    boxIcon: Icons.arrow_back,
                    radius: 8,
                    boxColor: Colors.grey.shade300,
                    iconSize: 24),
                customSpaces.verticalspace20,
                Text(
                  "Verification Code",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: AppColors.secondaryColor,
                  ),
                ),
                Text(
                  "We have sent the verification code to\n+91 9656462348",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade400,
                    height: 1.5,
                  ),
                ),
                customSpaces.verticalspace20,
                CustomInputFieldOtp(
                  controller: loginController.smsCodeController.value,
                ),
                customSpaces.verticalspace20,
                PrimaryButton(
                  buttonText: 'Verify',
                  buttonFunction: () {
                    loginController.signInWithOTP(verificationId);
                  },
                ),
                customSpaces.verticalspace20,
                CustomSpanText(
                  firstText: "Didn’t receive any code ?",
                  spanText: 'Resend Code',
                  spanFunction: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => SignUpScreen(),
                      ),
                    );
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
