class AppUrl {
  //Base
  static const String baseUrl = 'http://10.4.3.252:3000';
  //Login
  static const String loginApi = '';
  //Agent Existence
  static const String agentExistence= '$baseUrl/api/agent/checkAgentPhoneNumber';
  //Get Agent
  static const String getAgent = '$baseUrl/api/agent/getAgent';
  //Add Property Data
  static const String addPropertyData = '$baseUrl/api/admin/addPropertyData';
  //Update Property Data
  static const String updatePropertyData = '$baseUrl/api/admin/updateProperty';
  //Get All Properties
  static const String getAllProperties = '$baseUrl/api/agent/getAllProperties';
  //Delete Property
  static const String deletePropertyById = '$baseUrl/api/admin/deleteProperty';
  //Get All Requests
  static const String getAllRequestsofAgent = '$baseUrl/api/agent/getAllRequestsofAgent';
  //Send Payment Request to User
  static const String sendPaymentRequesttoUser = '$baseUrl/api/agent/PaymentRequesttoUser';
  
  
}