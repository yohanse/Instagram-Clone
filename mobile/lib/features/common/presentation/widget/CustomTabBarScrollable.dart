import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomTabBar extends StatefulWidget {
  final Function(int) setSelectedIndex;
  final int selectedIndex;

  final double xOffSet;

  const CustomTabBar({
    super.key,
    required this.setSelectedIndex,
    required this.selectedIndex,
    required this.xOffSet,
  });
  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        
        // print("===================================================================================");
        // print("details.delta.dx: ${details.delta.dx}");
        // print(widget.xOffSet - details.delta.dx);
        
        // if (details.delta.dx < -0.01) {
        //   if (widget.selectedIndex != 3) {
        //     widget.setSelectedIndex(widget.selectedIndex + 1);
        //   }
        // }
        // else if (details.delta.dx > 0.5) {
        //   if (widget.selectedIndex != 0) {
        //     widget.setSelectedIndex(widget.selectedIndex - 1);
        //   }
        // }
      },
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            right: widget.xOffSet,
            child: CustomTabBarComponent(
                selectedIndex: widget.selectedIndex,
                changeState: (index) {
                  widget.setSelectedIndex(index);
                }),
          ),
        ],
      ),
    );
  }
}

class CustomTabBarComponent extends StatelessWidget {
  final int selectedIndex;
  final Function(int) changeState;
  const CustomTabBarComponent(
      {super.key, required this.selectedIndex, required this.changeState});

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
          GestureDetector(
            onTap: () => changeState(0),
            child: IsSelected(
              text: "POST",
              selectedIndex: selectedIndex,
              index: 0,
            ),
          ),
          SizedBox(width: 14),
          GestureDetector(
            onTap: () => changeState(1),
            child: IsSelected(
              text: "STORY",
              selectedIndex: selectedIndex,
              index: 1,
            ),
          ),
          SizedBox(width: 14),
          GestureDetector(
            onTap: () => changeState(2),
            child: IsSelected(
              text: "REEL",
              selectedIndex: selectedIndex,
              index: 2,
            ),
          ),
          SizedBox(width: 14),
          GestureDetector(
            onTap: () => changeState(3),
            child: IsSelected(
              text: "LIVE",
              selectedIndex: selectedIndex,
              index: 3,
            ),
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
