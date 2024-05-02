import 'package:get/get.dart';

import '../controllers/taks_controller.dart';

class TaksBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TaksController>(
      () => TaksController(),
    );
  }
}
