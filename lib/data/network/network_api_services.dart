import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:propertify_for_agents/data/exceptions/app_exceptions.dart';
import 'package:propertify_for_agents/data/network/base_api_services.dart';
import 'package:http/http.dart' as http;
import 'package:propertify_for_agents/models/property_model.dart';
import 'package:propertify_for_agents/resources/app_urls/app_urls.dart';

class NetworkApiServices extends BaseApiServices {
  @override
  final _headers = {'Content-Type': 'application/json'};

  Future<dynamic> getApi(String url) async {
    if (kDebugMode) {
      print(url);
    }
    dynamic responseJson;
    try {
      final response = await http
          .get(Uri.parse(url), headers: _headers)
          .timeout(Duration(seconds: 20));
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException(message: '');
    } on RequestTimeOut {
      throw RequestTimeOut(message: '');
    }
    return responseJson;
  }

  @override
  Future<dynamic> postApi(var data, String url) async {
    if (kDebugMode) {
      print(url);
      print(data);
    }
    dynamic responseJson;
    try {
      final response = await http
          .post(Uri.parse(url), body: jsonEncode(data), headers: _headers)
          .timeout(Duration(seconds: 10));
      responseJson = returnResponse(response);
      print('here');
      print(responseJson);
    } on SocketException {
      throw InternetException(message: '');
    } on RequestTimeOut {
      throw RequestTimeOut(message: '');
    }
    return responseJson;
  }

  Future<http.MultipartRequest> createMultipartRequest(
      PropertyModel property) async {
    final url = Uri.parse(AppUrl.addPropertyData);
    final request = http.MultipartRequest('POST', url);

    // Convert the PropertyModel to JSON
    final propertyJson = property.toJson();

    request.fields['agent'] = property.agent;
    request.fields['propertyName'] = property.propertyName;
    request.fields['propertyPrice'] = property.propertyPrice;
    request.fields['propertyCategory'] = property.propertyCategory;
    request.fields['propertyCity'] = property.propertyCity;
    request.fields['propertyState'] = property.propertyState ?? '';
    request.fields['propertyZip'] = property.propertyZip ?? '';
    request.fields['propertyDescription'] = property.propertyDescription ?? '';
    request.fields['longitude'] = property.longitude ?? '';
    request.fields['latitude'] = property.latitude ?? '';
    request.fields['isApproved'] = property.isApproved?.toString() ?? 'false';

    if (property.propertyCoverPicture != null) {
      final imageStream =
          http.ByteStream(property.propertyCoverPicture!.openRead());
      final imageLength = await property.propertyCoverPicture!.length();

      final multipartFile = http.MultipartFile(
        'propertyCoverPicture',
        imageStream,
        imageLength,
        filename: 'cover_picture.jpg', // Change the filename as needed
      );

      request.files.add(multipartFile);
    }

    if (property.propertyGalleryPictures != null &&
        property.propertyGalleryPictures!.isNotEmpty) {
      for (final galleryPicture in property.propertyGalleryPictures!) {
        final imageStream = http.ByteStream(galleryPicture.openRead());
        final imageLength = await galleryPicture.length();

        final multipartFile = http.MultipartFile(
          'propertyGalleryPictures[]', // Use [] to represent an array
          imageStream,
          imageLength,
          filename: 'gallery_picture.jpg', // Change the filename as needed
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

    return request;
  }

  Future<http.Response> sendMultipartRequest(
      http.MultipartRequest request) async {
    final response = await request.send();
    final responseString = await response.stream.bytesToString();
    return http.Response(responseString, response.statusCode);
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw InvalidExcemption;
      default:
        throw FetchDataExcemption(
            message: 'Error Occured While Communicating with Server');
    }
  }
}
