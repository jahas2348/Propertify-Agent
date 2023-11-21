import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertify_for_agents/models/request_model.dart';
import 'package:propertify_for_agents/repositories/agent_repository/agent_repository.dart';
import 'package:propertify_for_agents/resources/colors/app_colors.dart';
import 'package:propertify_for_agents/resources/components/toasts/custom_toast.dart';
import 'package:propertify_for_agents/view_models/controllers/agent_view_model.dart';

class NotificationViewModel extends GetxController {
  final _api = AgentRepository();
  final agentViewModel = Get.find<AgentViewModel>();

  String get agentId => agentViewModel.agentId;

  List<Rx<RequestModel>> agentRequests = [];
  RxBool isLoading = true.obs; // Add isLoading variable
 // Add isLoading variable

  @override
  void onInit() {
    super.onInit();
    getAgentRequests();
  }

  // Get Agent Requests
getAgentRequests() async {
  try {
    final agent = agentId;
    isLoading.value = true; // Set loading state to true
    await Future.delayed(Duration(seconds: 2)); // Add a 2-second delay
    final agentRequestsData = await _api.getAgentRequests(agent).then((value) => value['requests']) as List;
    agentRequests = agentRequestsData.map((json) => RequestModel.fromJson(json).obs).toList();
    print(agentRequests);
  } catch (e) {
    print(e);
    agentRequests = [];
  } finally {
    isLoading.value = false; // Set loading state to false when done
  }
}


sendPaymentRequest(var data,BuildContext context) async {
  try {
    final sendPaymentresponse = await _api.sendPaymentRequest(data);
    if(sendPaymentresponse['status']=='success'){
      showCustomToast(context, '${sendPaymentresponse['message']}');
    }else{
      showCustomToast(context, '${sendPaymentresponse['message']}', AppColors.alertColor);
    }
    
    
  } catch (e) {
    
  }
  
}

}
