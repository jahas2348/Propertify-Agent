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
  final List<String> Categories = [
    'House',
    'Apartment',
    'Office',
    'Other',
  ];
  RxString selectedCategory = ''.obs;

  final propertyName = TextEditingController();
  final propertyCategory = TextEditingController();
  
  final propertyLatitude = TextEditingController();
  final propertyLongitude = TextEditingController();



  final propertyPrice = TextEditingController();
  final propertyCity = TextEditingController();
  final propertyState = TextEditingController();
  final propertyPincode = TextEditingController();
  File? propertyCoverPicture;
  List<XFile>? propertyGalleryPictures = [];
  final propertyDescription = TextEditingController();
  List<String> amenities = [];
  List<String> tags = [];
  List<int> removeIndexes = [];
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
        latitude: propertyLatitude.value.text,
        longitude: propertyLongitude.value.text,
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
        Get.find<AgentViewModel>().update();
        Get.back();
        await Utils.snackBar('Success', 'Property Added Successfully',);

      } else {
        print('Error occurred while adding the property');
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
        latitude: propertyLatitude.value.text,
        longitude: propertyLongitude.value.text,
        // ignore: invalid_use_of_protected_member
        // amenities: amenities.value.map((e) => Amenity.toJson(e)).toList(),
        amenities: [],
      );

      try {
      final response = await ApiServices.instance.updatePropertyData(newproperty,removeIndexes);
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

      if (response['status']=='success') {
        
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
  super.onReady();
  if (property != null) {
    propertyName.text = property!.propertyName;
    propertyPrice.text = property!.propertyPrice;
    propertyCategory.text = property!.propertyCategory;
    propertyCity.text = property!.propertyCity;
    propertyState.text = property!.propertyState!;
    propertyPincode.text = property!.propertyZip!;
    propertyDescription.text = property!.propertyDescription!;
    propertyLatitude.text = property!.latitude!;
    propertyLongitude.text = property!.longitude!;
    amenities = property!.amenities!;
    tags = property!.tags!;
    if (property != null && property!.amenities != null) {
  amenities.addAll(property!.amenities!);
}

    // Check if the property has existing amenities
    // if (property!.amenities != null) {
    //   // Append the existing amenities from the property object to the existing list.
    //   amenities.addAll(property!.amenities!.map((e) => Amenity.fromJson(e)));
    // }
  }
}

  @override
  void onClose() {
    super.onClose();
  }
  
}
