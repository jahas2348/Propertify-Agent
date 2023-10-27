import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:propertify_for_agents/resources/colors/app_colors.dart';

class Utils {
  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static toastMessage(String Message) {
    Fluttertoast.showToast(
      msg: Message,
      backgroundColor: AppColors.blackColor,
      gravity: ToastGravity.BOTTOM,  
    );
  }

  static toastMessageCenter(String Message) {
    Fluttertoast.showToast(
      msg: Message,
      backgroundColor: AppColors.blackColor,
      gravity: ToastGravity.CENTER,  
    );
  }

  static snackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
    );
  }
  static String formatPhoneNumber (String phoneNumber){
    final numericPhoneNumber = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
    return numericPhoneNumber;
  }

}
