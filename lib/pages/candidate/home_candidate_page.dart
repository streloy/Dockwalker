import 'package:dockwalker/controllers/candidate/home_candidate_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dockwalker/utils/AppColors.dart';

class HomeCandidatePage extends StatefulWidget {
  const HomeCandidatePage({super.key});

  @override
  State<HomeCandidatePage> createState() => _HomeCandidatePageState();
}

class _HomeCandidatePageState extends State<HomeCandidatePage> {

  final HomeCandidateController _controller = Get.put(HomeCandidateController());

  @override
  Widget build(BuildContext context) {
    return Obx(()=> Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondary,
        title: Text(_controller.selectedTitle.value, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white) ),
      ),
      body: _controller.pages[_controller.selectedIndex.value],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _controller.selectedIndex.value,
        onDestinationSelected: _controller.changeIndex,
        destinations: [
          NavigationDestination(icon: Icon(CupertinoIcons.briefcase), selectedIcon: Icon(CupertinoIcons.briefcase_fill, color: AppColors.secondary), label: "Jobs"),
          NavigationDestination(icon: Icon(CupertinoIcons.search_circle), selectedIcon: Icon(CupertinoIcons.search_circle_fill, color: AppColors.secondary), label: "Search"),
          NavigationDestination(icon: Icon(CupertinoIcons.chat_bubble_2), selectedIcon: Icon(CupertinoIcons.chat_bubble_2_fill, color: AppColors.secondary),label: "Messages"),
          NavigationDestination(icon: Icon(CupertinoIcons.person_circle), selectedIcon: Icon(CupertinoIcons.person_circle_fill, color: AppColors.secondary), label: "Profile"),
        ],
      ),
    ));
  }
}
