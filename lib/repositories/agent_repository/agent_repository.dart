import 'package:propertify_for_agents/data/network/network_api_services.dart';
import 'package:propertify_for_agents/resources/app_urls/app_urls.dart';

class AgentRepository {

  final _apiService = NetworkApiServices();

  Future<Map<String,dynamic>> getAgentProperties (var data) async {
    dynamic response = await _apiService.postApi(data, AppUrl.getAllProperties);
    return response;
  }

  Future<Map<String,dynamic>> getAgentRequests (var agentId) async {
    print('ccc');
    dynamic response = await _apiService.getApi('${AppUrl.getAllRequestsofAgent}/$agentId');
    return response;
  }

  Future<Map<String,dynamic>> sendPaymentRequest (var data) async {
   
    dynamic response = await _apiService.postApi(data,AppUrl.sendPaymentRequesttoUser);
    return response;
  }

}