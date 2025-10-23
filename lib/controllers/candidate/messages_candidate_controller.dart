import 'package:dockwalker/pages/auth/login_candidate_page.dart';
import 'package:dockwalker/pages/auth/login_employer_page.dart';
import 'package:get/get.dart';
import 'package:dockwalker/services/home_service.dart';

class MessagesCandidateController extends GetxController {

  final HomeService homeService = Get.find<HomeService>();

  var messages = [].obs;

  @override
  void onReady() {
    getMessages();
  }

  Future getMessages() async {
    messages.value = await homeService.getMessages();
  }

  gotoCandidateLogin() {
    Get.to(LoginCandidatePage(), transition: Transition.rightToLeft);
  }

  gotEmployerLogin() {
    Get.to(LoginEmployerPage(), transition: Transition.rightToLeft);
  }

}