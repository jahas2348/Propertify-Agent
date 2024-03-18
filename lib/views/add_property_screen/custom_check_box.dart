import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  final bool isChecked;
  final Function(bool) onChanged;

  CustomCheckbox({required this.isChecked, required this.onChanged});

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged(!widget.isChecked);
      },
      child: Row(
        children: [
          Icon(
            widget.isChecked ? Icons.check_box : Icons.check_box_outline_blank,
            color: widget.isChecked ? Colors.black : Colors.grey,
          ),
          SizedBox(width: 5),
        ],
      ),
    );
  }
}

List<String> amenitiesList = [
  "Gym",
  "Swimming Pool",
  "Parking",
  "Furnished",
  "A/C",
];


