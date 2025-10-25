import 'package:dockwalker/pages/auth/login_candidate_page.dart';
import 'package:dockwalker/pages/auth/login_employer_page.dart';
import 'package:dockwalker/services/home_service.dart';
import 'package:get/get.dart';
import 'dart:convert';

class SearchEmployerController extends GetxController {

  final HomeService homeService = Get.find<HomeService>();

  var isLoading = false.obs;
  var pageNumber = 1.obs;
  var pageTotal = 0.obs;
  var candidateList = [].obs;
  var searchText = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
  @override
  void onReady() {
    fetchCandidateInfo();
  }

  Future pageRefresh() async {
    pageNumber.value = 1;
    candidateList.value = [];
    fetchCandidateInfo();
  }

  Future fetchCandidateInfo() async {
    var body = await homeService.getCandidateList(pageNumber.value);
    var data = jsonDecode(body);
    candidateList.addAll(data['result']['data']);
    pageNumber.value = data['result']['current_page'];
    pageTotal.value = data['result']['total_pages'];
    pageNumber.value = pageNumber.value + 1;
  }

  List get filteredCandidate {
    if (searchText.value.isEmpty) return candidateList;
    return candidateList.where((job) {
      final query = searchText.value.toLowerCase();
      return job['fullname'].toString().toLowerCase().contains(query) ||
          job['email'].toString().toLowerCase().contains(query) ||
          job['skills'].toString().toLowerCase().contains(query) ||
          job['experience'].toString().toLowerCase().contains(query) ||
          job['education'].toString().toLowerCase().contains(query);
    }).toList();
  }


  gotoCandidateLogin() {
    Get.to(LoginCandidatePage(), transition: Transition.rightToLeft);
  }

  gotEmployerLogin() {
    Get.to(LoginEmployerPage(), transition: Transition.rightToLeft);
  }

}