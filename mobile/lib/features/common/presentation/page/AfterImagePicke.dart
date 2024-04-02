import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:transparent_image/transparent_image.dart';

class AfterImagwPickerPage extends StatelessWidget {
  final List<AssetEntity> medias;
  final TextEditingController captionController = TextEditingController();
  AfterImagwPickerPage({super.key, required this.medias});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close_rounded),
          color: Colors.white,
          onPressed: () {
            context.go("/post");
          },
        ),
        title: Text(
          "New post",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
              onPressed: () {},
              child: Text(
                "Next",
                style: TextStyle(color: Colors.blue),
              ))
        ],
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 25,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: medias.length,
              itemBuilder: (context, index) {
                return FadeInImage(
                  image: AssetEntityImageProvider(
                      medias[index]), // Placeholder image
                  placeholder: MemoryImage(kTransparentImage),
                  fit: BoxFit.fill,
                );
              },
            ),
          ),
          Expanded(
            child: TextField(
              controller: captionController,
              decoration: InputDecoration(
                hintText: "Write a caption or add a poll...",
                hintStyle: TextStyle(color: Colors.white10),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          splashFactory: InkRipple.splashFactory, // Or MaterialRipple.circular
        ),
        child: Text(
          "Share",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
