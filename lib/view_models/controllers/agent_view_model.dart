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
  RxString approvedCount = ''.obs;
  RxString notApprovedCount = ''.obs;
  RxString soldCount = ''.obs;
  RxString totalAmountSold = ''.obs;
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

  //Get Agent Properies
  getAgentProperties() async {
    try {
      final agentId = agent.value.id;
      Map data = {"agent": agentId};
      final propertiesData = await _api
          .getAgentProperties(data)
          .then((value) => value['properties']) as List;
      agentProperties = await propertiesData
          .map((json) => PropertyModel.fromJson(json).obs)
          .where((element) => element.value.isApproved == true)
          .toList();
      unsoldagentProperties = await agentProperties
          .where((element) => element.value.isSold! == false)
          .toList();
      soldagentProperties = await agentProperties
          .where((element) => element.value.isSold! == true)
          .toList();
    } catch (e) {
      print(e);
      agentProperties = [];
    }
  }

  //Get All Properties Info of Agent
  getAllPropertiesInfoofAgent() async {
    try {
      final agentId = agent.value.id;
      final propertiesInfo = await _api.getAllPropertiesInfoOfAgent(agentId);

      if (propertiesInfo['status'] == 'success') {
        approvedCount.value = propertiesInfo['approvedCount'].toString();
        notApprovedCount.value = propertiesInfo['notApprovedCount'].toString();
        soldCount.value = propertiesInfo['soldCount'].toString();
        totalAmountSold.value = propertiesInfo['totalAmountSold'].toString();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateData() async {
    try {
      await getAllPropertiesInfoofAgent();
      await getAgentProperties();
      update();
      // This triggers a UI update
    } catch (e) {
      print(e);
    }
  }
  // Future<void> loaddata() async {
  //   await getAgentProperties();
  //   await getAllPropertiesInfoofAgent();
  //   AgentViewModel().update();
  // }
}
