import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:propertify_for_agents/resources/colors/app_colors.dart';
import 'package:propertify_for_agents/resources/constants/spaces%20&%20paddings/spaces.dart';

// ignore: must_be_immutable
class CustomInputFieldOtp extends StatelessWidget {
  TextEditingController? controller;
  CustomInputFieldOtp({
    super.key,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: Row(
        children: [
          customSpaces.horizontalspace10,
          Expanded(
            child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.number,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.secondaryColor,
              ),
              decoration: InputDecoration(
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  border: InputBorder.none),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class MobileInputField extends StatelessWidget {
  TextEditingController? controller;

  MobileInputField({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: Row(
        children: [
          Container(child: Flag(Flags.india)),
          customSpaces.horizontalspace10,
          Text(
            '+91',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppColors.secondaryColor,
            ),
          ),
          customSpaces.horizontalspace10,
          Expanded(
            child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.phone,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.secondaryColor,
              ),
              decoration: InputDecoration(
                  hintText: 'Enter your phone number',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  border: InputBorder.none),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
// class CustomInputField extends StatefulWidget {
//   final IconData? fieldIcon;
//   final String hintText;
//   final int? maxLines;
//   final TextEditingController? controller;
//   final TextInputType? keyboardType;
//   final String? Function(String?)? validator;

//   CustomInputField({
//     Key? key,
//     this.fieldIcon,
//     required this.hintText,
//     this.maxLines,
//     this.controller,
//     this.keyboardType,
//     this.validator,
//   }) : super(key: key);

//   @override
//   _CustomInputFieldState createState() => _CustomInputFieldState();
// }

// class _CustomInputFieldState extends State<CustomInputField> {
//   String? errorText;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.grey),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
//           child: Row(
//             children: [
//               customSpaces.horizontalspace10,
//               Icon(widget.fieldIcon ?? null, color: Colors.grey.shade500, size: 24,),
//               customSpaces.horizontalspace10,
//               Expanded(
//                 child: TextFormField(
//                   validator: widget.validator,
//                   onChanged: (value) {
//                     setState(() {
//                       errorText = widget.validator?.call(value);
//                     });
//                   },
//                   controller: widget.controller,
//                   keyboardType: widget.keyboardType,
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.secondaryColor,
//                   ),
//                   maxLines: widget.maxLines ?? 1,
//                   decoration: InputDecoration(
//                     hintText: widget.hintText,
//                     hintStyle: TextStyle(
//                       color: Colors.grey.shade400,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                     ),
//                     border: InputBorder.none,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         if (errorText != null)
//           Row(
//             children: [
//               customSpaces.horizontalspace10, // You can adjust the spacing
//               Text(
//                 errorText!,
//                 style: TextStyle(color: Colors.red), // You can style the error message
//               ),
//             ],
//           ),
//       ],
//     );
//   }
// }

class CustomInputField extends StatelessWidget {
  final IconData? fieldIcon;
  final String hintText;
  final int? maxLines;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool? editable;

  CustomInputField({
    Key? key,
    this.fieldIcon,
    required this.hintText,
    this.maxLines,
    this.controller,
    this.keyboardType,
    this.validator,
    this.editable,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textAlignVertical: TextAlignVertical.center,
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      maxLines: maxLines,
      readOnly: !(editable ?? true), // Updated this line
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.grey.shade600,
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(
          fieldIcon ?? null,
          color: Colors.grey.shade500,
          size: 20,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey.shade400,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            color: Colors.black,
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            color: Colors.red,
            width: 1,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            color: Colors.red,
            width: 1,
          ),
        ),
      ),
    );
  }
}


class CustomInputField1 extends StatefulWidget {
  final String hintText;
  final IconData inputIcon;
  final TextEditingController InputControl;
  final FormFieldValidator<String>? customValidator;
  final String? errorText;
  final FocusNode? focusnode;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardtype;
  final String? labelText;

  CustomInputField1({
    super.key,
    required this.hintText,
    required this.InputControl,
    required this.inputIcon,
    this.customValidator,
    this.errorText,
    this.focusnode,
    this.obscureText = false,
    this.onChanged,
    this.keyboardtype,
    this.labelText,
  });

  @override
  State<CustomInputField1> createState() => _CustomInputField1State();
}

class _CustomInputField1State extends State<CustomInputField1> {
  bool isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 58,
      ),
      child: TextFormField(
        validator: widget.customValidator,
        onChanged: widget.onChanged,
        focusNode: widget.focusnode,
        controller: widget.InputControl,
        keyboardType: widget.keyboardtype,
        obscureText:
            widget.obscureText == true ? isObscured : widget.obscureText,
        decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: Color(0xFFB3B3B3),
          ),
          suffixIcon: InkWell(
            onTap: () {
              setState(() {
                isObscured = !isObscured;
              });
            },
            child: Icon(
              widget.obscureText == false
                  ? widget.inputIcon
                  : isObscured == true
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
              size: 20,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2),
            borderSide: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2),
            borderSide: BorderSide(
              color: Colors.black,
              width: 1,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2),
            borderSide: BorderSide(
              color: Colors.red,
              width: 1,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2),
            borderSide: BorderSide(
              color: Colors.red,
              width: 1,
            ),
          ),
          errorText: widget.errorText,
        ),
      ),
    );
  }
}
