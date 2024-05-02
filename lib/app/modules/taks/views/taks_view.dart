import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/taks_controller.dart';

class TaksView extends GetView<TaksController> {
  const TaksView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text(
        'Form Input Daily Taks',
        style: TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
      ),
      centerTitle: false,
      backgroundColor: Colors.white,
    );
  }

  Widget buildBody() {
    return GetBuilder<TaksController>(builder: (context) {
      return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              formPrimary(),
              const Divider(),
              labelHead(
                label: "Taks List",
              ),
              formTaks(),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    const Spacer(),
                    btn(
                      onTap: () => controller.onAddCount(),
                      label: "Add Taks",
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 10,
                ),
                child: btnWidth(
                  onTap: () => controller.saveTaks(),
                  color: Colors.green,
                  label: "Submit Taks",
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  Widget formTaks() {
    List<Widget> output = [];
    for (var i = 0; i < controller.count; i++) {
      output.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  formTakslist(index: i),
                  const SizedBox(
                    height: 10,
                  ),
                  i > 0
                      ? Row(
                          children: [
                            const Spacer(),
                            btn(
                              onTap: () => controller.onDeleteCount(i),
                            ),
                          ],
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ],
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: output,
    );
  }

  Widget formPrimary() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          inputDate(),
          const SizedBox(
            height: 10,
          ),
          inputProject(),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget inputDate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label(label: "Date"),
        const SizedBox(
          height: 10,
        ),
        selectBox(
          onTap: () async {
            final context = Get.context;
            DateTime? pickedDate = await showDatePicker(
              context: context!,
              initialDate: DateTime.now(),
              firstDate: DateTime(1950),
              //DateTime.now() - not to allow to choose before today.
              lastDate: DateTime(2100),
            );
            if (pickedDate != null) {
              final String formattedDate =
                  pickedDate.toString().substring(0, 10);
              controller.setDate(formattedDate);
            }
          },
          selectedValue: controller.date ?? "Select Date",
        ),
      ],
    );
  }

  Widget inputProject() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label(label: "Project Name"),
        const SizedBox(
          height: 10,
        ),
        inputBox(hintText: "Insert Project Name"),
      ],
    );
  }

  Widget formTakslist({
    int index = 0,
  }) {
    return GetBuilder<TaksController>(builder: (ctrl) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          label(label: "Taks Title"),
          const SizedBox(
            height: 10,
          ),
          inputBox(
            hintText: "Insert Taks Title",
            controller: ctrl.taksData[index].taksTitle,
          ),
          const SizedBox(
            height: 10,
          ),
          label(label: "Effort"),
          const SizedBox(
            height: 10,
          ),
          selectBox(
            onTap: () => _bottomSheet(
              onTapClose: () => Get.back(),
              widget: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: ctrl.effortData
                    .map((e) => selectBoxValue(
                          onTap: () => ctrl.onUpdateEffort(e, index),
                          isSelected: ctrl.taksData[index].effort == e,
                          value: e,
                        ))
                    .toList(),
              ),
            ),
            selectedValue: ctrl.taksData[index].effort ?? "Select Effort",
          ),
          const SizedBox(
            height: 10,
          ),
          label(label: "Status"),
          const SizedBox(
            height: 10,
          ),
          selectBox(
            onTap: () => _bottomSheet(
              onTapClose: () => Get.back(),
              widget: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: ctrl.statusData
                    .map((e) => selectBoxValue(
                          onTap: () => ctrl.onUpdateStatus(e, index),
                          isSelected: ctrl.taksData[index].status == e,
                          value: e,
                        ))
                    .toList(),
              ),
            ),
            selectedValue: ctrl.taksData[index].status ?? "Select Status",
          )
        ],
      );
    });
  }

  Widget selectBox({
    void Function()? onTap,
    String selectedValue = "",
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey, width: 1),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Text(
                  selectedValue,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.keyboard_arrow_down,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget inputBox({
    String? hintText,
    TextEditingController? controller,
    void Function(String)? onChanged,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey, width: 1),
      ),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        style: const TextStyle(
          fontSize: 16,
        ),
        decoration: InputDecoration(
          isDense: true,
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
          hintText: hintText,
        ),
      ),
    );
  }

  Widget label({
    String label = "",
  }) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget labelHead({
    String label = "",
  }) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget btn({
    void Function()? onTap,
    String label = "Delete Taks",
    Color color = Colors.red,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget btnWidth({
    void Function()? onTap,
    String label = "Delete Taks",
    Color color = Colors.red,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10,
            ),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _bottomSheet({
    void Function()? onTapClose,
    Widget? widget,
  }) {
    Get.bottomSheet(
      Wrap(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Select One",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      padding: EdgeInsets.zero,
                      icon: const Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                      onPressed: onTapClose,
                    ),
                  ],
                ),
                const Divider(),
                widget ?? const SizedBox(),
              ],
            ),
          ),
        ],
      ),
      isScrollControlled: true,
    );
  }

  Widget selectBoxValue(
      {bool isSelected = false, String? value, void Function()? onTap}) {
    Widget widget = Text("$value");
    if (isSelected) {
      widget = Row(
        children: [
          Text(
            "$value",
            style: const TextStyle(color: Colors.blue),
          ),
          const Spacer(),
          const Icon(
            Icons.check,
            color: Colors.blue,
          ),
        ],
      );
    }
    return SizedBox(
      width: double.infinity,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: widget,
          ),
        ),
      ),
    );
  }
}
