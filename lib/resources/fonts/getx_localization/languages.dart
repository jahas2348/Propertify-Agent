import 'package:get/get_navigation/src/root/internacionalization.dart';

class Languages extends Translations {

  @override
  Map<String, Map<String, String>> get keys => {
    'en_US' :{
      'email_hint' : 'Enter Email',
      'internet_exception' : "we're unable to show results\n Please check your data\n connection",
    },
  };
}