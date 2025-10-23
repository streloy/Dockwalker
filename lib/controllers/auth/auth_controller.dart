import 'package:dockwalker/pages/auth/login_candidate_page.dart';
import 'package:dockwalker/pages/auth/login_employer_page.dart';
import 'package:dockwalker/pages/candidate/home_candidate_page.dart';
import 'package:dockwalker/pages/employer/home_employer_page.dart';
import 'package:dockwalker/services/home_service.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

class AuthController extends GetxController {

  final HomeService homeService = Get.find<HomeService>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (homeService.getStorage.hasData("TOKEN")) {
        login();
      }
    });
  }

  Future login() async {
    var email     = await homeService.getStorage.read("EMAIL");
    var password  = await homeService.getStorage.read("PASSWORD");
    var usertype  = await homeService.getStorage.read("USERTYPE");
    var info  = await homeService.login(email, password);
    var body  = jsonDecode(info.body);
    homeService.getStorage.write("TOKEN", body['token']);
    if(usertype=='candidate') {
      Get.offAll( () => HomeCandidatePage(), transition: Transition.downToUp );
    } else {
      Get.offAll( () => HomeEmployerPage(), transition: Transition.downToUp );
    }
  }

  gotoCandidateLogin() {
    Get.to(()=> LoginCandidatePage(), transition: Transition.rightToLeft);
  }

  gotEmployerLogin() {
    Get.to(()=> LoginEmployerPage(), transition: Transition.rightToLeft);
  }

}