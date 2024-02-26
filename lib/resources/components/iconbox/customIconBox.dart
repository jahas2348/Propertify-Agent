import 'package:flutter/material.dart';
import 'package:propertify_for_agents/resources/colors/app_colors.dart';

class CustomIconBox extends StatelessWidget {
  final double? boxheight;
  final double? boxwidth;
  final double? iconSize;
  final IconData? boxIcon;
  final double? radius;
  final Color? boxColor;
  final Color? iconColor;
  final VoidCallback? iconFunction;
  final int? count;

  const CustomIconBox({
    Key? key,
    this.boxheight,
    this.boxwidth,
    this.boxIcon,
    this.radius,
    this.boxColor,
    this.iconSize,
    this.iconColor,
    this.iconFunction,
    this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: iconFunction,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: boxColor,
              borderRadius: BorderRadius.circular(radius!),
            ),
            height: boxheight,
            width: boxwidth,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                boxIcon,
                size: iconSize,
                color: iconColor,
              ),
            ),
          ),
          if (count != null && count! > 0)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                margin: EdgeInsets.only(top: 2, right: 4),
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor, // Change color as needed
                  shape: BoxShape.circle,
                ),
                child: Text(
                  count.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
