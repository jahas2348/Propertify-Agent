import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertify_for_agents/models/payment_request_sending_model.dart';
import 'package:propertify_for_agents/resources/app_urls/app_urls.dart';
import 'package:propertify_for_agents/resources/colors/app_colors.dart';
import 'package:propertify_for_agents/resources/components/buttons/custombuttons.dart';
import 'package:propertify_for_agents/resources/components/iconbox/customIconBox.dart';
import 'package:propertify_for_agents/resources/components/input_fileds/custom_Input_Fields.dart';
import 'package:propertify_for_agents/resources/components/toasts/custom_toast.dart';
import 'package:propertify_for_agents/resources/constants/spaces%20&%20paddings/paddings.dart';
import 'package:propertify_for_agents/resources/constants/spaces%20&%20paddings/spaces.dart';
import 'package:propertify_for_agents/resources/fonts/app_fonts/app_fonts.dart';
import 'package:propertify_for_agents/view_models/controllers/notification_view_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../models/request_model.dart';
import '../../resources/components/card_widgets/propertyCards/home_page_single_card.dart';
import '../chat_screen/chat_single_screen.dart';

class NotificationSingleScreen extends StatefulWidget {
  Rx<RequestModel> request;
  NotificationSingleScreen({super.key, required this.request});

  @override
  State<NotificationSingleScreen> createState() =>
      _NotificationSingleScreenState();
}

class _NotificationSingleScreenState extends State<NotificationSingleScreen> {
  // late NotificationViewModel notificationController;
  startChat(BuildContext context) async {
    // Establish a Socket.io connection with the server

    // Navigate to ChatSingleScreen and pass the request and socket
    Get.to(ChatSingleScreen(
      request: widget.request,
    ));
  }

  @override
  Widget build(BuildContext context) {
    print(widget.request.toJson());
    String firstLetter =
        widget.request.value.user?.username?[0].toUpperCase() ?? '';
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customSpaces.verticalspace20,
            Padding(
              padding: customPaddings.horizontalpadding20,
              child: Row(
                children: [
                  CustomIconBox(
                      boxheight: 40,
                      boxwidth: 40,
                      boxIcon: Icons.arrow_back,
                      radius: 8,
                      boxColor: Colors.grey.shade300,
                      iconSize: 20),
                  customSpaces.horizontalspace20,
                  Text(
                    widget.request.value.user!.username ?? 'User',
                    style: AppFonts.SecondaryColorText20,
                  ),
                ],
              ),
            ),
            customSpaces.verticalspace20,
            Padding(
              padding: customPaddings.horizontalpadding20,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          child: Text(
                            firstLetter,
                            style: AppFonts.WhiteColorText14Bold,
                          ),
                        ),
                        customSpaces.horizontalspace10,
                        Text(
                          widget.request.value.property!.propertyName,
                          style: AppFonts.SecondaryColorText14,
                        ),
                        customSpaces.verticalspace20,
                      ],
                    ),
                    customSpaces.verticalspace10,
                    homePageCardSingle(
                      cardHeight: 200,
                      property: widget.request.value.property!.obs,
                    ),
                    customSpaces.verticalspace10,
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: CustomColorButton(
                              buttonText: 'Decline',
                              buttonFunction: () {},
                              buttonColor: Colors.red,
                            ),
                          ),
                        ),
                        customSpaces.horizontalspace10,
                        Expanded(
                          child: Container(
                            child: CustomColorButton(

                              buttonText: 'Accept',
                              buttonFunction: () async {
                                await startChat(context);
                              },
                              buttonColor: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                    customSpaces.verticalspace10,
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: CustomColorButton(
                              buttonText: 'Send Payment Info',
                              buttonFunction: () {
                                _showTagBottomSheet(context);
                              },
                              buttonColor: AppColors.primaryColor,
                            ),
                          ),
                        ),
                       
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _showTagBottomSheet(BuildContext context) {
   
    TextEditingController priceController = TextEditingController();

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                
                CustomInputField(
                  fieldIcon: Icons.tag,
                controller: priceController,
                 hintText: 'Please enter Price',
                ),
                customSpaces.verticalspace10,
                Row(
                  children: [
                    Expanded(
                      child: PrimaryButton(
                        buttonText: 'Send',
                        buttonFunction: () async {
                          
                          final newPrice = priceController.text;
                          if (newPrice.isEmpty) {
                            showCustomToast(context, 'Price cannot be empty',AppColors.alertColor);
                          }
                          if(newPrice.isNotEmpty){
                            PaymentRequestSendingModel payment = PaymentRequestSendingModel (
                              agent: widget.request.value.agent,
                              user: widget.request.value.user!.id,
                              property: widget.request.value.property!.id!,
                              paymentAmount: newPrice,

                            );
                            
                            print(payment.toJson());
                            Get.find<NotificationViewModel>().sendPaymentRequest(payment,context);
                        
                          }
                          
                         
                          
                        },
                       
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
