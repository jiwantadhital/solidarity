import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:solidarity/presentation/authentication/auth_widgets/auth_widgets.dart';
import 'package:solidarity/resources/fonts.dart';

class CameraChoose extends StatefulWidget {
  bool multiple, crop;
  CameraChoose({
    super.key,
    this.multiple = false,
    this.crop = false,
  });

  @override
  State<CameraChoose> createState() => _CameraChooseState();
}

class _CameraChooseState extends State<CameraChoose> {
  String imagePath = "";
  List<String> imagePaths = [];

  //camera section
  //gallery select photo
  Future pickImageGallery() async {
    if (widget.multiple == true) {
      try {
        final image = await ImagePicker().pickMultiImage(imageQuality: 40);
        List<XFile> xFilePcke = image;
        if (xFilePcke.isEmpty) return;
        for (var i = 0; i < xFilePcke.length; i++) {
          imagePaths.add(xFilePcke[i].path);
        }
        setState(() {});
      } on PlatformException catch (e) {
        print('Failed to pick image: $e');
      }
    } else {
      try {
        final image = await ImagePicker()
            .pickImage(source: ImageSource.gallery, imageQuality: 10);
        if (image == null) return;
        XFile xFilePcke = image;

        if (widget.crop == true) {
          print("a");

          final CroppedFile? croppedImg = await ImageCropper().cropImage(
              sourcePath: image.path,
              aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
              uiSettings: [
                AndroidUiSettings(
                    toolbarTitle: 'Crop',
                    lockAspectRatio: true,
                    hideBottomControls: true,
                    initAspectRatio: CropAspectRatioPreset.square),
                IOSUiSettings(
                    aspectRatioLockEnabled: true,
                    title: 'Crop',
                    aspectRatioPickerButtonHidden: true)
              ]);

          if (croppedImg != null) {
            imagePath = croppedImg.path;
          }
        } else {
          print("b");
          imagePath = xFilePcke.path;
        }

        setState(() {});
      } on PlatformException catch (e) {
        print('Failed to pick image: $e');
      }
    }
  }

  // camera select photo
  Future pickImageCamera() async {
    try {
      final image = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 10);
      if (image == null) return;
      setState(() {
        imagePath = image.path;
        print(imagePath);
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  } //Crop

  Future<void> _cropImg(File img) async {}

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return IntrinsicHeight(
      child: Container(
        padding: EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 26),
        width: size.width,
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DText(
              text: "Choose an option",
              size: 18,
              color: Colors.black,
              weight: FontWeightManager.bold,
            ),
            Divider(),
            SizedBox(
              height: 16,
            ),
            CameraOptions(
              size: size,
              name: "Choose from Gallery",
              tap: () {
                pickImageGallery().then((value) {
                  if (imagePath != "") {
                      Navigator.pop(context, {"imagePath": imagePath});
                    } 
                });
              },
            ),
            CameraOptions(
              size: size,
              name: "Open Camera",
              tap: () {
                pickImageCamera().then((value) {
                  if (imagePath != "") {
                      Navigator.pop(context, {"imagePath": imagePath});
                    }
                });
              },
            ),
            CameraOptions(
              size: size,
              name: "Cancel",
              tap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CameraOptions extends StatelessWidget {
  String name;
  void Function()? tap;
  CameraOptions(
      {super.key, required this.size, required this.name, required this.tap});

  final Size size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tap,
      child: Container(
        height: 40,
        width: size.width,
        child: GestureDetector(
            onTap: tap,
            child: DText(
              text: name,
              size: 15,
              color: Colors.black,
              weight: FontWeightManager.medium,
            )),
      ),
    );
  }
}