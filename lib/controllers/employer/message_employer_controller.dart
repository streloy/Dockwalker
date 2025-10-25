import 'package:get/get.dart';
import 'package:dockwalker/services/home_service.dart';

class MessageEmployerController extends GetxController {

  final HomeService homeService = Get.find<HomeService>();

  var candidate_id = "".obs;
  var messages = [].obs;

  @override
  void onReady() {
    getMessages();
  }

  Future getMessages() async {
    messages.value = await homeService.getEmployerMessageDetail(candidate_id.value);
  }

  Future sendMessage(var candidate_id, var content) async {
    await homeService.sendEmployerMessage(candidate_id, content);
    getMessages();
  }

}