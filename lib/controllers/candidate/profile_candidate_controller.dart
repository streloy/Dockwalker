import 'package:dockwalker/services/home_service.dart';
import 'package:dockwalker/pages/auth/auth_page.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'dart:core';

class ProfileCandidateController extends GetxController {

  final HomeService homeService = Get.find<HomeService>();

  var fullname = "".obs;
  var email = "".obs;
  var mobile = "".obs;
  var address = "".obs;
  var education = "".obs;
  var experience = "".obs;
  var skills = "".obs;
  var photourl = "".obs;
  var resumeurl = "".obs;
  var skills_new = [].obs;


  var certificateList = [
    {"id": "1", "certificateName": "Oracle DBA", "certificateCompany": "Oracle", "issueDate": "01-01-2024", "expireDate": "31-12-2025", "status": "Valid"},
    {"id": "2", "certificateName": "System Admin", "certificateCompany": "Redhat", "issueDate": "01-01-2024", "expireDate": "31-12-2025", "status": "Valid"},
    {"id": "3", "certificateName": "Zend Application", "certificateCompany": "CakePHP", "issueDate": "01-01-2024", "expireDate": "31-12-2025", "status": "Valid"},
    {"id": "4", "certificateName": "Master in Laraval", "certificateCompany": "Laraval", "issueDate": "01-01-2024", "expireDate": "31-12-2025", "status": "Valid"},
  ];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }


  @override
  void onReady() {
    populateInfo();
  }

  Future populateInfo() async{
    var response = await homeService.candidateInfo();
    var result = jsonDecode(response)['result'];
    fullname.value = result['fullname'];
    email.value = result['email'];
    mobile.value = result['mobile'];
    address.value = result['address'];
    education.value = result['education'];
    experience.value = result['experience'];
    skills.value = result['skills'];
    photourl.value = result['photourl'];
    resumeurl.value = result['resumeurl'];
    skills_new.value = result['skills_new'];
  }

  Future<void> refreshData() async {
    populateInfo();
  }

  gotoCandidateLogout() {
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
        Get.offAll(()=> AuthPage(), transition: Transition.downToUp);
      },
    );

  }

}