import 'package:get/get.dart';
import 'package:propertify_for_agents/data/network/network_api_services.dart';
import 'package:propertify_for_agents/data/shared_preferences/shared_preferences.dart';
import 'package:propertify_for_agents/models/agent_model.dart';
import 'package:propertify_for_agents/resources/app_urls/app_urls.dart';
import 'package:propertify_for_agents/services/api_services.dart';
import 'package:propertify_for_agents/view_models/controllers/agent_view_model.dart';
import 'package:propertify_for_agents/view_models/controllers/notification_view_model.dart';
import 'package:propertify_for_agents/views/navigation/navigation.dart';
import 'package:propertify_for_agents/views/welcome_screen/welcome_screen.dart';

class AgentRepository {

  final _apiService = NetworkApiServices();

  static void validateAgent() async {

    final agentPhone = await SharedPref.instance.getAgent();
    if (agentPhone != null) {
      try {
        final agentData = await ApiServices.instance.getAgentData(agentPhone);
        if (!agentData['status']) {
          Get.off(()=> WelcomeScreen());
        } else {
          final agent = AgentModel.fromJson(agentData['agent']);
          await Get.find<AgentViewModel>().setAgent(agent);     
          await Get.find<AgentViewModel>().getAgentProperties();
          await Get.find<NotificationViewModel>().getAgentRequests();
          AgentViewModel().update();
          Get.off(()=>NavigationItems());
        }
      } catch (e) {
        Get.off(()=> WelcomeScreen());
      }
    } else {
      Get.off(()=> WelcomeScreen());
    }
  }


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