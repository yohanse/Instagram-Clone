import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile/features/common/presentation/page/ImagePickerPageSuccess.dart';

import '../../reels/presentation/page/real_post_page_after_select.dart';
import '../../reels/presentation/page/reel_post_page.dart';
import '../presentation/page/ImagePickerPage.dart';
import '../presentation/widget/CustomTabBarScrollable.dart';

class PickerImageVideo extends StatefulWidget {
  const PickerImageVideo({super.key});

  @override
  State<PickerImageVideo> createState() => _PickerImageVideoState();
}

class _PickerImageVideoState extends State<PickerImageVideo> {
  int _selectedIndex = 0;
  
  final List<double> possible = [70, 134, 191, 255];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _selectedIndex == 0
          ? ImagePickerPage()
          : _selectedIndex == 1
              ? SelectReelVideoPage()
              : _selectedIndex == 2
                  ? Container()
                  : Container(),
      floatingActionButton: CustomTabBar(
        setSelectedIndex: (index) => setState(() => _selectedIndex = index),
        selectedIndex: _selectedIndex,
        xOffSet: possible[_selectedIndex],
      ),
    );
  }
}
