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
  var detail = "".obs;
  var available = "".obs;
  var education = "".obs;
  var experience = "".obs;
  var skills = "".obs;
  var photourl = "".obs;
  var resumeurl = "".obs;
  var skills_new = [].obs;

  var certificates = [].obs;
  var educations = [].obs;
  var experiences = [].obs;
  var languages = [].obs;
  var cskills = [].obs;


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
    detail.value = result['detail'];
    available.value = result['available'];
    education.value = result['education'];
    experience.value = result['experience'];
    skills.value = result['skills'];
    photourl.value = result['photourl'];
    resumeurl.value = result['resumeurl'];
    skills_new.value = result['skills_new'];

    certificates.value = result['certificates'];
    educations.value = result['educations'];
    experiences.value = result['experiences'];
    languages.value = result['languages'];
    cskills.value = result['cskills'];
  }

  Future<void> refreshData() async {
    populateInfo();
  }

  Future deleteCertificate(int id) async {
    await homeService.deleteCandidateCertificate(id);
    populateInfo();
  }

  Future deleteEducation(int id) async {
    await homeService.deleteCandidateEducation(id);
    populateInfo();
  }

  Future deleteExperience(int id) async {
    await homeService.deleteCandidateExperience(id);
    populateInfo();
  }

  Future deleteLanguage(int id) async {
    await homeService.deleteCandidateLanguage(id);
    populateInfo();
  }

  Future deleteSkill(int id) async {
    await homeService.deleteCandidateSkill(id);
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