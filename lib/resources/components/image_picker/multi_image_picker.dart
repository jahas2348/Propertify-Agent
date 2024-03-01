import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MultiImagePickerWidget extends StatefulWidget {
  final void Function(List<XFile>?, List<String>) onImagesSelected;
  final void Function(List<XFile>?)? onNewImages;
  final List<String>? initialImageUrls;
  final List<String> initialRemovedImageUrls;

  MultiImagePickerWidget({
    required this.onImagesSelected,
    this.onNewImages,
    this.initialImageUrls,
    this.initialRemovedImageUrls = const [],
  });

  @override
  _MultiImagePickerWidgetState createState() => _MultiImagePickerWidgetState();
}

class _MultiImagePickerWidgetState extends State<MultiImagePickerWidget> {
  List<XFile> selectedImages = [];
  List<String> removedImageUrls = [];
  List<XFile> newGalleryPictures = [];

  @override
  void initState() {
    super.initState();
    removedImageUrls = List.from(widget.initialRemovedImageUrls);
    // If initialImageUrls is provided, load them initially
    if (widget.initialImageUrls != null) {
      widget.initialImageUrls!.forEach((url) {
        selectedImages.add(XFile(url));
      });
    }
  }

  Future<void> loadImages() async {
    final int totalImageCount =
        selectedImages.length + newGalleryPictures.length;
    if (totalImageCount >= 4) {
      // Show snackbar if the maximum limit is reached
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No more images can be selected.'),
        ),
      );
      return;
    }

    try {
      final List<XFile>? result = await ImagePicker().pickMultiImage(
        maxWidth: 8000, // Set to a large value to allow multiple images
        maxHeight: 8000, // Set to a large value to allow multiple images
        imageQuality: 80,
      );

      if (result != null && result.isNotEmpty) {
        final int newImageCount =
            selectedImages.length + newGalleryPictures.length + result.length;
        if (newImageCount > 4) {
          // Show snackbar if the selected count exceeds the limit
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Only ${4 - selectedImages.length - newGalleryPictures.length} more images can be selected.'),
            ),
          );
          return;
        }

        setState(() {
          newGalleryPictures.addAll(result);
        });

        widget.onImagesSelected(
            selectedImages + newGalleryPictures, removedImageUrls);
        widget.onNewImages!(newGalleryPictures);

        print("Selected Images: ${selectedImages + newGalleryPictures}");
      }
    } catch (e) {
      print('Error selecting images: $e');
    }
  }

  Widget _buildDeleteButton(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (index < selectedImages.length) {
            final XFile image = selectedImages[index];
            final String imagePath = image.path;
            if (widget.initialImageUrls != null &&
                widget.initialImageUrls!.contains(imagePath)) {
              removedImageUrls.add(imagePath);
            }
            selectedImages.removeAt(index);
          } else if (index - selectedImages.length <
              newGalleryPictures.length) {
            final XFile image =
                newGalleryPictures[index - selectedImages.length];
            newGalleryPictures.remove(image);
          }
        });

        widget.onImagesSelected(
            selectedImages + newGalleryPictures, removedImageUrls);
        print("Removed Image URLs: $removedImageUrls");
        print("Selected Images: ${selectedImages + newGalleryPictures}");
        print('Deleted index: $index');
      },
      child: CircleAvatar(
        backgroundColor: Colors.red,
        radius: 12,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 16,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final displayedImages = selectedImages + newGalleryPictures;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Property Gallery",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            InkWell(
              onTap: loadImages,
              child: Row(
                children: [
                  Icon(Icons.camera_alt_outlined),
                  SizedBox(width: 5),
                  Text("Choose", style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        displayedImages.isNotEmpty
            ? GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: displayedImages.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1 / 1,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Stack(
                    children: [
                      _buildImageWidget(displayedImages[index]),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: _buildDeleteButton(index),
                      ),
                    ],
                  );
                },
              )
            : Container(),
      ],
    );
  }

  Widget _buildImageWidget(XFile image) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: _getImageWidget(image),
      ),
    );
  }

  Widget _getImageWidget(XFile image) {
    if (image.path.startsWith('http')) {
      return Image.network(image.path, fit: BoxFit.cover);
    } else {
      return Image.file(File(image.path), fit: BoxFit.cover);
    }
  }
}
