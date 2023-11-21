import 'package:propertify_for_agents/models/agent_model.dart';
import 'package:get/get.dart';
import 'package:propertify_for_agents/models/property_model.dart';
import 'package:propertify_for_agents/repositories/agent_repository/agent_repository.dart';


class AgentViewModel extends GetxController {
  

  final _api = AgentRepository();

  late Rx<AgentModel> agent;
  List<Rx<PropertyModel>> agentProperties = [];
  List<Rx<PropertyModel>> unsoldagentProperties = [];
  List<Rx<PropertyModel>> soldagentProperties = [];

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
      print("newwwwww");
      print(propertiesData);
      agentProperties = await propertiesData.map((json) => PropertyModel.fromJson(json).obs).toList();
      unsoldagentProperties = await agentProperties.where((element) => element.value.isSold! ==false).toList();
      soldagentProperties = await agentProperties.where((element) => element.value.isSold! ==true).toList();
      print('nooooo');
      print(agentProperties);
       print('Yes');


    } catch (e) {
      print(e);
      agentProperties=[];
    }
  }
//   Future<void> getAgentProperties() async {
//   try {
//     final agentId = agent.value.id;
//     Map<String, dynamic> data = {"agent": agentId};
//     final propertiesData = await _api.getAgentProperties(data);
//     final propertiesList = propertiesData['properties'] as List;

//     // Clear the existing agentProperties list before adding new properties
//     agentProperties.clear();

//     agentProperties.addAll(propertiesList.map((json) {
//       final property = PropertyModel.fromJson(json);
//       return property.obs;
//     }));

//     // Notify listeners that the agentProperties list has changed
//     update();
//   } catch (e) {
//     agentProperties.clear();
//     update(); // Notify listeners even if there are no properties
//   }
// }

}
