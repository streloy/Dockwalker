import 'package:dockwalker/controllers/employer/home_employer_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dockwalker/utils/AppColors.dart';

class HomeEmployerPage extends StatefulWidget {
  const HomeEmployerPage({super.key});

  @override
  State<HomeEmployerPage> createState() => _HomeEmployerPageState();
}

class _HomeEmployerPageState extends State<HomeEmployerPage> {

  final HomeEmployerController _controller = Get.put(HomeEmployerController());

  @override
  Widget build(BuildContext context) {
    return Obx(()=> Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        title: Text(_controller.selectedTitle.value, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white) ),
        actions: [
          if (_controller.selectedIndex.value == 0) TextButton( child: Text("Post Job", style: TextStyle(color: Colors.white)), onPressed: () { } ),
        ],
      ),
      body: _controller.pages[_controller.selectedIndex.value],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _controller.selectedIndex.value,
        onDestinationSelected: _controller.changeIndex,
        destinations: [
          NavigationDestination(icon: Icon(CupertinoIcons.briefcase), selectedIcon: Icon(CupertinoIcons.briefcase_fill, color: AppColors.secondary), label: "Posted"),
          NavigationDestination(icon: Icon(CupertinoIcons.search_circle), selectedIcon: Icon(CupertinoIcons.search_circle_fill, color: AppColors.secondary), label: "Candidates"),
          NavigationDestination(icon: Icon(CupertinoIcons.chat_bubble_2), selectedIcon: Icon(CupertinoIcons.chat_bubble_2_fill, color: AppColors.secondary),label: "Messages"),
          NavigationDestination(icon: Icon(CupertinoIcons.person_circle), selectedIcon: Icon(CupertinoIcons.person_circle_fill, color: AppColors.secondary), label: "Profile"),
        ],
      ),
    ));
  }
}
