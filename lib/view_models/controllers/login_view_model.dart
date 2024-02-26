import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertify_for_agents/data/shared_preferences/shared_preferences.dart';
import 'package:propertify_for_agents/models/agent_model.dart';
import 'package:propertify_for_agents/repositories/login_repository/login_repository.dart';
import 'package:propertify_for_agents/services/api_services.dart';
import 'package:propertify_for_agents/utils/utils.dart';
import 'package:propertify_for_agents/view_models/controllers/agent_view_model.dart';
import 'package:propertify_for_agents/views/navigation/navigation.dart';

class LoginViewModel extends GetxController {
  //Api Instance For Login
  final _api = LoginRepository();
  //Login Phone Number Controller
  final phoneNumberController = TextEditingController().obs;
  //OTP Code Controller
  final smsCodeController = TextEditingController().obs;
  //Firebase Configuration
  final _auth = FirebaseAuth.instance;
  //Firebase Verification Id
  String verificationId = "";

  //Verify Phone Number if it exist in Server or Not
  void verifyPhoneNumber() async {
    try {
      final phoneNumber = phoneNumberController.value.text;
      final formattedPhoneNumber = '+91' + Utils.formatPhoneNumber(phoneNumber);
      Map data = {"mobNo": formattedPhoneNumber.toString()};
      await _api.checkAgentExistence(data).then((value) {
        Utils.snackBar('Agent Checking', 'Agent Exists Successful');
        if (value['exists']) {
          sendOtp(formattedPhoneNumber.toString());
        } else if (!value['exists']) {
          Utils.snackBar('Not Found', 'You are not an Agent');
        }
      }).onError((error, stackTrace) {
        Utils.snackBar('Error', error.toString());
      });
      print('123');
    } catch (e) {
      print("Error:$e");
    }
  }

  //Firebase Otp Generation
  sendOtp(String formattedPhoneNumber) async {
    await _auth.verifyPhoneNumber(
        phoneNumber: formattedPhoneNumber,
        timeout: Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          UserCredential userCredential =
              await _auth.signInWithCredential(credential);
          if (kDebugMode) {
            print("User Signed in:${userCredential.user?.phoneNumber}");
          }
          ;
          Get.toNamed('otp_verification', arguments: verificationId);
        },
        verificationFailed: (FirebaseAuthException e) {
          print("Verification failed: ${e.message}");
        },
        codeSent: (String verificationIdNew, int? resendToken) {
          verificationId = verificationIdNew;
          Get.toNamed('otp_verification', arguments: verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationIdNew) {
          verificationId = verificationIdNew;
        });
  }

  //Sign in using OTP
  void signInWithOTP(String verificationId) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCodeController.value.text,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final firebaseId = userCredential.user?.uid;
      String? agentPhone = userCredential.user?.phoneNumber.toString();
      final agentData = await ApiServices.instance.getAgentData(agentPhone);
      String agentVerifiedPhone = agentData['agent']['mobNo'];
      String agentId = agentData['agent']['_id'];
      String agentEmail = agentData['agent']['email'];
      String agentName = agentData['agent']['fullname'];

      await SharedPref.instance.sharedPref
          .setString(SharedPref.FirebaseId, firebaseId!);
      await SharedPref.instance.sharedPref
          .setString(SharedPref.agentId, agentId);
      await SharedPref.instance.sharedPref
          .setString(SharedPref.agentPhone, agentVerifiedPhone);
      await SharedPref.instance.sharedPref
          .setString(SharedPref.agentEmail, agentEmail);
      await SharedPref.instance.sharedPref
          .setString(SharedPref.agentName, agentName);

      print("User signed in: ${userCredential.user?.phoneNumber}");

      final agent = AgentModel.fromJson(agentData['agent']);

      await Get.find<AgentViewModel>().setAgent(agent);

      await Get.find<AgentViewModel>().getAgentProperties();

      Get.offUntil(
        GetPageRoute(page: () => NavigationItems()),
        (route) => false,
      );
    } catch (e) {
      print("Error: $e");
    }
  }

  void loginApi() {
    Map data = {
      'phone Number': '',
    };
    _api.loginApi(data).then((value) {
      Utils.snackBar('Login', 'Login Successfully');
    }).onError((error, stackTrace) {
      Utils.snackBar('Error', error.toString());
    });
  }
}
