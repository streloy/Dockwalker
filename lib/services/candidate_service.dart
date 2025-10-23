import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CandidateService extends GetxService {

  var baseurl = "http://localhost/dockwalker/api/";

  Future getData() async {
    var response = await http.get(Uri.parse('https://dummyjson.com/users'));
    dynamic data = await jsonDecode(response.body);
    return data['users'];
  }

  Future login(String email, String password) async {
    var url = Uri.parse('${baseurl}candidate/auth/login');
    var jsonbody = jsonEncode({ "email": email, "password": password });
    try {
      final response = await http.post( url, headers: { "Content-Type": "application/json" }, body: jsonbody );
      if(response.statusCode != 200) {
        var error = jsonDecode(response.body);
        return { "success": false, "message": error.message };
      } else {
        return jsonDecode(response.body);
      }
    } catch (e) {
      return { "success": false, "message": "Error: $e" };
    }
  }

}