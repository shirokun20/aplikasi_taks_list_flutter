import 'package:flutter/material.dart';

class TabItemModel {
  IconData activeIcon;
  IconData inActiveIcon;
  String label;

  TabItemModel({
    required this.activeIcon,
    required this.inActiveIcon,
    required this.label,
  });
}
