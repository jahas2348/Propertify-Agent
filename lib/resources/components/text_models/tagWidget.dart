import 'package:flutter/material.dart';
import 'package:propertify_for_agents/resources/constants/spaces%20&%20paddings/spaces.dart';
import 'package:propertify_for_agents/resources/fonts/app_fonts/app_fonts.dart';

class tagWidget extends StatelessWidget {
  final String? tagContent;
  const tagWidget({
    super.key,
    this.tagContent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      alignment: Alignment.center,
      height: 30,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: Colors.black)),
      child: Text(tagContent ?? ''),
    );
  }
}

class IconwithText extends StatelessWidget {
  final String? contentText;
  final IconData? contentIcon;

  const IconwithText({
    super.key,
    this.contentText,
    this.contentIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          contentIcon,
          size: 16,
        ),
        customSpaces.horizontalspace10,
        Text(
          contentText ?? '',
          style: AppFonts.SecondaryColorText14,
        )
      ],
    );
  }
}
