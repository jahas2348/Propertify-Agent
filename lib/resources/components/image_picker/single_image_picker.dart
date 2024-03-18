import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:propertify_for_agents/resources/constants/spaces%20&%20paddings/spaces.dart';

class SingleImagePickerWidget extends StatefulWidget {
  final void Function(File?) onImageSelected;
  final String? initialImageUrl;

  SingleImagePickerWidget({
    required this.onImageSelected,
    this.initialImageUrl,
  });

  @override
  _SingleImagePickerWidgetState createState() =>
      _SingleImagePickerWidgetState();
}

class _SingleImagePickerWidgetState extends State<SingleImagePickerWidget> {
  File? selectedImage;
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    
    // Check if the initialImageUrl is not empty and doesn't contain the base URL
    if (widget.initialImageUrl != null) {
      imageUrl = widget.initialImageUrl;
    }
  }

  Future<void> _showImagePickerBottomSheet() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            customSpaces.verticalspace20,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await _getImage(ImageSource.gallery);
                      Navigator.of(context).pop();
                    },
                    child: Row(
                      children: [
                        Icon(Icons.photo_outlined),
                        customSpaces.horizontalspace10,
                        Text('Gallery'),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await _getImage(ImageSource.camera);
                      Navigator.of(context).pop();
                    },
                    child: Row(
                      children: [
                        Icon(Icons.photo_camera_outlined),
                        customSpaces.horizontalspace10,
                        Text('Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            customSpaces.verticalspace20,
          ],
        );
      },
    );
  }

  Future<void> _getImage(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final result = await picker.pickImage(source: source);
      print('********************');
      print("Selected Image: $result");

      if (result != null) {
        String? croppedImagePath = await _cropImage(result.path);
        if (croppedImagePath != null) {
          setState(() {
            selectedImage = File(croppedImagePath);
            print('222222222222222');
            print(selectedImage);
            imageUrl = null;
          });

          widget.onImageSelected(selectedImage);
        }
      }
    } catch (e) {
      print('Error selecting image: $e');
    }
  }

  Future<String?> _cropImage(String imagePath) async {
    try {
      final imageCropper = ImageCropper();
      final croppedImage = await imageCropper.cropImage(
        sourcePath: imagePath,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
        ],
        compressQuality: 70,
        maxWidth: 1000,
        maxHeight: 1000,
      );

      print("Cropped Image: $croppedImage");

      if (croppedImage != null) {
        return croppedImage.path;
      }

      return null;
    } catch (e) {
      print('Error cropping image: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            _showImagePickerBottomSheet();
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: double.maxFinite,
                height: 250,
                decoration: BoxDecoration(
                  border: selectedImage == null && imageUrl == null
                      ? Border.all(width: 1, color: Colors.grey)
                      : null,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: imageUrl != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          imageUrl!, // Display the image using NetworkImage
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      )
                    : selectedImage != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              child: Image.file(
                                selectedImage!,
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.upload_file_outlined,
                                size: 48,
                                color: Colors.grey.shade600,
                              ),
                              SizedBox(height: 20),
                              Text(
                                "Upload Property Cover Picture",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
              ),
              if (selectedImage != null || imageUrl != null)
                Positioned(
                  top: 10,
                  right: 10,
                  child: InkWell(
                    onTap: () {
                      _showImagePickerBottomSheet();
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 15,
                      child: Icon(Icons.edit, size: 20, color: Colors.black),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
