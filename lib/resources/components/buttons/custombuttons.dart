import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:propertify_for_agents/resources/colors/app_colors.dart';
import 'package:propertify_for_agents/resources/constants/spaces%20&%20paddings/spaces.dart';

// ignore: must_be_immutable
class PrimaryButton extends StatelessWidget {
  String buttonText;
  VoidCallback? buttonFunction;
  PrimaryButton({
    super.key,
    required this.buttonText,
    this.buttonFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(20)),
      width: double.maxFinite,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        child: ElevatedButton(
          onPressed: buttonFunction,
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          style: ButtonStyle(
            elevation: MaterialStatePropertyAll(0),
            backgroundColor: MaterialStatePropertyAll(AppColors.primaryColor)
          ),
        ),
      ),
    );
  }
}
// ignore: must_be_immutable
class CustomColorButton extends StatelessWidget {
  String buttonText;
  VoidCallback? buttonFunction;
  Color? buttonColor;
  CustomColorButton({
    super.key,
    required this.buttonText,
    this.buttonFunction,
    this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      width: double.maxFinite,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        child: ElevatedButton(
          onPressed: buttonFunction,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                buttonText,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          style: ButtonStyle(
            elevation: MaterialStatePropertyAll(0),
             backgroundColor: MaterialStatePropertyAll(buttonColor)
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class PrimaryButtonwithIcon extends StatelessWidget {
  IconData? buttonIcon;
  String buttonText;
  VoidCallback? buttonFunction;
  PrimaryButtonwithIcon({
    super.key,
    this.buttonIcon,
    required this.buttonText,
    this.buttonFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      width: double.maxFinite,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        child: ElevatedButton(
          onPressed: buttonFunction,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                buttonIcon,
                size: 18,
              ),
              customSpaces.horizontalspace20,
              Text(
                buttonText,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          style: ButtonStyle(
            elevation: MaterialStatePropertyAll(0),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class SocialButton extends StatelessWidget {
  Color? borderColor;
  String? buttonIcon;
  String? buttonText;
  SocialButton({
    Key? key,
    this.borderColor,
    this.buttonIcon,
    this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey),
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          elevation: MaterialStateProperty.all(0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              buttonIcon!,
              height: 20,
            ),
            customSpaces.horizontalspace10,
            Text(
              buttonText!,
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: AppColors.secondaryColor),
            ),
          ],
        ),
      ),
    );
  }
}