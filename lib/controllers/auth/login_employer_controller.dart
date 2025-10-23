import 'package:dockwalker/pages/auth/registration_employer_page.dart';
import 'package:dockwalker/pages/auth/send_code_page.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dockwalker/services/home_service.dart';
import 'package:dockwalker/pages/employer/home_employer_page.dart';


class LoginEmployerController extends GetxController {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final HomeService homeService = Get.find<HomeService>();

  var rememberMe = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  gotoEmployerRegistration() {
    Get.to(()=> RegistrationEmployerPage(), transition: Transition.rightToLeft);
  }

  gotoResetPassword() {
    Get.to(()=> SendCodePage(), transition: Transition.rightToLeft);
  }

  // gotoHomepage() {
  //   Get.defaultDialog(
  //     title: "Alert",
  //     middleText: "Employer panel is not ready. We are working on it.",
  //     contentPadding: EdgeInsets.all(24),
  //     titlePadding: EdgeInsets.only(top: 24),
  //     radius: 8,
  //     onConfirm: () {
  //       Get.back();
  //     }
  //   );
  // }

  Future gotoHomepage() async{
    if (formKey.currentState!.validate()) {
      String email = emailController.text;
      String password = passwordController.text;

      var login = await homeService.login(email, password);
      var body = jsonDecode(login.body);
      var statusCode = login.statusCode;
      if (statusCode == 200) {
        homeService.getStorage.write("TOKEN", body['token']);
        homeService.getStorage.write("EMAIL", email);
        homeService.getStorage.write("PASSWORD", password);
        homeService.getStorage.write("USERTYPE", 'employer');
        Get.offAll(()=> HomeEmployerPage(), transition: Transition.downToUp);
      } else {
        Get.snackbar("Login", body['message'], backgroundColor: Colors.red.shade500, colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
      }
    }
    //Get.offAll(()=> HomeCandidatePage(), transition: Transition.downToUp);
  }

  String? emailValidation(String?  value) {
    if (value == null || value.isEmpty) { return "Please enter your email"; }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) { return "Enter a valid email"; }
    return null;
  }

  String? passwordValidation(String?  value) {
    if (value == null || value.isEmpty) { return "Please enter your password"; }
    if (value.length < 6) { return "Password must be at least 6 characters"; }
    return null;
  }

  showMyDialod(var title, var message) {
    Get.dialog(
      AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 12),
            Text(message),
          ],
        ),
      ),
      barrierDismissible: false, // user cannot close manually
    );
  }

  closeMyDialog() {
    if (Get.isDialogOpen ?? false) { Get.back(); }
  }


}