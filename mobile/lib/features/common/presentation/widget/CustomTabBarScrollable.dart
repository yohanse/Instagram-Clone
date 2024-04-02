import 'package:flutter/material.dart';

class CustomTabBar extends StatefulWidget {
  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  double _xOffset = 70;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        setState(() {
          _xOffset -= details.delta.dx;
          if (_xOffset > 255) {
            _xOffset = 255;
          }
          if (_xOffset < 70) {
            _xOffset = 70;
          }
        });
      },
      child: Stack(
        children: [
          Positioned(
              // Centered horizontally
              right: checkXoffset(_xOffset),
              child: CustomTabBarComponent(selectedIndex: selectedIndex),),
        ],
      ),
    );
  }

  void setSelectedIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  double checkXoffset(x) {
    final List<double> possible = [70, 134, 191, 255];
    for (int i = 0; i < 4; i++) {
      if (possible[i] >= x) {
        setSelectedIndex(i);
        return possible[i];
      }
    }
    return 255;
  }
}

class CustomTabBarComponent extends StatelessWidget {
  final int selectedIndex;
  const CustomTabBarComponent({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color.fromARGB(170, 0, 0, 0),
      ),
      child: Row(
        children: [
          IsSelected(
            text: "POST",
            selectedIndex: selectedIndex,
            index: 0,
          ),
          SizedBox(width: 14),
          IsSelected(
            text: "STORY",
            selectedIndex: selectedIndex,
            index: 1,
          ),
          SizedBox(width: 14),
          IsSelected(
            text: "REEL",
            selectedIndex: selectedIndex,
            index: 2,
          ),
          SizedBox(width: 14),
          IsSelected(
            text: "LIVE",
            selectedIndex: selectedIndex,
            index: 3,
          ),
        ],
      ),
    );
  }
}

class IsSelected extends StatelessWidget {
  final String text;
  final int selectedIndex, index;
  const IsSelected(
      {super.key,
      required this.text,
      required this.selectedIndex,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return selectedIndex != index
        ? UnSelectedText(text: text)
        : SelectedText(text: text);
  }
}

class UnSelectedText extends StatelessWidget {
  final String text;
  const UnSelectedText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 15,
        color: Color.fromARGB(100, 255, 255, 255),
      ),
    );
  }
}

class SelectedText extends StatelessWidget {
  final String text;
  const SelectedText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 13,
        color: Colors.white,
      ),
    );
  }
}
