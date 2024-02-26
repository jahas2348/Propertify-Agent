import 'dart:convert';
import 'package:propertify_for_agents/views/inbox_screen/chat_model.dart';
import 'package:propertify_for_agents/views/inbox_screen/chat_single_screen.dart';
import 'package:propertify_for_agents/views/inbox_screen/inbox_screen.dart';
import 'package:propertify_for_agents/views/inbox_screen/socket_manager.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
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
import '../../models/request_model.dart';
import '../../resources/components/card_widgets/propertyCards/home_page_single_card.dart';

class NotificationSingleScreen extends StatefulWidget {
  Rx<RequestModel> request;
  NotificationSingleScreen({super.key, required this.request});

  @override
  State<NotificationSingleScreen> createState() =>
      _NotificationSingleScreenState();
}

class _NotificationSingleScreenState extends State<NotificationSingleScreen> {
  late IO.Socket socket;
  @override
  void initState() {
    super.initState();
    socket = SocketManager().socket;
    socket.on('newChatEntry', handleNewChatEntry);
  }

  void handleNewChatEntry(dynamic data) {
    print('Received new chat entry: $data');
    if (data is List) {
      setState(() {
        SocketManager()
            .chatEntries
            .addAll(data.map((item) => ChatEntry.fromJson(item)));
      });

      if (SocketManager().chatEntries.isNotEmpty) {
        print('Navigating to Chat Screen...');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ChatScreen(chatEntryId: SocketManager().chatEntries.last.id),
          ),
        );
      } else {
        print('Error: No chat entry created.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.request.toJson());
    String firstLetter =
        widget.request.value.user?.username?[0].toUpperCase() ?? '';
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
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
                      iconFunction: () {
                        Get.back();
                      },
                      boxheight: 40,
                      boxwidth: 40,
                      boxIcon: Icons.arrow_back,
                      radius: 8,
                      boxColor: Colors.white,
                      iconSize: 20),
                  customSpaces.horizontalspace20,
                  Text(
                    widget.request.value.user!.username ?? 'User',
                    style: AppFonts.SecondaryColorText20,
                  ),
                ],
              ),
            ),
            customSpaces.verticalspace10,
            Divider(),
            customSpaces.verticalspace10,
            Padding(
              padding: customPaddings.horizontalpadding20,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
                        CircleAvatar(
                          backgroundColor: Colors.red.shade100,
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.close,
                                size: 18,
                                color: Colors.red.shade900,
                              )),
                        ),
                        customSpaces.horizontalspace10,
                        CircleAvatar(
                          backgroundColor: Colors.green.shade100,
                          child: IconButton(
                              onPressed: () async {
                                socket.emit('createChatEntry');
                                //          Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) =>
                                //         ChatScreen(chatEntryId:  SocketManager().chatEntries[index].id),
                                //   ),
                                // );
                              },
                              icon: Icon(
                                Icons.check,
                                size: 18,
                                color: Colors.green.shade900,
                              )),
                        ),
                        customSpaces.horizontalspace10,
                        Expanded(
                          child: Container(
                            child: CustomColorButton(
                              buttonText: 'Send Payment Info',
                              buttonFunction: () {
                                _showCustomPriceBottomSheet(context);
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

  void _showCustomPriceBottomSheet(BuildContext context) {
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
                  fieldIcon: Icons.currency_rupee_outlined,
                  controller: priceController,
                  hintText: 'Enter Your Custom Price',
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
                            showCustomToast(context, 'Price cannot be empty',
                                AppColors.alertColor);
                          }
                          if (newPrice.isNotEmpty) {
                            PaymentRequestSendingModel payment =
                                PaymentRequestSendingModel(
                              agent: widget.request.value.agent,
                              user: widget.request.value.user!.id,
                              property: widget.request.value.property!.id!,
                              paymentAmount: newPrice,
                            );

                            print(payment.toJson());
                            Get.find<NotificationViewModel>()
                                .sendPaymentRequest(payment, context);
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
