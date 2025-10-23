
import 'package:get/get.dart';
import 'package:dockwalker/services/home_service.dart';

class JobAppliedListController extends GetxController {

  final HomeService homeService = Get.find<HomeService>();

  var appliedJobs = [].obs;

  @override
  void onReady() {
    getAppliedJobs();
  }

  Future<void> getAppliedJobs() async {
    var response = await homeService.getAppliedJobs();
    appliedJobs.value = response;
  }

}