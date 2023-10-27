import 'package:propertify_for_agents/data/network/network_api_services.dart';
import 'package:propertify_for_agents/resources/app_urls/app_urls.dart';

class LoginRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> loginApi(var data) async {
    dynamic response = _apiService.postApi(data, AppUrl.loginApi);
    return response;
  }

  //Check Agent Existence
  Future<Map<String, dynamic>> checkAgentExistence(var data) async {
    dynamic response = await _apiService.postApi(data, AppUrl.agentExistence);
    return response;
  }
}
