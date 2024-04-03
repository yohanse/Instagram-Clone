import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile/features/common/presentation/bloc/Image/image_manager_bloc.dart';
import 'package:mobile/features/common/presentation/widget/CustomTabBarScrollable.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';
import 'package:transparent_image/transparent_image.dart';

class ImagePickerErrorPage extends StatelessWidget {
  final String text;
  const ImagePickerErrorPage({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.close_rounded),
            color: Colors.white,
            onPressed: () {
              context.go("/");
            },
          ),
          title: Text(
            "New post",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
        ),
        body: Text(text),
      ),
    );
  }
}
