import 'package:dockwalker/services/home_service.dart';
import 'package:dockwalker/pages/auth/auth_page.dart';
import 'package:get/get.dart';
import 'dart:core';

class ProfileEmployerController extends GetxController {

  final HomeService homeService = Get.find<HomeService>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  gotoEmployerLogout() {
    Get.defaultDialog(
      title: "Confirm",
      middleText: "Are you sure you want to logout?",
      textCancel: "No",
      textConfirm: "Yes",
      onCancel: () {
      },
      onConfirm: () {
        homeService.getStorage.remove("TOKEN");
        homeService.getStorage.remove("EMAIL");
        homeService.getStorage.remove("PASSWORD");
        homeService.getStorage.remove("USERTYPE");
        Get.offAll(()=> AuthPage(), transition: Transition.downToUp);
      },
    );

  }

}