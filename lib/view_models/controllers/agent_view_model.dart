import 'package:propertify_for_agents/models/agent_model.dart';
import 'package:get/get.dart';
import 'package:propertify_for_agents/models/property_model.dart';
import 'package:propertify_for_agents/repositories/agent_repository/agent_repository.dart';


class AgentViewModel extends GetxController {
  

  final _api = AgentRepository();

  late Rx<AgentModel> agent;
  List<Rx<PropertyModel>> agentProperties = [];

  // setProfileImage(String imagePath){
  //   profileImage=File(imagePath);
  //   update();
  // }


  //Set Agent
  setAgent(AgentModel agent) {
    this.agent = agent.obs;
  }
  
  // Get the agent ID
  String get agentId => agent.value.id;

  getAgentProperties() async {
    try {
      final agentId = agent.value.id;
      Map data = {"agent": agentId};
      final propertiesData =  await  _api.getAgentProperties(data).then((value) => value['properties']) as List;
      agentProperties = propertiesData.map((json) => PropertyModel.fromJson(json).obs).toList();

    } catch (e) {
      agentProperties=[];
    }
  }
}
