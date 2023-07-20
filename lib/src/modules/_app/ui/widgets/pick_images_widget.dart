import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sezon/src/config/core/enums.dart';

class PickImagesWidget extends StatefulWidget {
  final ImageSelectionMode imageSelectionMode;

  const PickImagesWidget({
    Key? key,
    this.imageSelectionMode = ImageSelectionMode.single,
  }) : super(key: key);

  @override
  State<PickImagesWidget> createState() => _PickImagesWidgetState();
}

class _PickImagesWidgetState extends State<PickImagesWidget> {
  // vars.
  late final ImagePicker _imagePicker = ImagePicker();
  late final FilePicker _filePicker = FilePicker.platform;

  List<File> images = [];

  // ||... pick images ...||
  void pickImages({
    @required ImageSource? imageSource,
  }) async {
    if (imageSource == ImageSource.gallery) {
      FilePickerResult? filePickerResult = await _filePicker.pickFiles(
        type: FileType.image,
        allowCompression: true,
        allowMultiple: widget.imageSelectionMode == ImageSelectionMode.multiple,
      );
      if (filePickerResult == null || filePickerResult.files.isEmpty) return;
      setState(() {
        if (widget.imageSelectionMode == ImageSelectionMode.single) {
          images.clear();
        }
        images.addAll(filePickerResult.files
            .map((PlatformFile? file) => File(file!.path!))
            .toList());
      });
    } else {
      XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
      );
      if (image == null) return;
      setState(() {
        if (widget.imageSelectionMode == ImageSelectionMode.single) {
          images.clear();
        }
        images.add(File(image.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(12.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (images.isNotEmpty) ...[
            Wrap(
              spacing: 5.w,
              runSpacing: 5.h,
              children: List.generate(
                images.length,
                (index) => Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Image.file(
                        images[index],
                        width: 80.h,
                        height: 100.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          images.removeAt(index);
                        });
                      },
                      child: CircleAvatar(
                        radius: 12.r,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 15.h,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            const Divider(),
          ],
          ListTile(
            leading: Icon(
              Icons.camera_alt,
              color: Theme.of(context).primaryColor,
            ),
            onTap: () {
              pickImages(imageSource: ImageSource.camera);
            },
            title: Text(
              'Camera'.tr,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 15.sp,
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.image,
              color: Theme.of(context).primaryColor,
            ),
            onTap: () {
              pickImages(imageSource: ImageSource.gallery);
            },
            title: Text(
              'Gallery'.tr,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 15.sp,
              ),
            ),
          ),
          if (images.isNotEmpty) ...[
            const Divider(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 10.h)),
                onPressed: () {
                  Get.back(result: images);
                },
                child: Text('Select'.tr),
              ),
            ),
          ]
        ],
      ),
    );
  }
}
