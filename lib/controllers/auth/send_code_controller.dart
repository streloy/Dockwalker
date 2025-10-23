import 'package:dockwalker/services/home_service.dart';
import 'package:dockwalker/pages/auth/reset_password_page.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

class SendCodeController extends GetxController {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  final HomeService homeService = Get.find<HomeService>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future sendResetCode() async{
    if (formKey.currentState!.validate()) {
      String email = emailController.text;

      var login = await homeService.sendResetCode(email);
      var body = jsonDecode(login.body);
      var statusCode = login.statusCode;
      if (statusCode == 200) {
        Get.snackbar("Reset Code", body['message'], backgroundColor: Colors.white, snackPosition: SnackPosition.BOTTOM);
        Get.to(()=> ResetPasswordPage(), transition: Transition.downToUp);
      } else {
        Get.snackbar("Login", body['message'], backgroundColor: Colors.white, snackPosition: SnackPosition.BOTTOM);
      }
    }
    //Get.offAll(()=> HomeCandidatePage(), transition: Transition.downToUp);
  }

  String? emailValidation(String?  value) {
    if (value == null || value.isEmpty) { return "Please enter your email"; }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) { return "Enter a valid email"; }
    return null;
  }

}