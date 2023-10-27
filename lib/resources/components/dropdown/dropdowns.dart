import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:propertify_for_agents/resources/colors/app_colors.dart';

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
    return DropdownButtonFormField<String>(
      value: selectedCategory.value.isEmpty ? null : selectedCategory.value,
      items: items.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        isDense: true,
      ),
    );
  }
}
