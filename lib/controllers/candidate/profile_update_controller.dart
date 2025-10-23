import 'package:dockwalker/services/home_service.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_quill/flutter_quill.dart';

class ProfileUpdateController extends GetxController {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController fullnameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController educationController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController skillsController = TextEditingController();

  final QuillController quillController = QuillController.basic();
  final FocusNode editorFocusNode = FocusNode();
  final ScrollController editorScrollController = ScrollController();

  var photourl = "".obs;
  var resumeurl = "".obs;
  var photo = "".obs;
  var resume = "".obs;


  final HomeService homeService = Get.find<HomeService>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    fullnameController.text = "Asdasdasd";
  }


  @override
  void onReady() {
    candidateInfo();
  }

  Future candidateInfo() async {
    var info = await homeService.candidateInfo();
    var result = jsonDecode(info)['result'];
    fullnameController.text = result['fullname'] ?? "";
    addressController.text = result['address'] ?? "";
    educationController.text = result['education'] ?? "";
    experienceController.text = result['experience'] ?? "";
    skillsController.text = result['skills'] ?? "";

    if(result['photo'].toString().isNotEmpty) {
      photourl.value = result['photourl'];
      photo.value = result['photo'];
    }

    if(result['resume'].toString().isNotEmpty) {
      resumeurl.value = result['resumeurl'];
      resume.value = result['resume'];
    }
  }

  Future updateProfile() async {
    if (formKey.currentState!.validate()) {
      homeService.updateCandidateInfo( fullnameController.text, addressController.text, educationController.text, experienceController.text, skillsController.text );
    }
  }

  File? photoFile;
  final ImagePicker picker = ImagePicker();

  Future<void> pickPhoto() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      photoFile = File(pickedFile.path);
    }
  }

  Future<void> openResume() async {
    if(resumeurl.value.isEmpty) {
      Get.snackbar("Message", "Resume is not set yet.");
      return;
    }
    final Uri uri = Uri.parse(resumeurl.value);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception("Could not open ${resumeurl.value}");
    }
  }

  String? inputValidation(String?  value) {
    if (value == null || value.isEmpty) { return "Input field can not be empty!"; }
    return null;
  }

  String? emailValidation(String?  value) {
    if (value == null || value.isEmpty) { return "Please enter your email"; }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) { return "Enter a valid email"; }
    return null;
  }

  String? passwordValidation(String?  value) {
    if (value == null || value.isEmpty) { return "Please enter your password"; }
    if (value.length < 6) { return "Password must be at least 6 characters"; }
    return null;
  }

}