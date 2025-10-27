import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class HomeService extends GetxService {

  final dio = Dio();
  var baseurl = "https://dockwalkerapp.com/api/";
  // var baseurl = "http://localhost/dockwalker/api/";
  // var baseurl = "http://192.168.68.102/dockwalker/api/";
  var urlloading = false.obs;
  var loading = false;
  final GetStorage getStorage = GetStorage();

  Future getData() async {
    var response = await http.get(Uri.parse('https://dummyjson.com/users'));
    dynamic data = await jsonDecode(response.body);
    return data['users'];
  }

  // Auth Page
  Future login(String email, String password) async {
    urlloading.value = true;
    var url = Uri.parse('${baseurl}candidate/auth/login');
    var jsonbody = jsonEncode({ "email": email, "password": password, "device": "app" });
    var jsonheader = { "Content-Type": "application/json" };
    try {
      final response = await http.post( url, headers: jsonheader, body: jsonbody );
      urlloading.value = false;
      return response;
    } catch (e) {
      closeMyDialog();
      return { "success": false, "message": "Error: $e" };
    }
  }

  Future register(String email, String mobile, String password, String passwordc) async {
    urlloading.value = true;
    var url = Uri.parse('${baseurl}candidate/auth/registration');
    var jsonbody = jsonEncode({ "email": email, "mobile": mobile, "password": password, "passwordc": passwordc });
    var jsonheader = { "Content-Type": "application/json" };
    try {
      final response = await http.post( url, headers: jsonheader, body: jsonbody );
      urlloading.value = false;
      return response;
    } catch (e) {
      closeMyDialog();
      return { "success": false, "message": "Error: $e" };
    }
  }

  Future registerEmployer(String email, String mobile, String password, String passwordc) async {
    urlloading.value = true;
    var url = Uri.parse('${baseurl}employer/auth/registration');
    var jsonbody = jsonEncode({ "email": email, "mobile": mobile, "password": password, "passwordc": passwordc });
    var jsonheader = { "Content-Type": "application/json" };
    try {
      final response = await http.post( url, headers: jsonheader, body: jsonbody );
      urlloading.value = false;
      return response;
    } catch (e) {
      closeMyDialog();
      return { "success": false, "message": "Error: $e" };
    }
  }

  Future sendResetCode(String email) async {
    showMyDialod("Loading", "Please wait.");
    var url = Uri.parse('${baseurl}candidate/auth/resetcode');
    var jsonbody = jsonEncode({ "email": email});
    var jsonheader = { "Content-Type": "application/json" };
    try {
      final response = await http.post( url, headers: jsonheader, body: jsonbody );
      closeMyDialog();
      return response;
    } catch (e) {
      closeMyDialog();
      return { "success": false, "message": "Error: $e" };
    }
  }

  Future sendResetPassword(String email, String code, String password, String passwordc) async {
    showMyDialod("Loading", "Please wait.");
    var url = Uri.parse('${baseurl}candidate/auth/reset');
    var jsonbody = jsonEncode({ "email": email, "code": code, "password": password, "passwordc": passwordc });
    var jsonheader = { "Content-Type": "application/json" };
    try {
      final response = await http.post( url, headers: jsonheader, body: jsonbody );
      closeMyDialog();
      return response;
    } catch (e) {
      closeMyDialog();
      return { "success": false, "message": "Error: $e" };
    }
  }
  // Auth Page End

  // ---------------------------------
  // Employer APIS
  // ---------------------------------

  Future candidateInfo() async {
    urlloading.value = true;
    var url = Uri.parse('${baseurl}candidate/profile/');
    var token = await getStorage.read("TOKEN").toString();
    var headers = { "Authorization": "${token}" };

    try {
      var response = await http.get( url, headers: headers );
      urlloading.value = false;
      if(response.statusCode != 200) {
        Get.snackbar("Message", jsonDecode(response.body)['message'], snackPosition: SnackPosition.BOTTOM, snackStyle: SnackStyle.GROUNDED);
        return;
      } else {
        return response.body;
      }
    } catch (e) {
      closeMyDialog();
      showDangerSnack("Message", e.toString());
    }
  }

  Future updateCandidateInfo(String fullname, String address, String education, String experience, String skills) async {
    showMyDialod("Loading", "Please wait.");
    var url = Uri.parse('${baseurl}candidate/profile');
    var jsonbody = jsonEncode({ "fullname": fullname, "address": address, "education": education, "experience": experience, "skills": skills });
    var token = await getStorage.read("TOKEN").toString();
    var jsonheader = { "Content-Type": "application/json", "Authorization": "${token}" };
    try {
      final response = await http.post( url, headers: jsonheader, body: jsonbody );
      closeMyDialog();
      if(response.statusCode == 200) {
        var message = jsonDecode(response.body)['message'];
        showSuccessSnack("Message", message);
        return;
      } else {
        showDangerSnack("Message", "Something went wrong!");
      }
      return response;
    } catch (e) {
      closeMyDialog();
      showDangerSnack("Message", e.toString());
    }
  }

  Future uploadPhoto(String photourl) async {
    showMyDialod("Loading", "Please wait.");
    var url = Uri.parse('${baseurl}candidate/profile/photo');
    var token = await getStorage.read("TOKEN").toString();
    var request = http.MultipartRequest('POST', url);
    request.headers['authorization'] = token;
    request.files.add(await http.MultipartFile.fromPath('file', photourl));
    try {
      var response = await request.send();
      closeMyDialog();
      if(response.statusCode == 200) {
        var body = await response.stream.bytesToString();
        var message = jsonDecode(body)['message'];
        showSuccessSnack("Message", message);
        return;
      } else {
        var body = await response.stream.bytesToString();
        var message = jsonDecode(body)['message'];
        showDangerSnack("Message", message);
      }
      return response;
    } catch (e) {
      closeMyDialog();
      showDangerSnack("Message", e.toString());
    }
  }

  Future uploadFile(String photourl) async {
    showMyDialod("Loading", "Please wait.");
    var url = Uri.parse('${baseurl}candidate/profile/resume');
    var token = await getStorage.read("TOKEN").toString();
    var request = http.MultipartRequest('POST', url);
    request.headers['authorization'] = token;
    request.files.add(await http.MultipartFile.fromPath('file', photourl));
    try {
      var response = await request.send();
      // var body = await response.stream.bytesToString();
      closeMyDialog();
      return response;
      // if(response.statusCode == 200) {
      //   var message = jsonDecode(body)['message'];
      //   showSuccessSnack("Message", message);
      // } else {
      //   var message = jsonDecode(body)['message'];
      //   showDangerSnack("Message", message);
      // }
    } catch (e) {
      closeMyDialog();
      showDangerSnack("Message", e.toString());
    }
  }

  Future getJob(var page) async {
    loading = true;
    urlloading.value = true;
    var url = Uri.parse('${baseurl}candidate/jobs?limit=20&page=${page}');
    var token = await getStorage.read("TOKEN").toString();
    var headers = { "authorization": "${token}" };
    try {
      var response = await http.get( url, headers: headers );
      loading = false;
      urlloading.value = false;
      if(response.statusCode != 200) {
        Get.snackbar("Message", jsonDecode(response.body)['message'], snackPosition: SnackPosition.BOTTOM, snackStyle: SnackStyle.GROUNDED);
        return;
      } else {
        return response.body;
      }
    } catch (e) {
      closeMyDialog();
      showDangerSnack("Message", e.toString());
    }
  }

  Future getJobDetail (var jobid) async {
    urlloading.value = true;
    var url = Uri.parse('${baseurl}candidate/jobs?id=${jobid}');
    var token = await getStorage.read("TOKEN").toString();
    var headers = { "authorization": "${token}" };
    try {
      var response = await http.get( url, headers: headers );
      urlloading.value = false;
      if(response.statusCode != 200) {
        Get.snackbar("Message", jsonDecode(response.body)['message'], snackPosition: SnackPosition.BOTTOM, snackStyle: SnackStyle.GROUNDED);
        return;
      } else {
        return response.body;
      }
    } catch (e) {
      closeMyDialog();
      showDangerSnack("Message", e.toString());
    }
  }

  Future checkapply(var jobid) async {
    var url = Uri.parse('${baseurl}candidate/jobs/checkapply?id=${jobid}');
    var token = await getStorage.read("TOKEN").toString();
    var headers = { "authorization": "${token}" };
    try {
      var response = await http.get( url, headers: headers );
      return response.statusCode;
    } catch (e) {
      showDangerSnack("Message", e.toString());
    }
  }

  Future apply(var job_id, var expected_salary) async {
    showMyDialod("Loading", "Please wait.");
    var url = Uri.parse('${baseurl}candidate/jobs/apply');
    var token = await getStorage.read("TOKEN").toString();
    var headers = { "authorization": "${token}" };
    var jsonbody = jsonEncode({ "job_id": job_id, "expected_salary": expected_salary });
    try {
      var response = await http.post( url, headers: headers, body: jsonbody );
      var body = jsonDecode(response.body);
      closeMyDialog();
      if(response.statusCode == 200) { showSuccessSnack("Message", body['message']); }
      else { showDangerSnack("Message", body['message']); }
      return response.statusCode;
    } catch (e) {
      closeMyDialog();
      showDangerSnack("Message", e.toString());
    }
  }

  Future getAppliedJobs() async {
    showMyDialod("Loading", "Please wait.");
    var url = Uri.parse('${baseurl}candidate/jobs/appliedjob');
    var token = await getStorage.read("TOKEN").toString();
    var headers = { "authorization": "${token}" };
    try {
      var response = await http.get( url, headers: headers );
      closeMyDialog();
      if(response.statusCode != 200) {
        Get.snackbar("Message", jsonDecode(response.body)['message'], snackPosition: SnackPosition.BOTTOM, snackStyle: SnackStyle.GROUNDED);
        return;
      } else {
        return jsonDecode(response.body)['result'];
      }
    } catch (e) {
      closeMyDialog();
      showDangerSnack("Message", e.toString());
    }
  }

  Future getMessages() async {
    urlloading.value = true;
    var url = Uri.parse('${baseurl}candidate/messages');
    var token = await getStorage.read("TOKEN").toString();
    var headers = { "authorization": "${token}" };
    try {
      var response = await http.get( url, headers: headers );
      urlloading.value = false;
      if(response.statusCode != 200) {
        Get.snackbar("Message", jsonDecode(response.body)['message'], snackPosition: SnackPosition.BOTTOM, snackStyle: SnackStyle.GROUNDED);
        return;
      } else {
        return jsonDecode(response.body)['result'];
      }
    } catch (e) {
      closeMyDialog();
      showDangerSnack("Message", e.toString());
    }
  }

  Future getMessageDetail(var employer_id) async {
    urlloading.value = true;
    var url = Uri.parse('${baseurl}candidate/messages/detail?employer_id=${employer_id}');
    var token = await getStorage.read("TOKEN").toString();
    var headers = { "authorization": "${token}" };
    try {
      var response = await http.get( url, headers: headers );
      urlloading.value = false;
      if(response.statusCode != 200) {
        Get.snackbar("Message", jsonDecode(response.body)['message'], snackPosition: SnackPosition.BOTTOM, snackStyle: SnackStyle.GROUNDED);
        return;
      } else {
        return jsonDecode(response.body)['result'];
      }
    } catch (e) {
      closeMyDialog();
      showDangerSnack("Message", e.toString());
    }
  }

  Future sendMessage(var employer_id, var content) async {
    var url = Uri.parse('${baseurl}candidate/messages');
    var jsonbody = jsonEncode({ "employer_id": employer_id, "content": content });
    var token = await getStorage.read("TOKEN").toString();
    var jsonheader = { "authorization": "${token}" };
    try {
      final response = await http.post( url, headers: jsonheader, body: jsonbody );
      if(response.statusCode != 200) {
        showDangerSnack("Message", jsonDecode(response.body)['message']);
      }
    } catch (e) {
      showDangerSnack("Message", e.toString());
    }
  }

  // ---------------------------------
  // Employer APIS
  // ---------------------------------

  Future getEmployerJob(var page) async {
    loading = true;
    urlloading.value = true;
    var url = Uri.parse('${baseurl}employer/jobs?limit=200&page=${page}');
    var token = await getStorage.read("TOKEN").toString();
    var headers = { "authorization": "${token}" };
    try {
      var response = await http.get( url, headers: headers );
      loading = false;
      urlloading.value = false;
      if(response.statusCode != 200) {
        showDangerSnack("Message", jsonDecode(response.body)['message']);
        return;
      } else {
        return response.body;
      }
    } catch (e) {
      closeMyDialog();
      showDangerSnack("Message", e.toString());
    }
  }

  Future getJobAppliedCandidates(var jid) async {
    loading = true;
    urlloading.value = true;
    var url = Uri.parse('${baseurl}employer/jobs/appied_candidates?jid=${jid}');
    var token = await getStorage.read("TOKEN").toString();
    var headers = { "authorization": "${token}" };
    try {
      var response = await http.get( url, headers: headers );
      loading = false;
      urlloading.value = false;
      if(response.statusCode != 200) {
        showDangerSnack("Message", jsonDecode(response.body)['message']);
        return;
      } else {
        return response.body;
      }
    } catch (e) {
      closeMyDialog();
      showDangerSnack("Message", e.toString());
    }
  }

  Future getCandidateList(var page) async {
    loading = true;
    urlloading.value = true;
    var url = Uri.parse('${baseurl}employer/candidate?limit=200&page=${page}');
    var token = await getStorage.read("TOKEN").toString();
    var headers = { "authorization": "${token}" };
    try {
      var response = await http.get( url, headers: headers );
      loading = false;
      urlloading.value = false;
      if(response.statusCode != 200) {
        showDangerSnack("Message", jsonDecode(response.body)['message']);
        return;
      } else {
        return response.body;
      }
    } catch (e) {
      closeMyDialog();
      showDangerSnack("Message", e.toString());
    }
  }

  Future getCandidateDetail (var candidateId) async {
    urlloading.value = true;
    var url = Uri.parse('${baseurl}candidate/candidate?id=${candidateId}');
    var token = await getStorage.read("TOKEN").toString();
    var headers = { "authorization": "${token}" };
    try {
      var response = await http.get( url, headers: headers );
      urlloading.value = false;
      if(response.statusCode != 200) {
        showDangerSnack("Message", jsonDecode(response.body)['message']);
        return;
      } else {
        return response.body;
      }
    } catch (e) {
      closeMyDialog();
      showDangerSnack("Message", e.toString());
    }
  }

  Future getEmployerMessages() async {
    urlloading.value = true;
    var url = Uri.parse('${baseurl}employer/messages');
    var token = await getStorage.read("TOKEN").toString();
    var headers = { "authorization": "${token}" };
    try {
      var response = await http.get( url, headers: headers );
      urlloading.value = false;
      if(response.statusCode != 200) {
        showDangerSnack("Message", jsonDecode(response.body)['message']);
        return;
      } else {
        return jsonDecode(response.body)['result'];
      }
    } catch (e) {
      closeMyDialog();
      showDangerSnack("Message", e.toString());
    }
  }

  Future getEmployerMessageDetail(var candidate_id) async {
    urlloading.value = true;
    var url = Uri.parse('${baseurl}employer/messages/detail?candidate_id=${candidate_id}');
    var token = await getStorage.read("TOKEN").toString();
    var headers = { "authorization": "${token}" };
    try {
      var response = await http.get( url, headers: headers );
      urlloading.value = false;
      if(response.statusCode != 200) {
        showDangerSnack("Message", jsonDecode(response.body)['message']);
        return;
      } else {
        return jsonDecode(response.body)['result'];
      }
    } catch (e) {
      closeMyDialog();
      showDangerSnack("Message", e.toString());
    }
  }

  Future sendEmployerMessage(var candidate_id, var content) async {
    var url = Uri.parse('${baseurl}employer/messages');
    var jsonbody = jsonEncode({ "candidate_id": candidate_id, "content": content });
    var token = await getStorage.read("TOKEN").toString();
    var jsonheader = { "authorization": "${token}" };
    try {
      final response = await http.post( url, headers: jsonheader, body: jsonbody );
      if(response.statusCode != 200) {
        showDangerSnack("Message", jsonDecode(response.body)['message']);
      }
    } catch (e) {
      showDangerSnack("Message", e.toString());
    }
  }

  Future employerInfo() async {
    urlloading.value = true;
    var url = Uri.parse('${baseurl}employer/profile/');
    var token = await getStorage.read("TOKEN").toString();
    var headers = { "Authorization": "${token}" };

    try {
      var response = await http.get( url, headers: headers );
      urlloading.value = false;
      if(response.statusCode != 200) {
        showDangerSnack("Message", jsonDecode(response.body)['message']);
        return;
      } else {
        return response.body;
      }
    } catch (e) {
      closeMyDialog();
      showDangerSnack("Message", e.toString());
    }
  }

  Future updateEmployerInfo(String company_name, String mobile, String address, String website, String description) async {
    showMyDialod("Loading", "Please wait.");
    var url = Uri.parse('${baseurl}employer/profile');
    var jsonbody = jsonEncode({ "company_name": company_name, "mobile": mobile, "address": address, "website": website, "description": description });
    var token = await getStorage.read("TOKEN").toString();
    var jsonheader = { "Content-Type": "application/json", "Authorization": "${token}" };
    try {
      final response = await http.post( url, headers: jsonheader, body: jsonbody );
      closeMyDialog();
      if(response.statusCode == 200) {
        var data = jsonDecode(response.body);
        showSuccessSnack("Message", data['message']);
        return data['result'];
      } else {
        showDangerSnack("Message", "Something went wrong!");
      }
      return response;
    } catch (e) {
      closeMyDialog();
      showDangerSnack("Message", e.toString());
    }
  }

  Future uploadEmployerLogo(String photourl) async {
    showMyDialod("Loading", "Please wait.");
    var url = Uri.parse('${baseurl}employer/profile/logo');
    var token = await getStorage.read("TOKEN").toString();
    var request = http.MultipartRequest('POST', url);
    request.headers['authorization'] = token;
    request.files.add(await http.MultipartFile.fromPath('file', photourl));
    try {
      var response = await request.send();
      closeMyDialog();
      if(response.statusCode == 200) {
        var body = await response.stream.bytesToString();
        var data = jsonDecode(body);
        showSuccessSnack("Message", data['message']);
        return data['result'];
      } else {
        var body = await response.stream.bytesToString();
        var message = jsonDecode(body)['message'];
        showDangerSnack("Message", message);
      }
      return response;
    } catch (e) {
      closeMyDialog();
      showDangerSnack("Message", e.toString());
    }
  }

  Future masterJobDepartment() async {
    urlloading.value = true;
    var url = Uri.parse('${baseurl}employer/jobs/master_job_department');
    var token = await getStorage.read("TOKEN").toString();
    var headers = { "Authorization": "${token}" };

    try {
      var response = await http.get( url, headers: headers );
      urlloading.value = false;
      if(response.statusCode != 200) {
        showDangerSnack("Message", jsonDecode(response.body)['message']);
        return;
      } else {
        return jsonDecode(response.body)['result'];
      }
    } catch (e) {
      closeMyDialog();
      showDangerSnack("Message", e.toString());
    }
  }

  Future masterJobCurrency() async {
    urlloading.value = true;
    var url = Uri.parse('${baseurl}employer/jobs/master_job_currency');
    var token = await getStorage.read("TOKEN").toString();
    var headers = { "Authorization": "${token}" };
    try {
      var response = await http.get( url, headers: headers );
      urlloading.value = false;
      if(response.statusCode != 200) {
        showDangerSnack("Message", jsonDecode(response.body)['message']);
        return;
      } else {
        return jsonDecode(response.body)['result'];
      }
    } catch (e) {
      closeMyDialog();
      showDangerSnack("Message", e.toString());
    }
  }

  Future masterJobExperience() async {
    urlloading.value = true;
    var url = Uri.parse('${baseurl}employer/jobs/master_job_experience');
    var token = await getStorage.read("TOKEN").toString();
    var headers = { "Authorization": "${token}" };
    try {
      var response = await http.get( url, headers: headers );
      urlloading.value = false;
      if(response.statusCode != 200) {
        showDangerSnack("Message", jsonDecode(response.body)['message']);
        return;
      } else {
        return jsonDecode(response.body)['result'];
      }
    } catch (e) {
      closeMyDialog();
      showDangerSnack("Message", e.toString());
    }
  }

  Future masterJobPeriod() async {
    urlloading.value = true;
    var url = Uri.parse('${baseurl}employer/jobs/master_job_period');
    var token = await getStorage.read("TOKEN").toString();
    var headers = { "Authorization": "${token}" };
    try {
      var response = await http.get( url, headers: headers );
      urlloading.value = false;
      if(response.statusCode != 200) {
        showDangerSnack("Message", jsonDecode(response.body)['message']);
        return;
      } else {
        return jsonDecode(response.body)['result'];
      }
    } catch (e) {
      closeMyDialog();
      showDangerSnack("Message", e.toString());
    }
  }

  Future masterJobVisa() async {
    urlloading.value = true;
    var url = Uri.parse('${baseurl}employer/jobs/master_job_visa');
    var token = await getStorage.read("TOKEN").toString();
    var headers = { "Authorization": "${token}" };
    try {
      var response = await http.get( url, headers: headers );
      urlloading.value = false;
      if(response.statusCode != 200) {
        showDangerSnack("Message", jsonDecode(response.body)['message']);
        return;
      } else {
        return jsonDecode(response.body)['result'];
      }
    } catch (e) {
      closeMyDialog();
      showDangerSnack("Message", e.toString());
    }
  }

  Future postNewJob(var jsonbody) async {
    urlloading.value = true;
    var url = Uri.parse('${baseurl}employer/jobs');
    var jsonheader = { "Content-Type": "application/json" };
    var token = await getStorage.read("TOKEN").toString();
    var headers = { "Authorization": "${token}" };
    try {
      final response = await http.post( url, headers: headers, body: jsonbody );
      urlloading.value = false;
      if(response.statusCode != 200) {
        showDangerSnack("Message", jsonDecode(response.body)['message']);
        return;
      } else {
        showSuccessSnack("Message", jsonDecode(response.body)['message']);
        return true;
      }
    } catch (e) {
      return { "success": false, "message": "Error: $e" };
    }
  }

  showMyDialod(var title, var message) {
    Get.dialog(
      AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 12),
            Text(message),
          ],
        ),
      ),
      barrierDismissible: true,
    );


  }

  closeMyDialog() {
    if (Get.isDialogOpen ?? false) { Get.back(); }
  }

  showDangerSnack(String title, String message) {
    Get.snackbar(title, message, snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white, isDismissible: true, duration: Duration(seconds: 3) );
  }

  showSuccessSnack(String title, String message) {
    Get.snackbar(title, message, snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green, colorText: Colors.white, isDismissible: true, duration: Duration(seconds: 3) );
  }

}