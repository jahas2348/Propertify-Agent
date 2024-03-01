import 'dart:convert';
import 'dart:io';
import 'package:propertify_for_agents/models/property_model.dart';
import 'package:propertify_for_agents/resources/app_urls/app_urls.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ApiServices {
  ApiServices._();
  static final _instance = ApiServices._();
  static ApiServices get instance => _instance;
  final _headers = {'Content-Type': 'application/json'};

  //Get Agent Data
  Future<Map<String, dynamic>> getAgentData(String? agentPhone) async {
    final url = Uri.parse('${AppUrl.getAgent}');
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
    final url = Uri.parse('${AppUrl.baseUrl}${AppUrl.agentExistence}');
    final requestBody = jsonEncode({"mobNo": formattedPhoneNumber});
    final response = await http.post(url, headers: _headers, body: requestBody);
    final agentPhone = jsonDecode(response.body);
    print('123');
    print(agentPhone);
    return agentPhone;
  }

  //Add Property Data
  Future<http.Response> addPropertyData(PropertyModel property) async {
    final url = Uri.parse('${AppUrl.addPropertyData}');
    final request = http.MultipartRequest('POST', url);

    // Convert the PropertyModel to JSON
    final propertyJson = property.toJson();

    // Add fields to the request
    request.fields['agent'] = property.agent;

    request.fields['propertyName'] = property.propertyName;
    request.fields['propertyRooms'] = property.propertyRooms ?? '';
    request.fields['propertyBathrooms'] = property.propertyBathrooms ?? '';
    request.fields['propertySqft'] = property.propertySqft ?? '';
    request.fields['propertyPrice'] = property.propertyPrice;
    request.fields['propertyCategory'] = property.propertyCategory;
    request.fields['propertyCity'] = property.propertyCity;
    request.fields['propertyState'] = property.propertyState ?? "";
    request.fields['propertyZip'] = property.propertyZip ?? "";
    request.fields['propertyDescription'] = property.propertyDescription ?? "";
    request.fields['longitude'] = property.longitude ?? "";
    request.fields['latitude'] = property.latitude ?? "";
    request.fields['isApproved'] = property.isApproved?.toString() ?? "false";
    request.fields['isSold'] = property.isSold?.toString() ?? "false";

    // Add amenities and tags as fields with unique keys
    if (property.amenities != null) {
      for (var i = 0; i < property.amenities!.length; i++) {
        request.fields['amenities[$i]'] = property.amenities![i];
      }
    }

    if (property.tags != null) {
      for (var i = 0; i < property.tags!.length; i++) {
        request.fields['tags[$i]'] = property.tags![i];
      }
    }

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
    contentType: MediaType('image', 'jpeg'), // Adjust content type if necessary
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

    final response = await request.send();
    final responseString = await response.stream.bytesToString();
    print(response.statusCode);
    return http.Response(responseString, response.statusCode);
  }

  Future<http.Response> updatePropertyData(PropertyModel property) async {
    final id = property.id;
    final url = Uri.parse('${AppUrl.updatePropertyData}/$id');
    final request = http.MultipartRequest('PUT', url);

    // Add fields to the request
    request.fields['_id'] = property.id!;
    request.fields['agent'] = property.agent;
    request.fields['propertyName'] = property.propertyName;
    request.fields['propertyCategory'] = property.propertyCategory;
    request.fields['longitude'] = property.longitude ?? "";
    request.fields['latitude'] = property.latitude ?? "";
    request.fields['propertyRooms'] = property.propertyRooms ?? "";
    request.fields['propertyBathrooms'] = property.propertyBathrooms ?? "";
    request.fields['propertySqft'] = property.propertySqft ?? "";
    request.fields['propertyPrice'] = property.propertyPrice;
    request.fields['propertyCity'] = property.propertyCity;
    request.fields['propertyState'] = property.propertyState ?? "";
    request.fields['propertyZip'] = property.propertyZip ?? "";
    request.fields['propertyDescription'] = property.propertyDescription ?? "";

    // Add amenities and tags as fields with unique keys
    if (property.amenities != null) {
      for (var i = 0; i < property.amenities!.length; i++) {
        request.fields['amenities[$i]'] = property.amenities![i];
      }
    }
    if (property.tags != null) {
      for (var i = 0; i < property.tags!.length; i++) {
        request.fields['tags[$i]'] = property.tags![i];
      }
    }
    if (property.removedImageUrls != null) {
      // Convert removedImageUrls to a comma-separated string
      final removedImageUrlsString = property.removedImageUrls!.join(',');
      request.fields['removedImageUrls'] = removedImageUrlsString;
    }

    // Upload property cover picture (if available)
    if (property.updatedCoverPicture != null) {
      final imageStream =
          http.ByteStream(property.updatedCoverPicture!.openRead());
      final imageLength = await property.updatedCoverPicture!.length();

      final multipartFile = http.MultipartFile(
        'updatedCoverPicture',
        imageStream,
        imageLength,
        filename: 'cover_picture.jpg',
        contentType: MediaType('image', 'jpeg'),
      );

      request.files.add(multipartFile);
    }

    // Upload property gallery pictures (if available)
    final newGalleryPictures = property.newGalleryPictures;
    if (newGalleryPictures != null && newGalleryPictures.isNotEmpty) {
      for (final galleryPicture in newGalleryPictures) {
        final imageBytes = await File(galleryPicture.path).readAsBytes();
        final multipartFile = http.MultipartFile.fromBytes(
          'newGalleryPictures',
          imageBytes,
          filename:
              galleryPicture.path.split('/').last, // Extract filename from path
          contentType: MediaType('image', 'jpeg'),
        );
        request.files.add(multipartFile);
      }
    }
    final response = await request.send();
    final responseString = await response.stream.bytesToString();
    return http.Response(responseString, response.statusCode);
  }

  Future<Map<String, dynamic>> deleteProperty(String? id) async {
    final uri = Uri.parse('${AppUrl.deletePropertyById}/$id');
    final propertyId = jsonEncode({'propertyId': id});
    print(uri);
    print(propertyId);
    final response = await http.delete(
      uri,
      headers: _headers,
    );
    print(response.body);
    return jsonDecode(response.body);
  }

  //Get All Property Data
  Future<Map<String, dynamic>> getAllProperties(String id) async {
    final vendorId = jsonEncode({'agent': id});
    print(vendorId);
    final url = Uri.parse('${AppUrl.baseUrl}${AppUrl.getAllProperties}');
    final response = await http.post(url, headers: _headers, body: vendorId);
    print(response.body);
    return jsonDecode(response.body);
  }
}
