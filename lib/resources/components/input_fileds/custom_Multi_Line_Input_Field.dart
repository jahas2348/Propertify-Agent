import 'package:flutter/material.dart';
import 'package:propertify_for_agents/resources/colors/app_colors.dart';
import 'package:propertify_for_agents/resources/constants/spaces%20&%20paddings/spaces.dart';

// ignore: must_be_immutable


class CustomMultiLineInputField extends StatefulWidget {
  final IconData? fieldIcon;
  final String hintText;
  final int? maxLines;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  CustomMultiLineInputField({
    Key? key,
    this.fieldIcon,
    required this.hintText,
    this.maxLines,
    this.controller,
    this.keyboardType,
    this.validator,
  }) : super(key: key);

  @override
  _CustomMultiLineInputFieldState createState() =>
      _CustomMultiLineInputFieldState();
}

class _CustomMultiLineInputFieldState extends State<CustomMultiLineInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.fromLTRB(10, 5, 10, 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              customSpaces.horizontalspace10,
              Expanded(
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: widget.controller,
                  validator: widget.validator,
                  keyboardType: widget.keyboardType,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.secondaryColor,
                  ),
                  maxLines: 10,
                  maxLength: 512, // Set the maximum character limit
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    hintStyle: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
          // Align(
          //   alignment: Alignment.topRight,
          //   child: Text(
          //     '${widget.controller?.text.length ?? 0}/512', // Display character count
          //     style: TextStyle(
          //       color: Colors.grey,
          //       fontSize: 12,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
