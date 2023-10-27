import 'package:flutter/material.dart';
import 'package:propertify_for_agents/models/property_model.dart';
import 'package:propertify_for_agents/resources/constants/spaces%20&%20paddings/spaces.dart';
import 'package:propertify_for_agents/resources/fonts/app_fonts/app_fonts.dart';

class AmenitiesList extends StatelessWidget {
  final List<Amenity>? amenities;

  AmenitiesList({this.amenities});

  @override
  Widget build(BuildContext context) {
    if (amenities == null || amenities!.isEmpty) {
      return Container(); // Return an empty container if no amenities are available.
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Features & Amenities',
          style: AppFonts.SecondaryColorText20,
        ),
        customSpaces.verticalspace20,
        Column(
          children: amenities!.map((amenity) {
            return Container(
              padding: EdgeInsets.only(bottom: 10), // Add bottom padding for space
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    amenity.amenityname?.toUpperCase() ?? '',
                    style: AppFonts.greyText14withLetterSpace,
                  ),
                  Text(
                    amenity.amenityValue ?? '',
                    style: AppFonts.SecondaryColorText14,
                  ),
                ],
              ),
            );
          }).toList(),
        ),
        customSpaces.verticalspace20,
      ],
    );
  }
}
