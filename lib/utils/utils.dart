import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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

  static String formatPhoneNumber(String phoneNumber) {
    final numericPhoneNumber = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
    return numericPhoneNumber;
  }

  static String formatPrice(dynamic price) {
    final formatter =
        NumberFormat.currency(locale: 'en_IN', symbol: '₹', decimalDigits: 2);
    if (price is int || price is double || price is String) {
      try {
        final doublePrice = double.parse(price.toString());
        String formatted = formatter.format(doublePrice).toString();
        if (formatted.endsWith('.00')) {
          return formatted.substring(0,
              formatted.length - 3); // Remove the last three characters (.00)
        }
        return formatted;
      } catch (e) {
        return 'Invalid amount';
      }
    } else {
      return 'Invalid amount type';
    }
  }
}
