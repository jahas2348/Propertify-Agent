import 'dart:io';
import 'package:image_picker/image_picker.dart';

class PropertyModel {
  String? id;
  String agent;
  String propertyName;
  String propertyPrice;
  String propertyCategory;
  String propertyCity;
  String? propertyState;
  String? propertyZip;
  File? propertyCoverPicture; // Keep it as File
  List<XFile>? propertyGalleryPictures;
  String? propertyDescription;
  String? longitude;
  String? latitude;
  List<Map<String, dynamic>>? amenities;
  bool? isApproved;

  // Add this field for newly added gallery pictures
  List<XFile>? newlyAddedGalleryPictures;

  PropertyModel({
    this.id,
    required this.agent,
    required this.propertyName,
    required this.propertyPrice,
    required this.propertyCategory,
    required this.propertyCity,
    this.propertyState,
    this.propertyZip,
    this.propertyCoverPicture,
    this.propertyGalleryPictures,
    this.propertyDescription,
    this.longitude,
    this.latitude,
    this.amenities,
    this.isApproved,
    this.newlyAddedGalleryPictures,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'agent': agent,
      'propertyName': propertyName,
      'propertyPrice': propertyPrice,
      'propertyCategory': propertyCategory,
      'propertyCity': propertyCity,
      'propertyState': propertyState,
      'propertyZip': propertyZip,
      'propertyDescription': propertyDescription,
      'longitude': longitude,
      'latitude': latitude,
      'amenities': amenities,
      'isApproved': isApproved,
    };

    if (id != null) {
      data['_id'] = id;
    }

    if (propertyCoverPicture != null) {
      // Store the path or relevant data about the File as needed
      data['propertyCoverPicture'] = propertyCoverPicture!.path;
    }

    if (propertyGalleryPictures != null) {
      data['propertyGalleryPictures'] =
          propertyGalleryPictures!.map((x) => x.path).toList();
    }

    if (newlyAddedGalleryPictures != null) {
      data['newlyAddedGalleryPictures'] =
          newlyAddedGalleryPictures!.map((x) => x.path).toList();
    }

    return data;
  }

  factory PropertyModel.fromJson(Map<String, dynamic> json) {

    // Process the amenities data
    List<Map<String, dynamic>> parsedAmenities = [];
    if (json['amenities'] != null) {
       json['amenities'].forEach((amenity) {
          parsedAmenities.add({
             'amenityname': amenity['amenityname'],
             'amenityValue': amenity['amenityValue'],
             '_id': amenity['_id'],
          });
       });
     }

    return PropertyModel(
      id: json['_id'],
      agent: json['agent'],
      propertyName: json['propertyName'],
      propertyPrice: json['propertyPrice'],
      propertyCategory: json['propertyCategory'],
      propertyCity: json['propertyCity'],
      propertyState: json['propertyState'],
      propertyZip: json['propertyZip'],
      propertyCoverPicture: File(json['propertyCoverPicture'][0]), // Take the first item from the list
      propertyGalleryPictures: List<XFile>.from(json['propertyGalleryPictures'].map((path) => XFile(path))), // Populate the list correctly
      propertyDescription: json['propertyDescription'],
      longitude: json['longitude'],
      latitude: json['latitude'],
      amenities: parsedAmenities,
      isApproved: json['isApproved'],
    );
}
}

class Amenity {
  String? amenityname;
  String? amenityValue;
  String? id;

  Amenity({
    this.amenityname,
    this.amenityValue,
    this.id,
  });

  static Map<String, dynamic> toJson (Amenity amenity) {
    return {
      'amenityname': amenity.amenityname,
      'amenityValue': amenity.amenityValue,
      '_id': amenity.id,
    };
  }


  factory Amenity.fromJson(Map<String, dynamic> json) => Amenity(
        id: json['_id'],
        amenityname: json['amenityname'],
        amenityValue: json['amenityValue'],
      );

  static fromMap(Map<String, dynamic> map) {}
}
