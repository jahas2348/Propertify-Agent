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

  PropertyModel? property;
  

  final agentViewModel = Get.find<AgentViewModel>();

  PropertyViewModel({this.property});
  String get agentId => agentViewModel.agentId;

  final _api = PropertyRepository();
  RxBool submitButtonPressed = false.obs;
  final propertyName = TextEditingController();
  final propertyPrice = TextEditingController();
  final propertyCategory = TextEditingController();
  final List<String> Categories = [
    'House',
    'Apartment',
    'Office',
    'Other',
  ];
  RxString selectedCategory = ''.obs;
  final propertyCity = TextEditingController();
  final propertyState = TextEditingController();
  final propertyPincode = TextEditingController();
  File? propertyCoverPicture;
  List<XFile>? propertyGalleryPictures = [];
  final propertyDescription = TextEditingController();
  RxList<Amenity> amenities = <Amenity>[].obs;
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

    final propertyFormKeyIsValid =
        propertyformkey.currentState?.validate() ?? false;
    final isCategorySelected =
        selectedCategory != null && selectedCategory!.value.isNotEmpty;

    if (propertyFormKeyIsValid && isCategorySelected) {
      PropertyModel property = PropertyModel(
        agent: agentId,
        propertyName: propertyName.value.text,
        propertyPrice: propertyPrice.value.text,
        propertyCategory: selectedCategory.value,
        propertyCity: propertyCity.value.text,
        propertyState: propertyState.value.text,
        propertyZip: propertyPincode.value.text,
        propertyCoverPicture: propertyCoverPicture,
        propertyGalleryPictures: propertyGalleryPictures,
        propertyDescription: propertyDescription.value.text,
        longitude: '0.0',
        latitude: '0.0',
        amenities: amenities.value.map((e) => Amenity.toJson(e)).toList(),
      );

      try {
      final response = await ApiServices.instance.addPropertyData(property);
      print(response.body);

      if (response.statusCode == 201) {
        print(response.body);
        await Get.find<AgentViewModel>().getAgentProperties();
        Get.find<AgentViewModel>().update();
        Get.back();

      } else {
        print('Error occurred while adding the property');
      }
    } catch (e) {
      print('Error: $e');
    }
      // try {
        

      //   await _api.addPropertyData(property).then((response) {
      //     if (response != null) {
      //       // Property uploaded successfully
      //       agentViewModel.agentProperties;
      //       print('Property uploaded successfully');
      //     } else {
      //       print('Error occurred while adding the property');
      //     }
      //   });
      // } catch (e) {
      //   print('Error: $e');
      // }
    } else {
      if (!isCategorySelected) {
        Utils.snackBar('Error', 'Category Not Selected');
      }
      // ... (other error messages)
    }
  }
  
  UpdatePropertyData(Rx<PropertyModel> Property) async {
    submitButtonPressed.value = true;

    final propertyFormKeyIsValid =
        propertyformkey.currentState?.validate() ?? false;
    final isCategorySelected =
        // ignore: unnecessary_null_comparison
        selectedCategory != null && selectedCategory.value.isNotEmpty;

    if (propertyFormKeyIsValid && isCategorySelected) {
      PropertyModel newproperty = PropertyModel(
        id: Property.value.id,
        agent: agentId,
        propertyName: propertyName.value.text,
        propertyPrice: propertyPrice.value.text,
        propertyCategory: selectedCategory.value,
        propertyCity: propertyCity.value.text,
        propertyState: propertyState.value.text,
        propertyZip: propertyPincode.value.text,
        propertyCoverPicture: propertyCoverPicture,
        propertyGalleryPictures: propertyGalleryPictures,
        propertyDescription: propertyDescription.value.text,
        longitude: '0.0',
        latitude: '0.0',
        // ignore: invalid_use_of_protected_member
        amenities: amenities.value.map((e) => Amenity.toJson(e)).toList(),
      );

      try {
      final response = await ApiServices.instance.updatePropertyData(newproperty);
      print(response.body);

      if (response.statusCode == 200) {
        property = newproperty;
        print(response.body);
        await Get.find<AgentViewModel>().getAgentProperties();
       
        Get.find<AgentViewModel>().update();
        Get.to(NavigationItems());

      } else {
        print('Error occurred while adding the property');
      }
    } catch (e) {
      print('Error: $e');
    }
      // try {
        

      //   await _api.addPropertyData(property).then((response) {
      //     if (response != null) {
      //       // Property uploaded successfully
      //       agentViewModel.agentProperties;
      //       print('Property uploaded successfully');
      //     } else {
      //       print('Error occurred while adding the property');
      //     }
      //   });
      // } catch (e) {
      //   print('Error: $e');
      // }
    } else {
      if (!isCategorySelected) {
        Utils.snackBar('Error', 'Category Not Selected');
      }
      // ... (other error messages)
    }
  }

  deleteProperty(String id) async {

    
    try {
      final response = await ApiServices.instance.deleteProperty(id);
      print(response);

      if (response['status']) {
        
        await Get.find<AgentViewModel>().getAgentProperties();
        Get.find<AgentViewModel>().update();
        Get.to(NavigationItems());

      } else {
        print('Error occurred while adding the property');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  

 @override
void onReady() {
  super.onReady();
  if (property != null) {
    propertyName.text = property!.propertyName;
    propertyPrice.text = property!.propertyPrice;
    propertyCategory.text = property!.propertyCategory;
    propertyCity.text = property!.propertyCity;
    propertyState.text = property!.propertyState!;
    propertyPincode.text = property!.propertyZip!;
    propertyDescription.text = property!.propertyDescription!;

    // Check if the property has existing amenities
    if (property!.amenities != null) {
      // Append the existing amenities from the property object to the existing list.
      amenities.addAll(property!.amenities!.map((e) => Amenity.fromJson(e)));
    }
  }
}

  @override
  void onClose() {
    super.onClose();
  }
  
}
