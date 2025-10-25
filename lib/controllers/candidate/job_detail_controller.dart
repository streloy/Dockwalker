import 'package:dockwalker/services/home_service.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter/material.dart';

class JobDetailController extends GetxController {

  final HomeService homeService = Get.find<HomeService>();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController salaryController = TextEditingController();

  var userid = "".obs;
  var jobid = "".obs;
  var jobdata = {}.obs;
  var isapplied = 0.obs;

  @override
  void onReady() {
    userInfo();
  }

  Future userInfo() async {
    var response = await homeService.candidateInfo();
    if(response.isNull) { return; }
    var result = jsonDecode(response)['result'];
    userid.value = result['user_id'];
  }

  Future<void> getData() async {
    var response = await homeService.getJobDetail(jobid.value);
    var data = jsonDecode(response)['result'];
    jobdata.value = data;
    checkApply();
  }

  Future checkApply() async {
    var statuscode = await homeService.checkapply(jobid.value);
    isapplied.value = statuscode;
  }

  Future applyForJob() async {
    if (formKey.currentState!.validate()) {
      Get.back();
      await homeService.apply(jobid.value, salaryController.text);
      isapplied.value = 401;
    }
  }

  Future showApplyDialog() async {
    Get.defaultDialog(
      title: "Enter Expected Salary",
      titleStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      titlePadding: EdgeInsets.only(top: 20),
      contentPadding: const EdgeInsets.all(16),
      content: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              controller: salaryController,
              validator: salaryValidation,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Expected Salary",
                labelStyle: const TextStyle(),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 1),
                  borderRadius: BorderRadius.circular(4),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 2),
                  borderRadius: BorderRadius.circular(4),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(width: 1),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(width: 2.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton( onPressed: () => Get.back(), child: const Text("Cancel") ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    applyForJob();
                  },
                  child: const Text("Submit"),
                ),
              ],
            )
          ],
        ),
      )
    );
  }

  String? salaryValidation(String? value) {
    if (value == null || value.isEmpty) { return "Please enter your expected salary"; }
    return null;
  }

}