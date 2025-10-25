import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dockwalker/pages/employer/message_employer_page.dart';
import 'package:dockwalker/controllers/employer/messages_employer_controller.dart';

class MessagesEmployerPage extends StatefulWidget {
  const MessagesEmployerPage({super.key});

  @override
  State<MessagesEmployerPage> createState() => _MessagesEmployerPageState();
}

class _MessagesEmployerPageState extends State<MessagesEmployerPage> {

  final MessagesEmployerController controller = Get.put(MessagesEmployerController());

  @override
  Widget build(BuildContext context) {
    return Obx(()=> RefreshIndicator(
      onRefresh: controller.getMessages,
      child: controller.homeService.urlloading.value == true ? Center(child: CircularProgressIndicator(strokeWidth: 2)):
      ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: controller.messages.length,
        itemBuilder: (context, index) {
          final msg = controller.messages[index];
          return
            GestureDetector(
              onTap: () { Get.to(()=> MessageEmployerPage(), arguments: { 'title': msg["fullname"], 'employer_id': msg['employer_id'], 'candidate_id': msg['candidate_id'], 'sender_id': msg['sender_id']  }, transition: Transition.rightToLeft); },
              child: ListTile(
                leading: CircleAvatar( backgroundImage: NetworkImage(msg["photo"]!), radius: 24 ),
                title: Text( msg["content"]!, style: const TextStyle(fontWeight: FontWeight.bold) ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text( msg["fullname"]!, maxLines: 1, overflow: TextOverflow.ellipsis ),
                    Text( msg["created_at"]!, style: TextStyle(color: Colors.grey[600], fontSize: 12) )
                  ],
                ),
              ),
            );
        },
      ),
    ));
  }
}
