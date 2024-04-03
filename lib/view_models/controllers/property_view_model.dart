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
  final List<String> categories = [
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
  final GlobalKey<FormState> propertyFormKey = GlobalKey<FormState>();

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

  Future<void> addPropertyData() async {
    submitButtonPressed.value = true;

    // if (propertyFormKey.currentState!.validate()) {
    PropertyModel property = PropertyModel(
      agent: agentId,
      propertyName: propertyName.text,
      propertyRooms: propertyRooms.text,
      propertyBathrooms: propertyBathrooms.text,
      propertySqft: propertySqft.text,
      propertyPrice: propertyPrice.text,
      propertyCategory: selectedCategory.value,
      propertyCity: propertyCity.text,
      propertyState: propertyState.text,
      propertyZip: propertyPincode.text,
      propertyCoverPicture: propertyCoverPicture,
      propertyGalleryPictures: propertyGalleryPictures,
      propertyDescription: propertyDescription.text,
      latitude: propertyLatitude.text,
      longitude: propertyLongitude.text,
      amenities: amenities,
      isApproved: false,
      isSold: false,
      tags: tags,
    );

    try {
      final response = await ApiServices.instance.addPropertyData(property);
      print(response.body);

      if (response.statusCode == 200) {
        print(response.body);
        await Get.find<AgentViewModel>().getAgentProperties();
        await Get.find<AgentViewModel>().getAllPropertiesInfoofAgent();
        Get.find<AgentViewModel>().update();
        Get.back();
        await Utils.snackBar(
          'Success',
          'Property Added Successfully',
        );
      } else {
        print('Error occurred while adding the property');
        await Utils.snackBar(
          'Error',
          'Error occurred while adding the property',
        );
      }
    } catch (e) {
      print('Error: $e');
      await Utils.snackBar(
        'Error',
        'An error occurred: $e',
      );
      // }
    }
  }

  Future<void> updatePropertyData(Rx<PropertyModel> property) async {
    // print(property.value.id);
    submitButtonPressed.value = true;

    // if (propertyFormKey.currentState!.validate()) {
    PropertyModel editedProperty = PropertyModel(
      id: property.value.id,
      agent: agentId,
      propertyName: propertyName.text,
      propertyCategory: selectedCategory.value,
      latitude: propertyLatitude.text,
      longitude: propertyLongitude.text,
      propertyRooms: propertyRooms.text,
      propertyBathrooms: propertyBathrooms.text,
      propertySqft: propertySqft.text,
      propertyPrice: propertyPrice.text,
      propertyCity: propertyCity.text,
      propertyState: propertyState.text,
      propertyZip: propertyPincode.text,
      updatedCoverPicture: updatedCoverPicture,
      removedImageUrls: removedImageUrls,
      propertyDescription: propertyDescription.text,
      amenities: amenities,
      tags: tags,
      newGalleryPictures: newGalleryPictures,
    );

    try {
      final response =
          await ApiServices.instance.updatePropertyData(editedProperty);
      print(response.body);

      if (response.statusCode == 200) {
        property.value = editedProperty;
        print(response.body);
        await Get.find<AgentViewModel>().getAgentProperties();
        Get.find<AgentViewModel>().update();
        await Utils.snackBar(
          'Success',
          'Property Updated Successfully',
        );
        Get.to(() => NavigationItems());
      } else {
        print('Error occurred while updating the property');
        await Utils.snackBar(
          'Error',
          'Error occurred while updating the property',
        );
      }
    } catch (e) {
      print('Error: $e');
      await Utils.snackBar(
        'Error',
        'An error occurred: $e',
      );
    }
    // }
  }

  Future<void> deleteProperty(String id) async {
    try {
      final response = await ApiServices.instance.deleteProperty(id);
      print(response);

      if (response['status'] == 'success') {
        await Get.find<AgentViewModel>().getAgentProperties();
        Get.find<AgentViewModel>().update();
        Get.to(NavigationItems());
        await Utils.snackBar('Success', 'Property Deleted Successfully');
      } else {
        print('Error occurred while deleting the property');
        await Utils.snackBar(
          'Error',
          'Error occurred while deleting the property',
        );
      }
    } catch (e) {
      print('Error: $e');
      await Utils.snackBar(
        'Error',
        'An error occurred: $e',
      );
    }
  }

  @override
  void onReady() {
    super.onReady();
    if (property != null) {
      propertyName.text = property!.value.propertyName;
      selectedCategory.value = property!.value.propertyCategory;

      propertyLatitude.text = property!.value.latitude ?? '';
      propertyLongitude.text = property!.value.longitude ?? '';

      propertyRooms.text = property!.value.propertyRooms ?? '0';
      propertyBathrooms.text = property!.value.propertyBathrooms ?? '0';
      propertySqft.text = property!.value.propertySqft ?? '0';

      propertyPrice.text = property!.value.propertyPrice;
      propertyCity.text = property!.value.propertyCity;
      propertyState.text = property!.value.propertyState ?? '';
      propertyPincode.text = property!.value.propertyZip ?? '';

      propertyCoverPicture = property!.value.propertyCoverPicture;
      // propertyGalleryPictures = property!.value.propertyGalleryPictures;

      propertyDescription.text = property!.value.propertyDescription ?? '';

      // if (property!.value.propertyGalleryPictures != null) {
      //   // Clear the existing list and add amenities from property
      //   propertyGalleryPictures!.clear();
      //   propertyGalleryPictures!
      //       .addAll(property!.value.propertyGalleryPictures!);
      // }

      if (property!.value.amenities != null) {
        // Clear the existing list and add amenities from property
        amenities.clear();
        amenities.addAll(property!.value.amenities!);
      }
      if (property!.value.tags != null) {
        tags.clear();
        tags.addAll(property!.value.tags!);
      }
      // amenities.value = property!.value.amenities ?? [];
      // tags = property!.value.tags ?? [];
    }
  }

  @override
  void onInit() {
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
    propertyName.clear();
    propertyRooms.clear();
    propertyBathrooms.clear();
    propertySqft.clear();
    propertyLatitude.clear();
    propertyLongitude.clear();
    propertyPrice.clear();
    propertyCity.clear();
    propertyState.clear();
    propertyPincode.clear();
    propertyDescription.clear();
    // propertyCoverPicture?.delete();
    propertyGalleryPictures?.clear();
    amenities.clear();
    tags.clear();
    removedImageUrls.clear();
  }
}
