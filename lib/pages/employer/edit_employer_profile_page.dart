import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dockwalker/utils/AppColors.dart';
import 'dart:io';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:dockwalker/services/home_service.dart';

class EditEmployerProfilePage extends StatefulWidget {
  const EditEmployerProfilePage({super.key});

  @override
  State<EditEmployerProfilePage> createState() => _EditEmployerProfilePageState();
}

class _EditEmployerProfilePageState extends State<EditEmployerProfilePage> {

  final HomeService homeService = Get.find<HomeService>();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  // Simulated employer data (replace with Get.arguments or controller)
  dynamic employer = {
    'logo': 'https://dockwalkerapp.com/assets/auth/8.jpg',
    'company_name': '',
    'email': '',
    'mobile': '',
    'address': '',
    'website': '',
    'description': '',
  };

  @override
  void initState() {
    super.initState();
    getEmployerInfo();
  }

  Future getEmployerInfo() async {
    dynamic a = await homeService.employerInfo();
    setState(() {
      employer = jsonDecode(a)['result'];
      companyNameController.text = employer['company_name'];
      emailController.text = employer['email'];
      mobileController.text = employer['mobile'];
      addressController.text = employer['address'];
      websiteController.text = employer['website'];
      descriptionController.text = employer['description'];
    });
  }

  final picker = ImagePicker();
  File? _selectedLogo;

  Future<void> _pickLogo() async {
    final picked = await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (picked != null) {
      print(picked.path);
      employer = await homeService.uploadEmployerLogo(picked.path);
      setState(() {
        _selectedLogo = File(picked.path);
      });
    }
  }

  Future _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      employer = await homeService.updateEmployerInfo(
          companyNameController.text,
          mobileController.text,
          addressController.text,
          websiteController.text,
          descriptionController.text
      );
      _formKey.currentState!.save();
    }
  }

  String? textValidation(String?  value) {
    if (value == null || value.isEmpty) { return "This form is required!"; }
    return null;
  }
  String? emailValidation(String?  value) {
    if (value == null || value.isEmpty) { return 'Please enter your email address.'; }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) { return 'Please enter a valid email address.'; }
    return null;
  }
  String? mobileValidation(String?  value) {
    print(value);
    print(value?.length);
    if (value == null || value.isEmpty) { return 'Please enter your mobile number.'; }
    final digitsOnlyRegex = RegExp(r'^\d+$');
    if (!digitsOnlyRegex.hasMatch(value)) { return 'Mobile number must only contain digits.'; }
    if (value.length < 10) { return 'Mobile number must be at least 10 digits long.'; }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(()=> Scaffold(
      appBar: AppBar(
        title: const Text("Update Employer Information"),
        centerTitle: true,
        backgroundColor: AppColors.secondary,
        foregroundColor: Colors.white,
      ),
      body: homeService.urlloading.value == true ?
      Center(child: CircularProgressIndicator()) :
      SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              /// Logo
              GestureDetector(
                onTap: _pickLogo,
                child: Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 48,
                        backgroundColor: Colors.grey.shade200,
                        backgroundImage: _selectedLogo != null ? FileImage(_selectedLogo!) : NetworkImage(employer['logo']!) as ImageProvider,
                        child: _selectedLogo == null && employer['logo'] == null ? Image.asset('assets/logo.png', width: 48, height: 48) : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.secondary,
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(6),
                          child: const Icon(Icons.camera_alt, color: Colors.white, size: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              _buildTextFormField( tlabel: "Company Name", tController: companyNameController, tvalidator: textValidation),
              _buildTextFormField( tlabel: "Email", tController: emailController, tvalidator: emailValidation),
              _buildTextFormField( tlabel: "Mobile", tController: mobileController, tvalidator: mobileValidation),
              _buildTextFormField( tlabel: "Address", tController: addressController, tvalidator: textValidation),
              _buildTextFormField( tlabel: "Website", tController: websiteController, tvalidator: textValidation),
              _buildTextFormField( tlabel: "Description", tController: descriptionController, tvalidator: textValidation, minLine: 4),

              const SizedBox(height: 30),

              /// Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(CupertinoIcons.checkmark_alt, size: 20),
                  label: const Text("Save Changes", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                  onPressed: _saveProfile,
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  /// Reusable text field builder
  Widget _buildTextFormField({
    required String tlabel,
    required TextEditingController tController,
    required FormFieldValidator<String> tvalidator,
    int maxLine= 4,
    int minLine = 1 }) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: tController,
        validator: tvalidator,
        maxLines: maxLine,
        minLines: minLine,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          labelText: tlabel,
          labelStyle: const TextStyle( color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 2, color: Colors.grey),
            borderRadius: BorderRadius.circular(12),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(width: 1, color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(width: 2.0, color: Colors.red),
          ),
        ),
      ),
    );
  }



}
