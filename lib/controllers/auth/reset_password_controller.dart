import 'package:dockwalker/pages/auth/auth_page.dart';
import 'package:dockwalker/services/home_service.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

class ResetPasswordController extends GetxController {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordCController = TextEditingController();

  final HomeService homeService = Get.find<HomeService>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future resetPassword() async{
    if (formKey.currentState!.validate()) {
      String email = emailController.text;
      String code = codeController.text;
      String password = passwordController.text;
      String passwordc = passwordCController.text;

      var login = await homeService.sendResetPassword(email, code, password, passwordc);
      var body = jsonDecode(login.body);
      var statusCode = login.statusCode;
      if (statusCode == 200) {
        Get.snackbar("Reset Password", body['message'], backgroundColor: Colors.white, snackPosition: SnackPosition.BOTTOM);
        Get.offAll(()=> AuthPage(), transition: Transition.downToUp);
      } else {
        Get.snackbar("Reset Password", body['message'], backgroundColor: Colors.white, snackPosition: SnackPosition.BOTTOM);
      }
    }
    //Get.offAll(()=> HomeCandidatePage(), transition: Transition.downToUp);
  }

  String? emailValidation(String?  value) {
    if (value == null || value.isEmpty) { return "Please enter your email"; }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) { return "Enter a valid email"; }
    return null;
  }

  String? codeValidation(String?  value) {
    if (value == null || value.isEmpty) { return "Please enter your email"; }
    if (!GetUtils.isLengthEqualTo(value, 6)) { return "Enter a valid code length."; }
    return null;
  }

  String? passwordValidation(String?  value) {
    if (value == null || value.isEmpty) { return "Please enter your password"; }
    if (value.length < 6) { return "Password must be at least 6 characters"; }
    return null;
  }

}