import 'package:dockwalker/services/home_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  HomeService homeService = Get.find();
  var userList = [].obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  Future getUserData() async {
    userList.value = await homeService.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.home),
        title: Text("Dockwalker"),
        titleSpacing: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Flexible(
              child: Obx(() {
                return ListView.builder(
                  itemCount: userList.length,
                  itemBuilder: (BuildContext context, int index) {
                    dynamic item = userList[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(item['image']),
                      ),
                      title: Text(item['username']),
                      subtitle: Text(item['email']),
                    );
                  },
                );
              })
            )
          ],
        ),
      ),
    );
  }
}
