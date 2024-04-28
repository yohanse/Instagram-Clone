import 'package:flutter/material.dart';

class DraggableSheet extends StatelessWidget {
  DraggableSheet({super.key});

  final sheet = GlobalKey();

  final controller = DraggableScrollableController();

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      key: sheet,
      initialChildSize: 0.6,
      maxChildSize: 0.95,
      expand: true,
      snap: true,
      snapSizes: [
        0.6,
        0.95,
      ],

      builder: (context, scrollController) {
      
      return DecoratedBox(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(12),
          ),
        ),
        child: Column(children: [],),
      );
    });
  }
}
