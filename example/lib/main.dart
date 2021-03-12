import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:tester_getx/tester_getx.dart';

void main() {
  getxTesting(
    "test description",
    widgetTest: (tester) async {
      expect('/', Get.currentRoute);

      Get.to(Container());
      expect('/Container', Get.currentRoute);

      Get.to(Scaffold());
      expect('/Scaffold', Get.currentRoute);

      Get.back();

      expect('/Container', Get.currentRoute);
    },
  );

  getXTesting(
    'GetX test',
    widget: GetX<Controller>(
      init: Controller(),
      builder: (controller) {
        return Text("ban:${controller.count}");
      },
    ),
    test: (e) {
      expect(find.text("ban:0"), findsOneWidget);
      expect(e.count.value, 0);
    },
  );

  getBuilderTesting(
    'GetBuilder test',
    widget: GetBuilder<Controller>(
      init: Controller(),
      builder: (controller) {
        return Text("ban:${controller.count}");
      },
    ),
    test: (e) {
      expect(find.text("ban:0"), findsOneWidget);
      expect(e.count.value, 0);
    },
  );

  obxTesting(
    'Obx test',
    widget: (controller) => Obx(
      () => Text("ban:${controller.count}"),
    ),
    controller: Controller(),
    test: (e) {
      expect(find.text("ban:0"), findsOneWidget);
      expect(e.count.value, 0);
    },
  );

  getxControllerTesting<Controller>(
    'Controller test',
    (controller) {},
    controller: Controller(),
    onInit: (c) {
      c.increment();
      print('onInit');
    },
    onReady: (c) {
      print('onReady');
      c.increment();
    },
    onClose: (c) {
      print('onClose');
    },
  );
}

class Controller extends GetxController {
  final count = 0.obs;
  void increment() => count.value++;

  @override
  void onInit() {
    print('inittt');
    super.onInit();
  }

  @override
  void onReady() {
    print('onReady');
    super.onReady();
  }

  void onClose() {
    print('onClose');
  }
}
