import 'package:dockwalker/pages/auth/login_candidate_page.dart';
import 'package:dockwalker/pages/auth/login_employer_page.dart';
import 'package:get/get.dart';
import 'package:dockwalker/services/home_service.dart';

class MessageCandidateController extends GetxController {

  final HomeService homeService = Get.find<HomeService>();

  var employer_id = "".obs;
  var messages = [].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }


  @override
  void onReady() {
    getMessages();
  }

  Future getMessages() async {
    messages.value = await homeService.getMessageDetail(employer_id.value);
  }

  Future sendMessage(var employer_id, var content) async {
    await homeService.sendMessage(employer_id, content);
    getMessages();
  }

  gotoCandidateLogin() {
    Get.to(LoginCandidatePage(), transition: Transition.rightToLeft);
  }

  gotEmployerLogin() {
    Get.to(LoginEmployerPage(), transition: Transition.rightToLeft);
  }

}