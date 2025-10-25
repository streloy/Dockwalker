import 'package:dockwalker/services/home_service.dart';
import 'package:get/get.dart';
import 'dart:convert';

class JobDetailController extends GetxController {

  final HomeService homeService = Get.find<HomeService>();

  var userid = "".obs;
  var jobid = "".obs;
  var jobdata = {}.obs;
  var jobacdata = [].obs;
  var isapplied = 0.obs;

  @override
  void onReady() {
  }

  Future<void> getData() async {
    var response = await homeService.getJobDetail(jobid.value);
    var data = jsonDecode(response)['result'];
    jobdata.value = data;

    getJobAppliedCandidates();
  }

  Future getJobAppliedCandidates() async {
    var response = await homeService.getJobAppliedCandidates(jobid.value);
    var data = jsonDecode(response)['result'];
    jobacdata.value = data;
  }

}