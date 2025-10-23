import 'package:dockwalker/pages/auth/registration_employer_page.dart';
import 'package:dockwalker/pages/auth/reset_password_page.dart';
import 'package:dockwalker/services/home_service.dart';
import 'package:dockwalker/pages/candidate/home_candidate_page.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

class RegistrationCandidateController extends GetxController {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordCController = TextEditingController();

  final HomeService homeService = Get.find<HomeService>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future registerNewCandidate() async{
    if(formKey.currentState!.validate()) {
      var email = emailController.text;
      var mobile = mobileController.text;
      var password = passwordController.text;
      var passwordC = passwordCController.text;

      var register = await homeService.register(email, mobile, password, passwordC);
      var body = jsonDecode(register.body);
      var statusCode = register.statusCode;
      if (statusCode == 200) {
        homeService.getStorage.write("TOKEN", body['token']);
        homeService.getStorage.write("EMAIL", email);
        homeService.getStorage.write("PASSWORD", password);
        Get.offAll(()=> HomeCandidatePage(), transition: Transition.downToUp);
      } else {
        Get.snackbar("Login", body['message'], backgroundColor: Colors.white, snackPosition: SnackPosition.BOTTOM);
      }
    }
  }

  gotoCandidateRegistration() {
    Get.to(()=> RegistrationEmployerPage(), transition: Transition.rightToLeft);
  }

  gotoResetPassword() {
    Get.to(()=> ResetPasswordPage(), transition: Transition.rightToLeft);
  }

  String? emailValidation(String?  value) {
    if (value == null || value.isEmpty) { return "Please enter your email"; }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) { return "Enter a valid email"; }
    return null;
  }

  String? mobileValidation(String?  value) {
    if (value == null || value.isEmpty) { return "Please enter your mobile"; }
    if (!GetUtils.isPhoneNumber(value)) { return "Enter a valid mobile"; }
    return null;
  }

  String? passwordValidation(String?  value) {
    if (value == null || value.isEmpty) { return "Please enter your password"; }
    if (value.length < 6) { return "Password must be at least 6 characters"; }
    return null;
  }

}