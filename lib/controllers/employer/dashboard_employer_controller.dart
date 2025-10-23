import 'package:dockwalker/pages/auth/login_candidate_page.dart';
import 'package:dockwalker/pages/auth/login_employer_page.dart';
import 'package:dockwalker/services/home_service.dart';
import 'package:get/get.dart';

class DashboardEmployerController extends GetxController {

  final HomeService homeService = Get.find<HomeService>();

  var isLoading = false.obs;
  var jobList = [].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future pageRefresh() async {
    jobList.value = [];
  }

  Future fetchJobInfo() async {
    var body = await homeService.getJob(pageNumber.value);
    var data = jsonDecode(body);
    jobList.addAll(data['result']['data']);
    pageNumber.value = data['result']['current_page'];
    pageTotal.value = data['result']['total_pages'];
    pageNumber.value = pageNumber.value + 1;
  }

  gotoCandidateLogin() {
    Get.to(LoginCandidatePage(), transition: Transition.rightToLeft);
  }

  gotEmployerLogin() {
    Get.to(LoginEmployerPage(), transition: Transition.rightToLeft);
  }

}