import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertify_for_agents/models/agent_model.dart';
import 'package:propertify_for_agents/models/property_model.dart';
import 'package:propertify_for_agents/resources/assets/propertify_icons.dart';
import 'package:propertify_for_agents/resources/colors/app_colors.dart';
import 'package:propertify_for_agents/resources/fonts/app_fonts/app_fonts.dart';
import 'package:propertify_for_agents/resources/constants/spaces%20&%20paddings/paddings.dart';
import 'package:propertify_for_agents/resources/constants/spaces%20&%20paddings/spaces.dart';
import 'package:propertify_for_agents/views/properties_details_screen/property_details_screen.dart';

// ignore: must_be_immutable
class homePageCardSingle extends StatelessWidget {
  double? cardwidth;
  double? cardHeight;
  final Rx<PropertyModel> property;
  Rx<AgentModel>? agent;
  
   homePageCardSingle({
    super.key,
    this.cardwidth,
    this.cardHeight,
    required this.property,
    this.agent,

  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => PropertyDetailsScreen(property: property));
        
      },
      child: Container(
        // width: MediaQuery.of(context).size.width * 0.5,
        width:cardwidth,
        

        padding: EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: Colors.white,
          // border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image(
                    height: cardHeight ?? 110,
                    width: double.infinity,
                    fit: BoxFit.cover, 
                  //   fit: BoxFit.cover,    
                    image: NetworkImage('${property.value.propertyCoverPicture!.path}'),
                    // image: AssetImage(
                    //   'assets/images/propertify1.jpg',
                    // ),
                  ),
                ),
               Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    padding: customPaddings.fullpadding6,
                    child: Text(
                      '₹ ${property.value.propertyPrice}',
                      style: AppFonts.WhiteColorText14,
                    ),
                  ),
                ),
              ],
            ),
            customSpaces.verticalspace10,



              Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      customSpaces.horizontalspace20,
                      Text(
                        property.value.propertyName,
                        style: AppFonts.SecondaryColorText14,
                      ),
                    ],
                  ),
                  customSpaces.verticalspace5,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      customSpaces.horizontalspace20,
                      Text(
                        property.value.propertyCategory,
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w600),
                      ),
                      customSpaces.horizontalspace5,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            PropertifyIcons.location,
                            color: Colors.grey,
                            size: 12,
                          ),
                          customSpaces.horizontalspace5,
                          Text(
                            property.value.propertyCity,
                            style: AppFonts.greyText12,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class borderBoxIconandText extends StatelessWidget {
  IconData? boxIcon;
  String? boxText;
  borderBoxIconandText({
    super.key,
    this.boxIcon,
    this.boxText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Icon(
              boxIcon,
              size: 25,
            ),
            customSpaces.verticalspace10,
            Text(
              boxText!,
              style: AppFonts.SecondaryColorText16,
            ),
          ],
        ),
      ),
    );
  }
}



