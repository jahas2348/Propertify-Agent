import 'package:flutter/material.dart';
import 'package:propertify_for_agents/resources/constants/spaces%20&%20paddings/spaces.dart';
import 'package:propertify_for_agents/resources/fonts/app_fonts/app_fonts.dart';

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
