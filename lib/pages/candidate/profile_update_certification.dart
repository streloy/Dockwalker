import 'package:flutter/material.dart';
import 'package:dockwalker/utils/AppColors.dart';
import 'package:dockwalker/services/home_service.dart';
import 'package:get/get.dart';
import 'dart:convert';

class ProfileUpdateCertification extends StatefulWidget {
  const ProfileUpdateCertification({super.key});

  @override
  State<ProfileUpdateCertification> createState() => _ProfileUpdateCertificationState();
}

class _ProfileUpdateCertificationState extends State<ProfileUpdateCertification> {

  final HomeService homeService = Get.find<HomeService>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController sourceController = TextEditingController();
  final TextEditingController issueController = TextEditingController();
  final TextEditingController expireController = TextEditingController();

  bool noExpiry = false;

  String? inputValidation(String?  value) {
    if (value == null || value.isEmpty) { return "Input field can not be empty!"; }
    return null;
  }

  String? dateValidation(String? value) {
    if (value == null || value.isEmpty) { return "Please enter a date"; }
    final RegExp dateRegEx = RegExp(r'^\d{4}-\d{2}-\d{2}$');
    if (!dateRegEx.hasMatch(value)) { return "Enter date in YYYY-MM-DD format"; }
    return null;
  }

  String? expireDateValidation(String? value) {
    if (value == null || value.isEmpty) { return "Please enter a date"; }
    final RegExp dateRegEx = RegExp(r'^\d{4}-\d{2}-\d{2}$');
    if(noExpiry == false) {
      if (!dateRegEx.hasMatch(value)) { return "Enter date in YYYY-MM-DD format"; }
    }
    return null;
  }

  Future updateInformation() async {
    if (formKey.currentState!.validate()) {
      var response = await homeService.candidateUpdateCertificate(
          nameController.text,
          sourceController.text,
          issueController.text,
          expireController.text
      );
      var body = jsonDecode(response.body);
      var statusCode = response.statusCode;
      if (statusCode == 200) {
        setState(() {
          Get.back(result: true);
          Get.snackbar("Message", body['message'], backgroundColor: Colors.green, colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
        });
      } else {
        Get.snackbar("Message", body['message'], backgroundColor: Colors.red, colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Certificate"),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: 16),
              Container(
                margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: TextFormField(
                  controller: nameController,
                  validator: inputValidation,
                  maxLines: null,
                  style: const TextStyle(color: AppColors.secondary),
                  decoration: InputDecoration(
                    labelText: "Name",
                    labelStyle: const TextStyle(color: AppColors.secondary),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.secondary, width: 1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.secondary, width: 2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(color: Colors.red, width: 1),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(color: Colors.red, width: 2.0),
                    ),
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: TextFormField(
                  controller: sourceController,
                  validator: inputValidation,
                  maxLines: null,
                  style: const TextStyle(color: AppColors.secondary),
                  decoration: InputDecoration(
                    labelText: "Source",
                    labelStyle: const TextStyle(color: AppColors.secondary),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.secondary, width: 1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.secondary, width: 2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(color: Colors.red, width: 1),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(color: Colors.red, width: 2.0),
                    ),
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: TextFormField(
                  controller: issueController,
                  validator: dateValidation,
                  maxLines: null,
                  style: const TextStyle(color: AppColors.secondary),
                  decoration: InputDecoration(
                    labelText: "Issue Date",
                    hintText: "2020-01-01",
                    labelStyle: const TextStyle(color: AppColors.secondary),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.secondary, width: 1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.secondary, width: 2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(color: Colors.red, width: 1),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(color: Colors.red, width: 2.0),
                    ),
                  ),
                ),
              ),

              // Toggle Switch for "No Expiry Date"
              Container(
                margin: EdgeInsets.only(left: 16, right: 16, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text( "No Expiry Date", style: TextStyle( color: AppColors.secondary, fontSize: 16, fontWeight: FontWeight.w500, ), ),
                    Switch(
                      value: noExpiry,
                      activeColor: AppColors.secondary,
                      onChanged: (value) {
                        setState(() {
                          noExpiry = value;
                          if (noExpiry) {
                            expireController.text = "No expire date";
                          } else {
                            expireController.clear();
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: TextFormField(
                  controller: expireController,
                  validator: expireDateValidation,
                  maxLines: null,
                  readOnly: noExpiry,
                  style: const TextStyle(color: AppColors.secondary),
                  decoration: InputDecoration(
                    labelText: "Expire Date",
                    hintText: "2030-01-01",
                    labelStyle: const TextStyle(color: AppColors.secondary),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.secondary, width: 1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.secondary, width: 2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(color: Colors.red, width: 1),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(color: Colors.red, width: 2.0),
                    ),
                  ),
                ),
              ),

              Container(
                width: double.infinity,
                margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.secondary, width: 1),
                    foregroundColor: Colors.white,
                    backgroundColor: AppColors.secondary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                  onPressed: () {
                    updateInformation();
                  },
                  icon: Obx(()=> homeService.urlloading.value == true ? Text("") : Icon(Icons.login, size: 18, color: Colors.white ) ),
                  label: Obx(()=> homeService.urlloading.value == true ? SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white) ) : Text( "Add Certificate", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white ) ))
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
