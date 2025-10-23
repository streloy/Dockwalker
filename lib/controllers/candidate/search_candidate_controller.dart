import 'package:dockwalker/pages/auth/login_candidate_page.dart';
import 'package:dockwalker/pages/auth/login_employer_page.dart';
import 'package:dockwalker/services/home_service.dart';
import 'package:get/get.dart';
import 'dart:convert';

class SearchCandidateController extends GetxController {

  final HomeService homeService = Get.find<HomeService>();

  var isLoading = false.obs;
  var pageNumber = 1.obs;
  var pageTotal = 0.obs;
  var jobList = [].obs;
  var searchText = "".obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }


  @override
  void onReady() {
    fetchJobInfo();
  }

  Future refresh() async {
    pageNumber.value = 1;
    jobList.value = [];
    fetchJobInfo();
  }

  Future fetchJobInfo() async {
    var body = await homeService.getJob(pageNumber.value);
    var data = jsonDecode(body);
    jobList.addAll(data['result']['data']);
    pageNumber.value = data['result']['current_page'];
    pageTotal.value = data['result']['total_pages'];
    pageNumber.value = pageNumber.value + 1;
  }

  List get filteredJobs {
    if (searchText.value.isEmpty) return jobList;
    return jobList.where((job) {
      final query = searchText.value.toLowerCase();
      return job['title'].toString().toLowerCase().contains(query) ||
          job['company_name'].toString().toLowerCase().contains(query) ||
          job['location'].toString().toLowerCase().contains(query);
    }).toList();
  }

  gotoCandidateLogin() {
    Get.to(LoginCandidatePage(), transition: Transition.rightToLeft);
  }

  gotEmployerLogin() {
    Get.to(LoginEmployerPage(), transition: Transition.rightToLeft);
  }

}