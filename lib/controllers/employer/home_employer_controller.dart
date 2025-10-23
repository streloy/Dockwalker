import 'package:dockwalker/pages/auth/login_candidate_page.dart';
import 'package:dockwalker/pages/auth/login_employer_page.dart';
import 'package:dockwalker/pages/employer/dashboard_employer_page.dart';
import 'package:dockwalker/pages/employer/messages_employer_page.dart';
import 'package:dockwalker/pages/employer/profile_employer_page.dart';
import 'package:dockwalker/pages/employer/search_employer_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeEmployerController extends GetxController {

  var selectedIndex = 0.obs;
  var selectedTitle = "Jobs".obs;
  final List<Widget> pages = [
    DashboardEmployerPage(),
    SearchEmployerPage(),
    MessagesEmployerPage(),
    ProfileEmployerPage()
  ];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  void changeIndex(int index) {
    selectedIndex.value = index;
    if (index==0) { selectedTitle.value = "Posted"; }
    else if (index==1) { selectedTitle.value = "Candidates"; }
    else if (index==2) { selectedTitle.value = "Messages"; }
    else { selectedTitle.value = "Profile"; }
  }

  gotoCandidateLogin() {
    Get.to(LoginCandidatePage(), transition: Transition.rightToLeft);
  }

  gotEmployerLogin() {
    Get.to(LoginEmployerPage(), transition: Transition.rightToLeft);
  }

}