import 'package:coba/app/modules/taks/models/taks_form_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class TaksController extends GetxController {
  final Logger _log = Logger();
  int count = 1;

  List<String> effortData = [
    "LOW",
    "MEDIUM",
    "HIGH",
  ];

  List<String> statusData = [
    "DONE",
    "PROGRESS",
    "NEW",
  ];

  List<String> taksTitle = [];
  List<TaksFormModel> taksData = [];

  String? date;

  @override
  void onInit() {
    taksTitle.add("");
    taksData.add(TaksFormModel(
      taksTitle: TextEditingController(),
    ));
    super.onInit();
  }

  void setDate(String value) {
    date = value;
    update();
  }

  void onAddCount() {
    count++;
    taksTitle.add("");
    taksData.add(TaksFormModel(
      taksTitle: TextEditingController(),
    ));
    update();
  }

  void onUpdateEffort(String effort, int index) {
    taksData[index].effort = effort;
    update();
    Get.back();
  }

  void onUpdateStatus(String status, int index) {
    taksData[index].status = status;
    update();
    Get.back();
  }

  void onDeleteCount(int index) {
    count--;
    taksTitle.removeAt(index);
    taksData[index].taksTitle?.dispose();
    taksData.removeAt(index);
    update();
  }

  void saveTaks() {
    for (var e in taksData) {
      _log.i(
          "Taks Title : ${e.taksTitle?.text}${'\n'}Effort : ${e.effort}${'\n'}Status : ${e.status}");
    }
  }

  @override
  void onClose() {
    super.onClose();
    for (var controller in taksData) {
      controller.taksTitle?.dispose();
    }
  }
}
