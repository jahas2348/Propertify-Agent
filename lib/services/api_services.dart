import 'dart:convert';
import 'dart:io';
import 'package:propertify_for_agents/models/property_model.dart';
import 'package:propertify_for_agents/services/api_endpoinds.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ApiServices {
  ApiServices._();
  static final _instance = ApiServices._();
  static ApiServices get instance => _instance;
  final _headers = {'Content-Type': 'application/json'};

  //Get Agent Data
  Future<Map<String, dynamic>> getAgentData(String? agentPhone) async {
    final url = Uri.parse('${ApiEndPoints.baseurl}${ApiEndPoints.getAgent}');
    final requestBody = jsonEncode({"mobNo": agentPhone});
    final response = await http.post(url, headers: _headers, body: requestBody);
    final agent = jsonDecode(response.body);
    print('Here');
    print(agent);
    return agent;
  }

  //Check Agent Exist or Not
  Future<Map<String, dynamic>> checkAgentPhoneNumber(
      String formattedPhoneNumber) async {
    print('inside api function');
    final url = Uri.parse('${ApiEndPoints.baseurl}${ApiEndPoints.checkAgent}');
    final requestBody = jsonEncode({"mobNo": formattedPhoneNumber});
    final response = await http.post(url, headers: _headers, body: requestBody);
    final agentPhone = jsonDecode(response.body);
    print('123');
    print(agentPhone);
    return agentPhone;
  }

  //Add Property Data
  Future<http.Response> addPropertyData(PropertyModel property) async {
    final url =
        Uri.parse('${ApiEndPoints.baseurl}${ApiEndPoints.addPropertyData}');
    final request = http.MultipartRequest('POST', url);

    // Convert the PropertyModel to JSON
    final propertyJson = property.toJson();

    // Add fields to the request
    request.fields['agent'] = property.agent;
    
    request.fields['propertyName'] = property.propertyName;
    request.fields['propertyPrice'] = property.propertyPrice;
    request.fields['propertyCategory'] = property.propertyCategory;
    request.fields['propertyCity'] = property.propertyCity;
    request.fields['propertyState'] = property.propertyState ?? "";
    request.fields['propertyZip'] = property.propertyZip ?? "";
    request.fields['propertyDescription'] = property.propertyDescription ?? "";
    request.fields['longitude'] = property.longitude ?? "";
    request.fields['latitude'] = property.latitude ?? "";
    request.fields['isApproved'] = property.isApproved?.toString() ?? "false";

    // Upload property cover picture
    final propertyCoverPicture = property.propertyCoverPicture;
    if (propertyCoverPicture != null) {
      final imageStream = http.ByteStream(propertyCoverPicture.openRead());
      final imageLength = await propertyCoverPicture.length();

      final multipartFile = http.MultipartFile(
        'propertyCoverPicture',
        imageStream,
        imageLength,
        filename: 'cover_picture.jpg', // Change the filename as needed
        contentType:
            MediaType('image', 'jpeg'), // Adjust content type if necessary
      );

      request.files.add(multipartFile);
    }

    // Upload property gallery pictures
    final propertyGalleryPictures = property.propertyGalleryPictures;
    if (propertyGalleryPictures != null && propertyGalleryPictures.isNotEmpty) {
      for (final galleryPicture in propertyGalleryPictures) {
        final imageStream = http.ByteStream(galleryPicture.openRead());
        final imageLength = await galleryPicture.length();

        final multipartFile = http.MultipartFile(
          'propertyGalleryPictures', // Use [] to represent an array
          imageStream,
          imageLength,
          filename: 'gallery_picture.jpg', // Change the filename as needed
          contentType:
              MediaType('image', 'jpeg'), // Adjust content type if necessary
        );

        request.files.add(multipartFile);
      }
    }

    for (var i = 0; i < propertyJson['amenities'].length; i++) {
      request.fields['amenities[$i][amenityname]'] =
          propertyJson['amenities'][i]['amenityname'];
      request.fields['amenities[$i][amenityValue]'] =
          propertyJson['amenities'][i]['amenityValue'];
    }
    final response = await request.send();
    final responseString = await response.stream.bytesToString();
    print(response.statusCode);
    return http.Response(responseString, response.statusCode);
  }

  //Update Property Data
  Future<http.Response> updatePropertyData(PropertyModel property) async {

    final id = property.id;
    final url = Uri.parse(
        '${ApiEndPoints.baseurl}${ApiEndPoints.updatePropertyData}/${id}');
    print('api service');
    print(id);
    print(url);
    final request = http.MultipartRequest('PUT', url);
    
    // Convert the PropertyModel to JSON
    final propertyJson = property.toJson();

    // Add fields to the request
    request.fields['_id'] = property.id!;
    request.fields['agent'] = property.agent;
    request.fields['propertyName'] = property.propertyName;
    request.fields['propertyPrice'] = property.propertyPrice;
    request.fields['propertyCategory'] = property.propertyCategory;
    request.fields['propertyCity'] = property.propertyCity;
    request.fields['propertyState'] = property.propertyState ?? "";
    request.fields['propertyZip'] = property.propertyZip ?? "";
    request.fields['propertyDescription'] = property.propertyDescription ?? "";
    request.fields['longitude'] = property.longitude ?? "";
    request.fields['latitude'] = property.latitude ?? "";
    request.fields['isApproved'] = property.isApproved?.toString() ?? "false";
     // Upload property cover picture (if available)
    final propertyCoverPicture = property.propertyCoverPicture;
    if (propertyCoverPicture != null) {
      final imageStream = http.ByteStream(propertyCoverPicture.openRead());
      final imageLength = await propertyCoverPicture.length();

      final multipartFile = http.MultipartFile(
        'propertyCoverPicture',
        imageStream,
        imageLength,
        filename: 'cover_picture.jpg', // Change the filename as needed
        contentType:
            MediaType('image', 'jpeg'), // Adjust content type if necessary
      );

      request.files.add(multipartFile);
    }


    // Combine existing propertyGalleryPictures and newly added images
    final combinedGalleryPictures = <File>[];
    if (property.propertyGalleryPictures != null) {
      for (final xFile in property.propertyGalleryPictures!) {
        combinedGalleryPictures.add(File(xFile.path));
      }
    }
    if (property.newlyAddedGalleryPictures != null) {
      for (final xFile in property.newlyAddedGalleryPictures!) {
        combinedGalleryPictures.add(File(xFile.path));
      }
    }

   

    // Upload property gallery pictures (combined list)
    if (combinedGalleryPictures.isNotEmpty) {
      for (final galleryPicture in combinedGalleryPictures) {
        final imageStream = http.ByteStream(galleryPicture.openRead());
        final imageLength = await galleryPicture.length();

        final multipartFile = http.MultipartFile(
          'propertyGalleryPictures', // Use [] to represent an array
          imageStream,
          imageLength,
          filename: 'gallery_picture.jpg', // Change the filename as needed
          contentType:
              MediaType('image', 'jpeg'), // Adjust content type if necessary
        );

        request.files.add(multipartFile);
      }
    }

    // Serialize amenities as a JSON object and add it as a field
    // final amenitiesJson = jsonEncode(property.amenities);
    // request.fields['amenities'] = amenitiesJson;

    for (var i = 0; i < propertyJson['amenities'].length; i++) {
      request.fields['amenities[$i][amenityname]'] =
          propertyJson['amenities'][i]['amenityname'];
      request.fields['amenities[$i][amenityValue]'] =
          propertyJson['amenities'][i]['amenityValue'];
    }


    final response = await request.send();
    final responseString = await response.stream.bytesToString();
    return http.Response(responseString, response.statusCode);
  }
  Future<Map<String,dynamic>> deleteProperty(String? id) async {
    final uri = Uri.parse('${ApiEndPoints.baseurl}${ApiEndPoints.deletePropertyById}/$id');
    final propertyId = jsonEncode({'propertyId':id});
    print(uri);
    print(propertyId);
    final response = await http.delete(uri,headers: _headers,);
    print(response.body);
    return jsonDecode(response.body);
  }
  //Get All Property Data
  Future<Map<String, dynamic>> getAllProperties(String id) async {
    final vendorId = jsonEncode({'agent': id});
    print(vendorId);
    final url =
        Uri.parse('${ApiEndPoints.baseurl}${ApiEndPoints.getAllProperties}');
    final response = await http.post(url, headers: _headers, body: vendorId);
    print(response.body);
    return jsonDecode(response.body);
  }
}
