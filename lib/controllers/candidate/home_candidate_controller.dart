import 'package:dockwalker/pages/auth/login_candidate_page.dart';
import 'package:dockwalker/pages/auth/login_employer_page.dart';
import 'package:dockwalker/pages/candidate/dashboard_candidate_page.dart';
import 'package:dockwalker/pages/candidate/search_candidate_page.dart';
import 'package:dockwalker/pages/candidate/messages_candidate_page.dart';
import 'package:dockwalker/pages/candidate/profile_candidate_new_page.dart';
import 'package:dockwalker/services/home_service.dart';
import 'package:dockwalker/pages/candidate/profile_update_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';

class HomeCandidateController extends GetxController {

  final HomeService homeService = Get.find<HomeService>();

  var selectedIndex = 0.obs;
  var selectedTitle = "Jobs".obs;
  final List<Widget> pages = [
    DashboardCandidatePage(),
    SearchCandidatePage(),
    MessagesCandidatePage(),
    ProfileCandidateNewPage(),
  ];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }


  @override
  void onReady() {
    checkInfo();
  }

  Future checkInfo() async {
    var candidateInfo = await homeService.candidateInfo();
    var response = jsonDecode(candidateInfo);
    var result = response['result'];
    if(result['fullname'].toString().isEmpty || result['resume'].toString().isEmpty || result['photo'].toString().isEmpty || result['address'].toString().isEmpty ) {
      Get.to(ProfileUpdatePage(), transition: Transition.rightToLeft);
    }
  }

  void changeIndex(int index) {
    selectedIndex.value = index;
    if (index==0) { selectedTitle.value = "Jobs"; }
    else if (index==1) { selectedTitle.value = "Search"; }
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