import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  SharedPref._();
  static final SharedPref _instance = SharedPref._();
  static SharedPref get instance => _instance;

  static const String FirebaseId = 'FirebaseId';
  static const String agentId = 'vendorId';
  static const String agentEmail = 'vendorEmail';
  static const String agentPhone = 'vendorPhone';
  static const String agentName = 'agentName';

  late SharedPreferences sharedPref;
  initStorage() async {
    sharedPref = await SharedPreferences.getInstance();
  }

  //getAgent
  Future<String?> getAgent() async {
    final agent = await sharedPref.getString(agentPhone);
    return agent;
  }
}
