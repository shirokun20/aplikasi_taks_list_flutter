import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.blue[700],
        ),
      ),
      body: SafeArea(child: _main()),
    );
  }

  Widget _main() {
    return SizedBox(
      width: Get.width,
      height: Get.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _content(),
          _bottomNav(),
        ],
      ),
    );
  }

  Widget _content() {
    return GetBuilder<HomeController>(builder: (ctrl) {
      return Expanded(
        child: IndexedStack(
          index: ctrl.tabs.indexWhere(
            (element) => element.label == ctrl.activeTab,
          ),
          children: ctrl.tabsView,
        ),
      );
    });
  }

  Widget _bottomNav() {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0x00000000).withOpacity(0.20),
            offset: const Offset(0, 2),
            blurRadius: 7,
            spreadRadius: 4,
          ),
        ],
      ),
      child: GetBuilder<HomeController>(builder: (ctrl) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: ctrl.tabs
              .map((e) => _tabBar(
                    iconActive: e.activeIcon,
                    iconInactive: e.inActiveIcon,
                    label: e.label,
                    isSelected: e.label == ctrl.activeTab,
                    isFirst: ctrl.tabs.indexOf(e) == 0,
                    isLast: ctrl.tabs.indexOf(e) == ctrl.tabs.length - 1,
                    onTap: () => ctrl.setActiveTab(e.label),
                  ))
              .toList(),
        );
      }),
    );
  }

  Widget _tabBar({
    void Function()? onTap,
    String label = "Home",
    bool isSelected = false,
    IconData iconActive = Icons.pie_chart_sharp,
    IconData iconInactive = Icons.pie_chart_outline_sharp,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.only(
            topLeft:
                isFirst ? const Radius.circular(20) : const Radius.circular(0),
            topRight:
                isLast ? const Radius.circular(20) : const Radius.circular(0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
            ),
            child: Column(
              children: [
                Icon(
                  isSelected ? iconActive : iconInactive,
                  size: 30,
                  color: isSelected ? Colors.blue[700] : Colors.black,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 15,
                    color: isSelected ? Colors.blue[700] : Colors.black,
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
