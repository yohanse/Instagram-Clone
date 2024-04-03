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
            context.go("/pickImage");
          },
        ),
        title: Text(
          "New post",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            Expanded(
              flex: 25,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: medias.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      FadeInImage(
                        image: AssetEntityImageProvider(
                            medias[index]), 
                        placeholder: MemoryImage(kTransparentImage),
                        fit: BoxFit.fill,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  );
                },
              ),
            ),
            Expanded(
              flex: 75,
              child: Column(
                children: [
                  TextField(
                    controller: captionController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Write a caption or add a poll...",
                      hintStyle: TextStyle(
                          color: const Color.fromRGBO(255, 255, 255, 0.7)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            splashFactory: InkRipple.splashFactory,
            backgroundColor: Colors.blue,
          ),
          child: Text(
            "Share",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
