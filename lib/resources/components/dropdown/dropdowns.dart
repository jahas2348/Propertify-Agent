import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDropdown extends StatelessWidget {
  final List<String> items;
  final RxString selectedCategory;
  final Function(String?) onChanged;
  final String hintText;

  CustomDropdown({
    required this.items,
    required this.selectedCategory,
    required this.onChanged,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: DropdownButton<String>(
        value: selectedCategory.value.isEmpty ? null : selectedCategory.value,
        onChanged: onChanged,
        items: items.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        isExpanded: true,
        hint: Text(
          hintText,
          style: TextStyle(
            color: Colors.grey, // Change the hint text color here
          ),
        ),
        underline: Container(), // Removes the underline
      ),
    );
  }
}
