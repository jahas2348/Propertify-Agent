import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:propertify_for_agents/models/property_model.dart';
import 'package:propertify_for_agents/repositories/property_repository/property_repository.dart';
import 'package:propertify_for_agents/services/api_services.dart';
import 'package:propertify_for_agents/utils/utils.dart';
import 'package:propertify_for_agents/view_models/controllers/agent_view_model.dart';
import 'package:propertify_for_agents/views/navigation/navigation.dart';

class PropertyViewModel extends GetxController {
  Rx<PropertyModel>? property;

  final agentViewModel = Get.find<AgentViewModel>();

  PropertyViewModel({this.property});

  String get agentId => agentViewModel.agentId;

  final _api = PropertyRepository();

  RxBool submitButtonPressed = false.obs;
  final List<String> Categories = [
    'House',
    'Apartment',
    'Office',
    'Other',
  ];
  RxString selectedCategory = ''.obs;

  final propertyName = TextEditingController();

  final propertyRooms = TextEditingController();
  final propertyBathrooms = TextEditingController();
  final propertySqft = TextEditingController();

  final propertyCategory = TextEditingController();

  final propertyLatitude = TextEditingController();
  final propertyLongitude = TextEditingController();

  final propertyPrice = TextEditingController();
  final propertyCity = TextEditingController();
  final propertyState = TextEditingController();
  final propertyPincode = TextEditingController();
  File? propertyCoverPicture;
  File? updatedCoverPicture;
  List<XFile>? propertyGalleryPictures;
  List<XFile>? newGalleryPictures;
  final propertyDescription = TextEditingController();
  RxList<String> amenities = <String>[].obs;
  List<String> tags = [];
  List<String> removedImageUrls = [];
  final GlobalKey<FormState> propertyformkey = GlobalKey<FormState>();

  String? validatePropertyData(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName cannot be empty';
    }
    return null;
  }

  String? validatePropertyPrice(String? value) {
    if (value == null || value.isEmpty) {
      return 'Property price cannot be empty';
    }

    // Regular expression pattern to match a positive number
    final RegExp numericRegex = RegExp(r'^[1-9]\d*(\.\d+)?$');

    if (!numericRegex.hasMatch(value)) {
      return 'Invalid property price';
    }

    return null;
  }

  String? validatePropertyPincode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Property pincode cannot be empty';
    }

    // Regular expression pattern to match Indian PIN codes
    final RegExp indianPincodeRegex = RegExp(r'^[1-9][0-9]{5}$');

    if (!indianPincodeRegex.hasMatch(value)) {
      return 'Invalid PIN code';
    }

    return null;
  }

  addPropertyData() async {
    submitButtonPressed.value = true;

    // final propertyFormKeyIsValid =
    //     propertyformkey.currentState?.validate() ?? false;
    // final isCategorySelected =
    //     selectedCategory != null && selectedCategory!.value.isNotEmpty;

    // if (propertyFormKeyIsValid && isCategorySelected) {
    PropertyModel property = PropertyModel(
      agent: agentId,
      propertyName: propertyName.value.text,
      propertyRooms: propertyRooms.value.text,
      propertyBathrooms: propertyBathrooms.value.text,
      propertySqft: propertySqft.value.text,
      propertyPrice: propertyPrice.value.text,
      propertyCategory: selectedCategory.value,
      propertyCity: propertyCity.value.text,
      propertyState: propertyState.value.text,
      propertyZip: propertyPincode.value.text,
      propertyCoverPicture: propertyCoverPicture,
      propertyGalleryPictures: propertyGalleryPictures,
      propertyDescription: propertyDescription.value.text,
      latitude: propertyLatitude.value.text,
      longitude: propertyLongitude.value.text,
      amenities: amenities,
      isApproved: false,
      isSold: false,
      tags: tags,
    );
    // print(property.agent);
    // print(property.propertyName);
    // print(property.propertyRooms);
    // print(property.propertyBathrooms);
    // print(property.propertySqft);
    // print(property.propertyCategory);
    // print(property.latitude);
    // print(property.longitude);
    // print(property.propertyPrice);
    // print(property.propertyCity);
    // print(property.propertyState);
    // print(property.propertyZip);
    // print(property.propertyDescription);
    // print(property.propertyCoverPicture);
    print(property.propertyCoverPicture);
    // print(property.amenities);
    // print(property.tags);

    try {
      final response = await ApiServices.instance.addPropertyData(property);
      print(response.body);

      if (response.statusCode == 200) {
        print(response.body);
        await Get.find<AgentViewModel>().getAgentProperties();
        Get.find<AgentViewModel>().update();
        Get.back();
        await Utils.snackBar(
          'Success',
          'Property Added Successfully',
        );
      } else {
        print('Error occurred while adding the property');
      }
    } catch (e) {
      print('Error: $e');
    }
    // } else {
    //   if (!isCategorySelected) {
    //     Utils.snackBar('Error', 'Category Not Selected');
    //   }
    // }
  }

  UpdatePropertyData(Rx<PropertyModel> Property) async {
    print(Property.value.id);
    submitButtonPressed.value = true;

    final propertyFormKeyIsValid =
        propertyformkey.currentState?.validate() ?? false;
    final isCategorySelected =
        selectedCategory != null && selectedCategory.value.isNotEmpty;

    if (propertyFormKeyIsValid && isCategorySelected) {
      PropertyModel editedproperty = PropertyModel(
        id: Property.value.id,
        agent: agentId,
        propertyName: propertyName.value.text,
        propertyCategory: selectedCategory.value,
        latitude: propertyLatitude.value.text,
        longitude: propertyLongitude.value.text,
        propertyRooms: propertyRooms.value.text,
        propertyBathrooms: propertyBathrooms.value.text,
        propertySqft: propertySqft.value.text,
        propertyPrice: propertyPrice.value.text,
        propertyCity: propertyCity.value.text,
        propertyState: propertyState.value.text,
        propertyZip: propertyPincode.value.text,
        updatedCoverPicture:
            updatedCoverPicture, // Handle this according to your logic
        removedImageUrls: removedImageUrls,
        propertyDescription: propertyDescription.value.text,
        amenities: amenities,
        tags: tags,
        newGalleryPictures: newGalleryPictures, // Initialize with an empty list
      );
      print(editedproperty.updatedCoverPicture);

      try {
        final response =
            await ApiServices.instance.updatePropertyData(editedproperty);
        print(response.body);

        if (response.statusCode == 200) {
          Property.value = editedproperty;
          print(response.body);
          await Get.find<AgentViewModel>().getAgentProperties();
          Get.find<AgentViewModel>().update();
          Get.back();
        } else {
          print('Error occurred while updating the property');
        }
      } catch (e) {
        print('Error: $e');
      }
    } else {
      if (!isCategorySelected) {
        Utils.snackBar('Error', 'Category Not Selected');
      }
    }
  }

  deleteProperty(String id) async {
    try {
      final response = await ApiServices.instance.deleteProperty(id);
      print(response);

      if (response['status'] == 'success') {
        await Get.find<AgentViewModel>().getAgentProperties();
        Get.find<AgentViewModel>().update();
        Get.to(NavigationItems());
        await Utils.snackBar('Success', 'Property Deleted Successfully');
      } else {
        print('Error occurred while adding the property');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void onReady() {
    print('in onready');

    super.onReady();
    if (property != null) {
      propertyName.text = property!.value.propertyName;
      propertyRooms.text = property!.value.propertyRooms ?? '0';
      propertyBathrooms.text = property!.value.propertyBathrooms ?? '0';
      propertySqft.text = property!.value.propertySqft ?? '0';

      propertyPrice.text = property!.value.propertyPrice;

      propertyCity.text = property!.value.propertyCity;
      propertyState.text = property!.value.propertyState!;
      propertyPincode.text = property!.value.propertyZip!;
      propertyDescription.text = property!.value.propertyDescription!;
      propertyLatitude.text = property!.value.latitude!;
      propertyLongitude.text = property!.value.longitude!;
      if (property!.value.amenities != null) {
        // Clear the existing list and add amenities from property
        amenities.clear();
        amenities.addAll(property!.value.amenities!);
      }
      if (property!.value.tags != null) {
        tags.clear();
        tags.addAll(property!.value.tags!);
      }

      // amenities = property!.value.amenities!;
      // tags = property!.value.tags!;
      // if (property != null && property!.value.amenities != null) {
      //   amenities.addAll(property!.value.amenities!);
      // }

      // Check if the property has existing amenities
      // if (property!.amenities != null) {
      //   // Append the existing amenities from the property object to the existing list.
      //   amenities.addAll(property!.amenities!.map((e) => Amenity.fromJson(e)));
      // }
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit

    super.onInit();
    if (property != null) {
      selectedCategory.value = property!.value.propertyCategory;
    } else {
      selectedCategory.value = '';
    }
  }

  @override
  void onClose() {
    super.onClose();
    // Clear all text controller values
    propertyName.clear();
    propertyPrice.clear();
    propertyCategory.clear();
    propertyCity.clear();
    propertyState.clear();
    propertyPincode.clear();
    propertyLatitude.clear();
    propertyLongitude.clear();
    propertyDescription.clear();
    // Clear other lists or variables if needed
    amenities.clear();
    tags.clear();
    removedImageUrls.clear();
  }
}
