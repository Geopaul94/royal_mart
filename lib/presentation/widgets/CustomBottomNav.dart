

import 'package:flutter/material.dart';

class CustomBottomNav extends StatefulWidget {
  final IconData icon;
  final IconData? unselectedIcon;
  final Color? selectedColor;
  final Color? unselectedColor;
  final Function onTap;
  final bool isSelected;

  const CustomBottomNav({
    super.key,
    required this.icon,
    this.unselectedIcon,
    this.selectedColor = Colors.red,
    this.unselectedColor = Colors.grey,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  _CustomBottomNavState createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      child: Container(
        decoration: widget.isSelected
            ? BoxDecoration(
                shape: BoxShape.circle,
                color: widget.selectedColor,
              )
            : null,
        padding: EdgeInsets.all(8.0),
        child: Icon(
          widget.isSelected
              ? widget.icon
              : (widget.unselectedIcon ?? widget.icon),
          color: widget.isSelected ? Colors.white : widget.unselectedColor,
        ),
      ),
    );
  }
}
