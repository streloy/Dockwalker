import 'package:dockwalker/services/home_service.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

class JobPostController extends GetxController {

  final HomeService homeService = Get.find<HomeService>();

  final formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController yachtController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController salaryMinController = TextEditingController();
  final TextEditingController salaryMaxController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController requirementsController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController deadlineController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController vacanciesController = TextEditingController();

  var masterJobTitle      = [].obs;
  var masterJobDepartment = [].obs;
  var masterJobCurrency   = [].obs;
  var masterJobExperience = <String>[].obs;
  var masterJobPeriod     = [].obs;
  var masterJobVisa       = <String>[].obs;

  var selectedTitle = "".obs;
  var selectedDepartment = "".obs;
  var selectedCurrency = "".obs;
  var selectedPeriod = "".obs;
  var selectedExperience = "".obs;
  var selectedVisa = "".obs;

  var isUrgent = false.obs;
  var isFeatured = false.obs;

  @override
  void onReady() {
    getMasterData();
  }

  Future<void> selectDate(TextEditingController textEditingController) async {
    final DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime(2025, 11, 1),
      firstDate: DateTime(2025),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null) {
      final formattedDate = "${pickedDate.year}-"
          "${pickedDate.month.toString().padLeft(2, '0')}-"
          "${pickedDate.day.toString().padLeft(2, '0')}";

      textEditingController.text = formattedDate;
    }
  }


  Future getMasterData() async {
    var mjt = await homeService.masterJobTitle();
    masterJobTitle.value = mjt.map((item) => item['title']!).toList();
    selectedTitle.value = masterJobTitle.value[0];

    var mjd = await homeService.masterJobDepartment();
    masterJobDepartment.value = mjd.map((item) => item['title']!).toList();
    selectedDepartment.value = masterJobDepartment.value[0];

    var mjc = await homeService.masterJobCurrency();
    masterJobCurrency.value = mjc.map((item) => item['title']!).toList();
    selectedCurrency.value = masterJobCurrency.value[0];

    var mje = await homeService.masterJobExperience();
    masterJobExperience.value = mje.map<String>((item) => item['title'].toString()).toList();
    selectedExperience.value = masterJobExperience.value[0];

    var mjp = await homeService.masterJobPeriod();
    masterJobPeriod.value = mjp.map((item) => item['title']!).toList();
    selectedPeriod.value = masterJobPeriod.value[0];

    var mjv = await homeService.masterJobVisa();
    masterJobVisa.value = mjv.map<String>((item) => item['title'].toString()).toList();
    selectedVisa.value = masterJobVisa.value[0];
  }

  String? textValidation(String?  value) {
    if (value == null || value.isEmpty) { return "This form is required!"; }
    return null;
  }


  Future postNewJob() async {
    if (formKey.currentState!.validate()) {
      var jsonbody = jsonEncode({
        "title": selectedTitle.value,
        "department": selectedDepartment.value,
        "yacht_name": yachtController.text,
        "location": locationController.text,
        "min_salary": salaryMinController.text,
        "max_salary": salaryMaxController.text,
        "experience": selectedExperience.value,
        "currency_salary": selectedCurrency.value,
        "period": selectedPeriod.value,
        "description": descriptionController.text,
        "requirements": requirementsController.text,
        "start_date": startDateController.text,
        "duration": durationController.text,
        "urgent": isUrgent.value == true ? "Yes" : "No",
        "feature": isFeatured.value == true ? "Yes" : "No",
        "visa": selectedVisa.value,
        "vacancies": vacanciesController.text ?? "1",
        "deadline": deadlineController.text,
      });

      return await homeService.postNewJob(jsonbody);
    }
  }

}