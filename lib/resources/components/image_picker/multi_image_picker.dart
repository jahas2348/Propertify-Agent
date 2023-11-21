import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:propertify_for_agents/resources/components/iconbox/customIconBox.dart';
import 'package:propertify_for_agents/resources/fonts/app_fonts/app_fonts.dart';
import 'package:propertify_for_agents/resources/constants/spaces%20&%20paddings/spaces.dart';

class MultiImagePickerWidget extends StatefulWidget {
  final void Function(List<XFile>?, List<int>) onImagesSelected; // Pass removeIndexes
  final List<String>? initialImageUrls; // URLs for updating
  final List<XFile>? initialImages;
  final List<int> initialRemoveIndexes; // Add initialRemoveIndexes

  MultiImagePickerWidget({
    required this.onImagesSelected,
    this.initialImageUrls,
    this.initialImages,
    this.initialRemoveIndexes = const [], required property, // Provide an empty list by default
  });

  @override
  _MultiImagePickerWidgetState createState() => _MultiImagePickerWidgetState();
}

class _MultiImagePickerWidgetState extends State<MultiImagePickerWidget> {
  List<XFile>? selectedImages = [];
  int selectedCount = 0;
  List<int> removeIndexes = []; // Track removeIndexes
  bool isUpdateMode = false;

  @override
  void initState() {
    super.initState();

    // If initialImages is provided, use them (for adding)
    isUpdateMode = widget.initialImageUrls != null;

    // If initialImages is provided, use them (for adding)
    if (widget.initialImages != null) {
      selectedImages =
          widget.initialImages!.map((file) => XFile(file.path)).toList();
      selectedCount = selectedImages!.length;
    }
    // If initialImageUrls is provided, convert them to XFile objects (for updating)
    else if (widget.initialImageUrls != null) {
      for (final imageUrl in widget.initialImageUrls!) {
        // You can use a placeholder image or load images from the URL
        // For now, we'll use a placeholder image
        selectedImages!.add(XFile(imageUrl));
        selectedCount++;
      }
    }

    // Add initial removeIndexes
    removeIndexes = List.from(widget.initialRemoveIndexes);
  }

  Future<void> loadImages() async {
    try {
      final List<XFile>? result = await ImagePicker().pickMultiImage();
      if (result != null && result.isNotEmpty) {
        setState(() {
          if (selectedImages != null) {
            final int newImageCount = selectedImages!.length + result.length;
            if (newImageCount <= 6) {
              // If total images won't exceed 6, add the new ones
              selectedImages!.addAll(result);
              selectedCount = selectedImages!.length;
            } else {
              // Remove the oldest images to accommodate the new ones
              final int excessImages = newImageCount - 6;
              selectedImages!.removeRange(0, excessImages);
              selectedImages!.addAll(result);
              selectedCount = selectedImages!.length;
            }
          } else {
            selectedImages = result;
            selectedCount = result.length;
          }
        });

        // Pass selectedImages and removeIndexes to the callback
        widget.onImagesSelected(selectedImages, removeIndexes);
      }
    } catch (e) {
      print('Error selecting images: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    print(widget.initialImageUrls);
    final displayedImages = selectedImages?.take(6).toList() ?? [];

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Property Gallery",
              style: AppFonts.SecondaryColorText16,
            ),
            InkWell(
              onTap: () {
                loadImages();
              },
              child: Row(
                children: [
                  CustomIconBox(
                    iconFunction: loadImages,
                    boxIcon: Icons.camera_alt_outlined,
                    radius: 4,
                  ),
                  customSpaces.horizontalspace5,
                  Text(
                    "Choose",
                    style: AppFonts.SecondaryColorText16,
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.info_outline,
              color: Colors.red,
              size: 14,
            ),
            customSpaces.horizontalspace5,
            Text(
              'Only 6 images allowed',
              style: TextStyle(fontSize: 16, color: Colors.red),
            ),
          ],
        ),
        displayedImages.isNotEmpty
            ? Column(
                children: [
                  customSpaces.verticalspace20,
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: displayedImages.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1.0,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      Widget imageWidget;

                      if (displayedImages[index].path.startsWith('http')) {
                        // If it's a URL, use Image.network
                        imageWidget = Image.network(
                          displayedImages[index].path,
                          fit: BoxFit.cover,
                        );
                      } else {
                        // If it's a local file, use Image.file
                        imageWidget = Image.file(
                          File(displayedImages[index].path),
                          fit: BoxFit.cover,
                        );
                      }

                      return Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: double.infinity,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: imageWidget,
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                // Implement the logic to remove the image here
                                setState(() {
                                  displayedImages.removeAt(index);
                                  selectedImages!.removeAt(index);

                                  // Remove the corresponding index from removeIndexes
                                  removeIndexes.removeAt(index);

                                  selectedCount--;
                                });
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  )
                ],
              )
            : Container(),
      ],
    );
  }
}
