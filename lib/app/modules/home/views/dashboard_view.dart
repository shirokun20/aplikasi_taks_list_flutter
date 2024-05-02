import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardView extends GetView {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return _content();
  }

  Widget _content() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _header(),
        const Expanded(
          child: SingleChildScrollView(),
        ),
      ],
    );
  }

  Widget _header() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue[700],
        boxShadow: [
          BoxShadow(
            color: const Color(0x00000000).withOpacity(0.2),
            offset: const Offset(0, 2),
            blurRadius: 7,
            spreadRadius: 4,
          ),
        ],
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      child: const Row(
        children: [
          Icon(
            Icons.account_circle_rounded,
            size: 50,
            color: Colors.white,
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Nama User",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              Text(
                "Developer",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
