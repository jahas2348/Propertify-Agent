import 'package:http/http.dart' as http;
import 'package:propertify_for_agents/data/network/network_api_services.dart';
import 'package:propertify_for_agents/models/property_model.dart';

class PropertyRepository {
  final NetworkApiServices _apiService = NetworkApiServices();

  Future<dynamic> addPropertyData(PropertyModel property) async {
    try {
      final request = await _apiService.createMultipartRequest(property);
      final response = await _apiService.sendMultipartRequest(request);

      if (response.statusCode == 200) {
        // Property uploaded successfully
        return response.body;
      } else {
        print('Error uploading property: ${response.reasonPhrase}');
        throw Exception('Error uploading property');
      }
    } catch (e) {
      print('Error: $e');
      throw e;
    }
  }
}
