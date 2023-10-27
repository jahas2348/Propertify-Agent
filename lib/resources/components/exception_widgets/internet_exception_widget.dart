import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertify_for_agents/resources/colors/app_colors.dart';
class InternetExceptionWidget extends StatefulWidget {
  const InternetExceptionWidget({super.key});

  @override
  State<InternetExceptionWidget> createState() =>
      _InternetExceptionWidgetState();
}

class _InternetExceptionWidgetState extends State<InternetExceptionWidget> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Icon(Icons.cloud_off, color: AppColors.blackColor, size: 50,),
          Padding(
            padding: const EdgeInsets.only(top:30 ),
            child: Center(child: Text('internet_exception'.tr)),
          ),
          SizedBox(height: height * .15 ,),
          Container(
            height: 44,
            width:160 ,
            decoration: BoxDecoration(
              color: AppColors.blackColor,
            ),
            child: Center(child: Text('Retry',
            //style: Theme.of(context).textTheme.titleLarge,
            ),
            ),
          ),
        ],
      ),
    );
  }
}
