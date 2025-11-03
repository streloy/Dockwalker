import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';
import 'package:dockwalker/controllers/candidate/profile_update_controller.dart';
import 'package:get/get.dart';
import 'package:dockwalker/utils/AppColors.dart';
import 'package:dockwalker/services/home_service.dart';
// import 'package:flutter_quill/flutter_quill.dart' hide Text;
// import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';

class ProfileUpdatePage extends StatefulWidget {
  const ProfileUpdatePage({super.key});

  @override
  State<ProfileUpdatePage> createState() => _ProfileUpdatePageState();
}

class _ProfileUpdatePageState extends State<ProfileUpdatePage> {

  final ProfileUpdateController _controller = Get.put(ProfileUpdateController());
  final HomeService homeService = Get.find<HomeService>();

  File? _photoFile = null;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickPhoto() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery); // or ImageSource.camera
    if (pickedFile != null) {
      setState(() => _photoFile = File(pickedFile.path));
      print("Uploading photo: ${pickedFile.path}");
      homeService.uploadPhoto(pickedFile.path);
    }
  }

  Future<void> pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
      );

      if (result != null) {
        if (result.files.single.bytes != null) {
          Uint8List fileBytes = result.files.single.bytes!;
          String fileName = result.files.single.name;
          print("Picked file (web/desktop): $fileName, size: ${fileBytes.length}");
        } else {
          // Mobile (file path available)
          File file = File(result.files.single.path!);
          print("Picked file (mobile): ${file.path}");
          var response = await homeService.uploadFile(file.path);
          var body = await response.stream.bytesToString();
          if(response.statusCode == 200) {
            var message = jsonDecode(body)['message'];
            _controller.resumeurl.value = jsonDecode(body)['result']['resumeurl'];
            showSuccessSnack("Message", message);
          } else {
            var message = jsonDecode(body)['message'];
            showDangerSnack("Message", message);
          }
        }
      } else {
        print("No file selected");
      }
    } catch (e) {
      print("Error picking file: $e");
    }
  }

  showDangerSnack(String title, String message) {
    Get.snackbar(title, message, snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white, isDismissible: true, duration: Duration(seconds: 3) );
  }

  showSuccessSnack(String title, String message) {
    Get.snackbar(title, message, snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green, colorText: Colors.white, isDismissible: true, duration: Duration(seconds: 3) );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        foregroundColor: Colors.white,
        title: const Text("Update Profile"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Obx(()=>
                    _photoFile != null ?
                    CircleAvatar( radius: 60, backgroundImage:  FileImage(_photoFile!) ) :
                    _controller.photourl.value.isNotEmpty ?
                    CircleAvatar( radius: 60, backgroundImage: NetworkImage(_controller.photourl.value + "?ts=${DateTime.now().millisecondsSinceEpoch}"), onBackgroundImageError: (exception, stackTrace) { print(exception); } ) :
                    CircleAvatar( radius: 60, child: CircularProgressIndicator()),

                  ),


                  Positioned(
                    bottom: 4,
                    right: 4,
                    child: InkWell(
                      onTap: _pickPhoto,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),
            Text("Resume (Only PDF)", textAlign: TextAlign.start, style: TextStyle(fontWeight: FontWeight.bold),),
            SizedBox(height: 6),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.primary, width: 1),
                      foregroundColor: Colors.white,
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                    onPressed: () { _controller.openResume(); },
                    icon: Icon(Icons.view_agenda, size: 12 ),
                    label: const Text( "View", style: TextStyle( color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold ), ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.secondary, width: 1),
                      foregroundColor: Colors.white,
                      backgroundColor: AppColors.secondary,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                    onPressed: () { pickFile(); },
                    icon: Icon(Icons.upload_file, size: 12 ),
                    label: const Text( "Upload", style: TextStyle( color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold ), ),
                  ),
                ),

                SizedBox(width: 16),
                Expanded(
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.red, width: 1),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                    onPressed: () { },
                    icon: Icon(Icons.delete, size: 12 ),
                    label: const Text( "Delete", style: TextStyle( color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold ), ),
                  ),
                ),
              ],
            ),

            Form(
              key: _controller.formKey,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: TextFormField(
                      controller: _controller.fullnameController,
                      maxLines: null,
                      style: const TextStyle(color: AppColors.secondary),
                      decoration: InputDecoration(
                        labelText: "Fullname",
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

                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: TextFormField(
                      controller: _controller.addressController,
                      maxLines: null,
                      style: const TextStyle(color: AppColors.secondary),
                      decoration: InputDecoration(
                        labelText: "Address",
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

                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: TextFormField(
                      controller: _controller.detailController,
                      maxLines: null,
                      minLines: 4,
                      style: const TextStyle(color: AppColors.secondary),
                      decoration: InputDecoration(
                        labelText: "Candidate Detail",
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
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: TextFormField(
                      controller: _controller.availableController,
                      validator: _controller.availabilityValidation,
                      maxLines: null,
                      style: const TextStyle(color: AppColors.secondary),
                      decoration: InputDecoration(
                        labelText: "Candidate Availability",
                        hintText: "e.g. Yes/No",
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

                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
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
                      onPressed: () { _controller.updateProfile(); },
                      icon: Icon(Icons.login_outlined, size: 18 ),
                      label: const Text( "Update Info", style: TextStyle( color: Colors.white, fontWeight: FontWeight.bold ), ),
                    ),
                  ),
                  SizedBox(height: 50)
                ],
              )
            )


          ],
        ),
      ),
    );
  }

}
