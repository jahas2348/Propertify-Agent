import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:propertify_for_agents/models/property_model.dart';
import 'package:propertify_for_agents/resources/colors/app_colors.dart';
import 'package:propertify_for_agents/resources/components/buttons/custombuttons.dart';
import 'package:propertify_for_agents/resources/components/dropdown/dropdowns.dart';
import 'package:propertify_for_agents/resources/components/iconbox/customIconBox.dart';
import 'package:propertify_for_agents/resources/components/image_picker/multi_image_picker.dart';
import 'package:propertify_for_agents/resources/components/image_picker/single_image_picker.dart';
import 'package:propertify_for_agents/resources/components/input_fileds/custom_Input_Fields.dart';
import 'package:propertify_for_agents/resources/components/input_fileds/custom_Multi_Line_Input_Field.dart';
import 'package:propertify_for_agents/resources/fonts/app_fonts/app_fonts.dart';
import 'package:propertify_for_agents/services/api_endpoinds.dart';
import 'package:propertify_for_agents/services/api_services.dart';
import 'package:propertify_for_agents/view_models/controllers/agent_view_model.dart';
import 'package:propertify_for_agents/resources/constants/spaces%20&%20paddings/paddings.dart';
import 'package:propertify_for_agents/resources/constants/spaces%20&%20paddings/spaces.dart';
import 'package:propertify_for_agents/view_models/controllers/property_view_model.dart';

class AddPropertyScreen extends StatefulWidget {
  AddPropertyScreen({Key? key, this.property});
  final Rx<PropertyModel>? property;
  @override
  State<AddPropertyScreen> createState() => _AddPropertyScreenState();
}

class _AddPropertyScreenState extends State<AddPropertyScreen> {
  late PropertyViewModel propertyController;
  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    propertyController =
        Get.put(PropertyViewModel(property: widget.property?.value));

  //   if (widget.property != null) {
  //   propertyController.propertyName.text = widget.property!.value.propertyName;
  //   propertyController.propertyPrice.text = widget.property!.value.propertyPrice;
  //   propertyController.propertyPrice.text = widget.property!.value.propertyPrice;
  //   propertyController.propertyCity.text = widget.property!.value.propertyCity;
  //   propertyController.propertyState.text = widget.property!.value.propertyState!;
  //   propertyController.propertyPincode.text = widget.property!.value.propertyZip!;
  //   propertyController.propertyDescription.text = widget.property!.value.propertyDescription!;
  //   propertyController.propertyCategory.text = widget.property!.value.propertyCategory;
    
  //   // Assign other fields here
  // }
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.property!.toJson());
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: propertyController.propertyformkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customSpaces.verticalspace20,
                Padding(
                  padding: customPaddings.horizontalpadding20,
                  child: Row(
                    children: [
                      CustomIconBox(
                        boxheight: 40,
                        boxwidth: 40,
                        boxIcon: Icons.arrow_back,
                        radius: 8,
                        boxColor: Colors.grey.shade300,
                        iconSize: 20,
                      ),
                      customSpaces.horizontalspace20,
                      Text(
                        "Add New Property",
                        style: AppFonts.SecondaryColorText20,
                      ),
                    ],
                  ),
                ),
                customSpaces.verticalspace20,
                Padding(
                  padding: customPaddings.horizontalpadding20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomInputField(
                        fieldIcon: Icons.home_max_outlined,
                        hintText: 'Enter Property Name',
                        controller: propertyController.propertyName,
                        validator: (value) {
                          return propertyController.validatePropertyData(
                              value, 'Property Name');
                        },
                      ),
                      customSpaces.verticalspace20,
                      CustomInputField(
                        fieldIcon: Icons.currency_rupee_sharp,
                        hintText: 'Enter Property Price',
                        controller: propertyController.propertyPrice,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          return propertyController
                              .validatePropertyPrice(value);
                        },
                      ),
                      customSpaces.verticalspace20,
                      CustomDropdown(
                        items: propertyController.Categories,
                        selectedCategory: propertyController.selectedCategory,
                        onChanged: (selectedItem) {
                          propertyController.selectedCategory.value =
                              selectedItem ?? '';
                          print("Selected Category: $selectedItem");
                        },
                        hintText: 'Choose Category', // Display hint text here
                      ),
                      customSpaces.verticalspace20,
                      CustomInputField(
                        fieldIcon: Icons.location_city,
                        hintText: 'Enter Property City',
                        controller: propertyController.propertyCity,
                        validator: (value) {
                          return propertyController.validatePropertyData(
                              value, 'Property City');
                        },
                      ),
                      customSpaces.verticalspace20,
                      CustomInputField(
                        fieldIcon: Icons.map_outlined,
                        hintText: 'Enter Property State',
                        controller: propertyController.propertyState,
                        validator: (value) {
                          return propertyController.validatePropertyData(
                              value, 'Property State');
                        },
                      ),
                      customSpaces.verticalspace20,
                      CustomInputField(
                        fieldIcon: Icons.pin_outlined,
                        hintText: 'Enter Property Pincode',
                        controller: propertyController.propertyPincode,
                        validator: (value) {
                          return propertyController
                              .validatePropertyPincode(value);
                        },
                        keyboardType: TextInputType.number,
                      ),
                      customSpaces.verticalspace20,
                      Text(
                        "Property Cover Picture",
                        style: AppFonts.SecondaryColorText16,
                      ),
                      customSpaces.verticalspace20,
                      SingleImagePickerWidget(
                        onImageSelected: (File? image) {
                          setState(() {
                            propertyController.propertyCoverPicture = image;
                          });
                        },
                        initialImageUrl: widget
                                    .property?.value?.propertyCoverPicture !=
                                null
                            ? '${ApiEndPoints.baseurl}${widget.property!.value!.propertyCoverPicture!.path}'
                            : null,
                      ),
                      customSpaces.verticalspace20,
                      // MultiImagePickerWidget(
                      //   onImagesSelected: (images) {
                      //     setState(() {
                      //       propertyController.propertyGalleryPictures = images;
                      //     });
                      //   },
                      //   initialImageUrls: widget
                      //               .property?.value?.propertyGalleryPictures !=
                      //           null
                      //       ? widget.property!.value!.propertyGalleryPictures!
                      //           .map((image) =>
                      //               '${ApiEndPoints.baseurl}${image.path}')
                      //           .toList()
                      //       : [],
                      // ),
                      MultiImagePickerWidget(
                        onImagesSelected: (images) {
                          setState(() {
                            // Update propertyGalleryPictures when images are selected
                            propertyController.propertyGalleryPictures = images;

                            // Handle image deletions here
                            final selectedImageUrls =
                                images!.map((image) => image.path).toList();
                            final existingImageUrls = widget
                                    .property?.value?.propertyGalleryPictures
                                    ?.map((image) =>
                                        '${ApiEndPoints.baseurl}${image.path}')
                                    .toList() ??
                                [];

                            // Calculate which images were deleted
                            final deletedImageUrls = existingImageUrls
                                .where((imageUrl) =>
                                    !selectedImageUrls.contains(imageUrl))
                                .map((imageUrl) => imageUrl.replaceAll(
                                    ApiEndPoints.baseurl, ''))
                                .toList();

                            // You can now handle the deletion of images based on deletedImageUrls
                            // You might want to send a request to your server to delete these images
                            // or update your PropertyModel to reflect the deletions.

                            // For example, if you want to print the deleted image URLs:
                            print('Deleted Image URLs: $deletedImageUrls');
                          });
                        },
                        initialImageUrls: widget
                                    .property?.value?.propertyGalleryPictures !=
                                null
                            ? widget.property!.value!.propertyGalleryPictures!
                                .map((image) =>
                                    '${ApiEndPoints.baseurl}${image.path}')
                                .toList()
                            : [],
                      ),

                      customSpaces.verticalspace20,
                      Text(
                        "Overview",
                        style: AppFonts.SecondaryColorText16,
                      ),
                      customSpaces.verticalspace20,
                      CustomMultiLineInputField(
                        hintText: '',
                        keyboardType: TextInputType.multiline,
                        maxLines: 8,
                        controller: propertyController.propertyDescription,
                        validator: (value) {
                          return propertyController.validatePropertyData(
                              value, 'Property Overview');
                        },
                      ),
                      customSpaces.verticalspace20,
                      Text(
                        "Features & Amenities",
                        style: AppFonts.SecondaryColorText16,
                      ),
                      customSpaces.verticalspace20,
                      // Display the list of amenities
                      Obx(() {
                        if (propertyController.submitButtonPressed.value) {
                          if (propertyController.amenities.isEmpty) {
                            return Column(
                              children: [
                                Text(
                                  'Amenities list is empty. Please add amenities.',
                                  style: TextStyle(
                                    color: Colors
                                        .red, // Customize the color as needed
                                  ),
                                ),
                                SizedBox(
                                    height: 16), // Adjust the spacing as needed
                              ],
                            );
                          }
                        }

                        return ListView.builder(
                          itemCount: propertyController.amenities.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final amenity = propertyController.amenities[index];
                            return Container(
                              child: ListTile(
                                tileColor: Colors.grey,
                                leading: Text('$index'),
                                title: Text(amenity.amenityname ?? ''),
                                subtitle: Text(amenity.amenityValue ?? ''),
                              ),
                            );
                          },
                        );
                      }),
                      customSpaces.verticalspace20,
                      ElevatedButton(
                        onPressed: () {
                          _showAmenitiesBottomSheet(
                              context, propertyController);
                        },
                        child: Text('Add Amenity'),
                      ),
                      // Add Amenities Input here
                      // PrimaryButton(
                      //   buttonText:
                      //       widget.property == null ? 'Submit' : 'Update',
                      //   buttonFunction: () async {
                      //     await addPropertyToServer;
                      //     await propertyController.addPropertyData();
                      //   },
                      // ),
                      PrimaryButton(
                        buttonText:
                            widget.property == null ? 'Submit' : 'Update',
                        buttonFunction: () async {
                          if (widget.property == null) {
                            await propertyController.addPropertyData();
                          } else {
                            // final property = widget.property?.value;

                            final propertyId = widget.property!.value.id;

                            await propertyController.UpdatePropertyData(
                              widget.property!,
                            );
                            print('updating success');
                          }
                          print('updating success');
                        },
                      ),
                      customSpaces.verticalspace40,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Function to add property to the server
Future<void> addPropertyToServer(PropertyModel property) async {
  try {
    final response = await ApiServices.instance.addPropertyData(property);
    print(response.body);

    if (response.statusCode == 200) {
      print(response.body);
      await Get.find<AgentViewModel>().getAgentProperties();
      // ignore: invalid_use_of_protected_member
      Get.find<AgentViewModel>().refresh();
    } else {
      print('Error occurred while adding the property');
    }
  } catch (e) {
    print('Error: $e');
  }
}

// Function to update property on the server
Future<void> updatePropertyOnServer(PropertyModel property) async {
  try {
    final response = await ApiServices.instance.updatePropertyData(property);
    print(response.body);

    if (response.statusCode == 200) {
      print(response.body);
      await Get.find<AgentViewModel>().getAgentProperties();
    } else {
      print('Error occurred while updating the property');
    }
  } catch (e) {
    print('Error: $e');
  }
}

void _showAmenitiesBottomSheet(context, propertyController) {
  final TextEditingController amenityNameController = TextEditingController();
  final TextEditingController amenityValueController = TextEditingController();

  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Add Amenity',
                  style: AppFonts.SecondaryColorText20,
                ),
                customSpaces.verticalspace20,
                TextField(
                  controller: amenityNameController,
                  decoration: InputDecoration(
                    labelText: 'Amenity Name',
                  ),
                ),
                customSpaces.verticalspace20,
                TextField(
                  controller: amenityValueController,
                  decoration: InputDecoration(
                    labelText: 'Amenity Value',
                  ),
                ),
                customSpaces.verticalspace20,
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      final newAmenity = Amenity(
                        amenityname: amenityNameController.text,
                        amenityValue: amenityValueController.text,
                      );
                      // ignore: invalid_use_of_protected_member
                      propertyController.amenities.value.add(newAmenity);
                      propertyController.amenities.refresh();
                      print(propertyController.amenities);
                    });
                    Navigator.pop(context); // Close the bottom sheet
                  },
                  child: Text('Add Amenity'),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
