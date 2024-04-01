import 'package:flutter/material.dart';
import 'package:mobile/features/common/presentation/page/media_picker.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';

class ImagePicker extends StatefulWidget {
  const ImagePicker({super.key});

  @override
  State<ImagePicker> createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePicker> {
  List<AssetEntity> selectedImages = [];

  Future pickAssets(
      {required int maxCount, required RequestType requestType}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return MediaPicker(maxCount: maxCount, requestType: requestType);
        },
      ),
    );
    if (result != null || result.isNotEmpty) {
      setState(() {
        selectedImages = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView.builder(
          itemCount: selectedImages.length,
          itemBuilder: (BuildContext context, int index) {
          return AssetEntityImage(selectedImages[index]);
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            pickAssets(
              maxCount: 10,
              requestType: RequestType.common,
            );
          },
          child: Text("pick"),
        ),
      ),
    );
  }
}
