import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:propertify_for_agents/models/property_model.dart';
import 'package:propertify_for_agents/resources/components/iconbox/customIconBox.dart';
import 'package:propertify_for_agents/resources/fonts/app_fonts/app_fonts.dart';
import 'package:propertify_for_agents/services/api_endpoinds.dart';
import 'package:propertify_for_agents/resources/constants/spaces%20&%20paddings/paddings.dart';
import 'package:propertify_for_agents/resources/constants/spaces%20&%20paddings/spaces.dart';
import 'package:propertify_for_agents/view_models/controllers/agent_view_model.dart';
import 'package:propertify_for_agents/view_models/controllers/property_view_model.dart';
import 'package:propertify_for_agents/views/add_property_screen/add_property_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class PropertyDetailsScreen extends StatelessWidget {
  final Rx<PropertyModel> property;
  final agent = Get.find<AgentViewModel>().agent;
 
  PropertyDetailsScreen({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    print(property.toJson());
    print(property.value.propertyGalleryPictures);
    print(property.value.propertyCoverPicture);
    print(property.value.latitude);
    print(property.value.longitude);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: double.maxFinite,
                          height: MediaQuery.of(context).size.height * .4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(40),
                              bottomRight: Radius.circular(40),
                            ),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                '${ApiEndPoints.baseurl}${property.value.propertyCoverPicture!.path}',
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: double.maxFinite,
                          height: MediaQuery.of(context).size.height * .4,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.black.withOpacity(0.6),
                                Colors.transparent,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.center,
                              stops: [0.0, 0.9],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 20,
                          top: 40,
                          child: CustomIconBox(
                            boxheight: 40,
                            boxwidth: 40,
                            boxIcon: Icons.arrow_back,
                            radius: 8,
                            boxColor: Colors.transparent,
                            iconSize: 24,
                            IconColor: Colors.white,
                          ),
                        ),
                        Positioned(
                          right: 20,
                          top: 40,
                          child: Row(
                            children: [
                              CustomIconBox(
                                boxheight: 40,
                                boxwidth: 40,
                                boxIcon: Icons.delete_outline,
                                radius: 8,
                                boxColor: Colors.transparent,
                                iconSize: 24,
                                IconColor: Colors.white,
                                iconFunction: () async {
                                  await PropertyViewModel().deleteProperty(property.value.id!);
                                },
                              ),
                              CustomIconBox(
                                boxheight: 40,
                                boxwidth: 40,
                                boxIcon: Icons.edit_outlined,
                                radius: 8,
                                boxColor: Colors.transparent,
                                iconSize: 24,
                                IconColor: Colors.white,
                                iconFunction: () {
                                  Get.to(AddPropertyScreen(property:property));
                                },
                              ),
                               CustomIconBox(
                                boxheight: 40,
                                boxwidth: 40,
                                boxIcon: Icons.bookmark_border,
                                radius: 8,
                                boxColor: Colors.transparent,
                                iconSize: 24,
                                IconColor: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    customSpaces.verticalspace40,
                    Padding(
                      padding: customPaddings.horizontalpadding20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                property.value.propertyCategory,
                                style: AppFonts.PrimaryColorText16,
                              ),
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
                            ],
                          ),
                          customSpaces.verticalspace10,
                          Text(
                            property.value.propertyName,
                            style: AppFonts.SecondaryColorText20,
                          ),
                        ],
                      ),
                    ),
                    customSpaces.verticalspace10,
                    Divider(),
                    customSpaces.verticalspace10,
                    Padding(
                      padding: customPaddings.horizontalpadding20,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Row(
                          //   children: [
                          //     CircleAvatar(),
                          //     customSpaces.horizontalspace10,
                          //     Text(
                          //       'David James',
                          //       style: AppFonts.SecondaryColorText14,
                          //     ),
                          //   ],
                          // ),
                          // Row(
                          //   children: [
                          //     CustomIconBox(
                          //       boxheight: 50,
                          //       boxwidth: 50,
                          //       boxIcon: Icons.messenger_outline_rounded,
                          //       radius: 8,
                          //       boxColor: Colors.grey.shade200,
                          //       iconSize: 24,
                          //       IconColor: Color(0xFF2EDEFF),
                          //       iconFunction: () {
                          //         Navigator.of(context).push(
                          //           MaterialPageRoute(
                          //             builder: (context) => InboxScreen(),
                          //           ),
                          //         );
                          //       },
                          //     ),
                          //     customSpaces.horizontalspace10,
                          //     CustomIconBox(
                          //       boxheight: 50,
                          //       boxwidth: 50,
                          //       boxIcon: Icons.phone_outlined,
                          //       radius: 8,
                          //       boxColor: Colors.grey.shade200,
                          //       iconSize: 24,
                          //       IconColor: AppColors.primaryColor,
                          //     ),
                          //   ],
                          // )
                        ],
                      ),
                    ),
                    customSpaces.verticalspace10,
                    Padding(
                      padding: customPaddings.horizontalpadding20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Overview',
                            style: AppFonts.SecondaryColorText20,
                          ),
                          customSpaces.verticalspace10,
                          Text(
                            property.value.propertyDescription ?? '',
                            textAlign: TextAlign.justify,
                            style: AppFonts.greyText14,
                          ),
                        ],
                      ),
                    ),
                    customSpaces.verticalspace20,
                    Padding(
                      padding: customPaddings.horizontalpadding20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Pictures',
                            style: AppFonts.SecondaryColorText20,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: customPaddings.horizontalpadding20,
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 1 / 1,
                        ),
                        itemBuilder: (context, index) {
                          if (index <
                              property.value.propertyGalleryPictures!.length) {
                            // Check if the index is within the bounds of the list
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Image(
                                height: 140,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    '${ApiEndPoints.baseurl}${property.value.propertyGalleryPictures![index].path}'),
                              ),
                            );
                          } else {
                            // If index is out of bounds, you can display a placeholder or empty container
                            return Container(); // Empty container
                          }
                        },
                        itemCount:
                            property.value.propertyGalleryPictures!.length,
                        shrinkWrap: true,
                      ),
                    ),

                    customSpaces.verticalspace20,
                    Padding(
                      padding: customPaddings.horizontalpadding20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Location',
                            style: AppFonts.SecondaryColorText20,
                          ),
                          customSpaces.verticalspace20,
                          GestureDetector(
                            onTap: () async {
                              await _launchDirections(
                                double.parse(property.value.latitude ?? '0.0'),
                                double.parse(property.value.longitude ?? '0.0'),
                              );
                            },
                            child: Container(
                              height: 200,
                              child: GoogleMap(
                                initialCameraPosition: CameraPosition(
                                  target: LatLng(
                                    double.parse(
                                        property.value.latitude ?? '0.0'),
                                    double.parse(
                                        property.value.longitude ?? '0.0'),
                                  ),
                                  zoom: 12,
                                ),
                                markers: <Marker>[
                                  Marker(
                                    markerId: MarkerId('property_location'),
                                    position: LatLng(
                                      double.parse(
                                          property.value.latitude ?? '0.0'),
                                      double.parse(
                                          property.value.longitude ?? '0.0'),
                                    ),
                                    infoWindow: InfoWindow(
                                      title: property.value.propertyName,
                                    ),
                                  ),
                                ].toSet(),
                              ),
                            ),
                          ),
                          customSpaces.verticalspace20,
                          // AmenitiesList(amenities: property.value.amenities),
                          customSpaces.verticalspace20,
                        ],
                      ),
                    ),

                    //
                  ],
                ),
              ),
            ),
          ),
          // Container(
          //   height: 80,
          //   decoration: BoxDecoration(
          //     border: Border(
          //       top: BorderSide(
          //         color: Colors.grey.shade300,
          //         width: 1,
          //       ),
          //     ),
          //   ),
          //   child: Padding(
          //     padding: customPaddings.horizontalpadding20,
          //     child: Row(
          //       children: [
          //         Expanded(
          //           child: Container(
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               children: [
          //                 Text(
          //                   'Price',
          //                   style: AppFonts.SecondaryColorText14,
          //                 ),
          //                 Text(
          //                   '₹ 10,000',
          //                   style: AppFonts.SecondaryColorText20,
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ),
          //         customSpaces.horizontalspace20,
          //         Expanded(
          //           child: Container(
          //             child: PrimaryButton(
          //               buttonText: 'Send Enquiry',
          //               buttonFunction: () {},
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  _launchDirections(double latitude, double longitude) async {
    final url =
        'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch Google Maps';
    }
  }
}
