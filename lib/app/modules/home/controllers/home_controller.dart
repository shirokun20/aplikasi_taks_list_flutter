import 'package:coba/app/modules/home/models/tab_item_model.dart';
import 'package:coba/app/modules/home/views/dashboard_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final List<TabItemModel> tabs = [
    TabItemModel(
      label: "Dashboard",
      activeIcon: Icons.pie_chart_sharp,
      inActiveIcon: Icons.pie_chart_outline_sharp,
    ),
    TabItemModel(
      label: "Taks",
      activeIcon: Icons.edit,
      inActiveIcon: Icons.edit_outlined,
    ),
    TabItemModel(
      label: "History",
      activeIcon: Icons.history_sharp,
      inActiveIcon: Icons.history_outlined,
    ),
    TabItemModel(
      label: "Profile",
      activeIcon: Icons.person,
      inActiveIcon: Icons.person_outline,
    ),
  ];

  String activeTab = "Dashboard";

  List<Widget> tabsView = [
    const DashboardView(),
    Container(),
    Container(),
    Container(),
  ];

  void setActiveTab(String tab) {
    activeTab = tab;
    update();
  }
}
