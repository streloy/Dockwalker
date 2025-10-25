import 'package:get/get.dart';
import 'package:dockwalker/services/home_service.dart';

class MessagesEmployerController extends GetxController {

  final HomeService homeService = Get.find<HomeService>();
  var messages = [].obs;

  @override
  void onReady() {
    getMessages();
  }

  Future getMessages() async {
    messages.value = await homeService.getEmployerMessages();
  }

}