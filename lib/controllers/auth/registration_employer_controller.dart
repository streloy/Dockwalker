import 'package:dockwalker/pages/auth/registration_employer_page.dart';
import 'package:dockwalker/pages/auth/reset_password_page.dart';
import 'package:get/get.dart';

class RegistrationEmployerController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  gotoCandidateRegistration() {
    Get.to(()=> RegistrationEmployerPage(), transition: Transition.rightToLeft);
  }

  gotoResetPassword() {
    Get.to(()=> ResetPasswordPage(), transition: Transition.rightToLeft);
  }
}