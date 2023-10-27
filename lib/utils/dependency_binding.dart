import 'package:get/get.dart';
import 'package:propertify_for_agents/view_models/controllers/agent_view_model.dart';
import 'package:propertify_for_agents/view_models/controllers/property_view_model.dart';

class InitController extends Bindings {
  @override
  void dependencies(){

    // Get.put<PropertyViewModel>(PropertyViewModel(),permanent: true);
    
    Get.put<AgentViewModel>(AgentViewModel(), permanent: true);
    // Get.put<PropertyViewModel>(PropertyViewModel(),permanent: true);
  }
}