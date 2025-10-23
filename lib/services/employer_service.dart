import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class EmployerService extends GetxService {

  var baseurl = "http://localhost/dockwalker/api/";

  Future getData() async {
    var response = await http.get(Uri.parse('https://dummyjson.com/users'));
    dynamic data = await jsonDecode(response.body);
    return data['users'];
  }

  Future login() async {
    // var response = await http.get(Uri.parse(''));
  }
}