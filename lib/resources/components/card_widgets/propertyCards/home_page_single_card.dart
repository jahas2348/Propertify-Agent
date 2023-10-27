import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertify_for_agents/models/agent_model.dart';
import 'package:propertify_for_agents/models/property_model.dart';
import 'package:propertify_for_agents/resources/colors/app_colors.dart';
import 'package:propertify_for_agents/resources/fonts/app_fonts/app_fonts.dart';
import 'package:propertify_for_agents/services/api_endpoinds.dart';
import 'package:propertify_for_agents/resources/constants/spaces%20&%20paddings/paddings.dart';
import 'package:propertify_for_agents/resources/constants/spaces%20&%20paddings/spaces.dart';
import 'package:propertify_for_agents/views/properties_details_screen/property_details_screen.dart';

// ignore: must_be_immutable
class homePageCardSingle extends StatelessWidget {
  double? cardwidth;
  Rx<PropertyModel> property;
  Rx<AgentModel> agent;
  
   homePageCardSingle({
    super.key,
    this.cardwidth,
    required this.property,
    required this.agent,

  });

  @override
  Widget build(BuildContext context) {
    print(property.value.propertyGalleryPictures);
    return GestureDetector(
      onTap: () {
        Get.to(() => PropertyDetailsScreen(property: property));
        
      },
      child: Container(
        // width: MediaQuery.of(context).size.width * 0.5,
        width:cardwidth,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image(
                    height: 140,
                    width: double.infinity,
                    fit: BoxFit.cover, 
                  //   fit: BoxFit.cover,    
                    image: NetworkImage('${ApiEndPoints.baseurl}${property.value.propertyCoverPicture!.path}'),
                    // image: AssetImage(
                    //   'assets/images/propertify1.jpg',
                    // ),
                  ),
                ),
                Positioned(
                 top: 10,
                  right: 10,
                    child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.yellowColor,
                      borderRadius: BorderRadius.circular(4)),
                  padding: customPaddings.fullpadding4,
                  child: Text('SALE',
                      style: AppFonts.SecondaryColorText10),
                ))
              ],
            ),
            customSpaces.verticalspace10,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Property Category
                Text(
                  property.value.propertyCategory,
                  style: AppFonts.PrimaryColorText14,
                ),
                Icon(
                  Icons.bookmark_border_outlined,
                  size: 24,
                )
              ],
            ),
            //Property Name
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                property.value.propertyName,
                style: AppFonts.SecondaryColorText16,
              ),
            ),
            customSpaces.verticalspace5,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: Colors.grey,
                      size: 14,
                    ),
                    customSpaces.horizontalspace5,
                    Text(
                      property.value.propertyCity,
                      style: AppFonts.greyText14,
                    ),
                  ],
                ),
                Text(
                  '₹${property.value.propertyPrice}',
                  style: AppFonts.SecondaryColorText16,
                ),
              ],
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