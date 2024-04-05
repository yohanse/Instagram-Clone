import 'package:flutter/material.dart';

class CutsomPostsProfileWidget extends StatelessWidget {
  final String imageUrl;
  const CutsomPostsProfileWidget({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: Image(
        height: 200,
        image: NetworkImage(imageUrl),
      ),
    );
  }
}
