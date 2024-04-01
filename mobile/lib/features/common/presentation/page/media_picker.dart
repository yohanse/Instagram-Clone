import 'package:flutter/material.dart';
import 'package:mobile/features/common/presentation/page/media_services.dart';
import 'package:photo_manager/photo_manager.dart';

class MediaPicker extends StatefulWidget {
  final int maxCount;
  final RequestType requestType;
  const MediaPicker(
      {super.key, required this.maxCount, required this.requestType});

  @override
  State<MediaPicker> createState() => _MediaPickerState();
}

class _MediaPickerState extends State<MediaPicker> {
  AssetPathEntity? selectedAlbum;
  List<AssetPathEntity> albumList = [];
  List<AssetEntity> assetList = [];
  List<AssetEntity> selectedAssetList = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Row(
              children: [Icon(
              Icons.close,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Text("Next Post")],
            ),
            Text("Next"),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    MediaServices().loadAlbums(widget.requestType).then((value) => setState(() {
          albumList = value;
          selectedAlbum = value.isNotEmpty ? value[0] : null;
        }));
    MediaServices().loadAssets(selectedAlbum!).then((value) => setState(() {
          assetList = value;
        }));
    super.initState();
  }
}
