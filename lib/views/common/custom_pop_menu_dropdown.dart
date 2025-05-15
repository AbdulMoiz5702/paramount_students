import 'package:flutter/material.dart';

class CustomPopupMenuButton extends StatelessWidget {
  final List<PopupMenuEntry> menuItems;
  final void Function(dynamic)? onSelected;
  final Color iconColor;

  const CustomPopupMenuButton({
    Key? key,
    required this.menuItems,
    this.onSelected,
    this.iconColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(Icons.menu, color: iconColor),
      onSelected: onSelected,
      itemBuilder: (context) => menuItems,
    );
  }
}
