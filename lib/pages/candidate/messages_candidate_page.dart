import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dockwalker/pages/candidate/message_candidate_page.dart';
import 'package:dockwalker/controllers/candidate/messages_candidate_controller.dart';

class MessagesCandidatePage extends StatefulWidget {
  const MessagesCandidatePage({super.key});

  @override
  State<MessagesCandidatePage> createState() => _MessagesCandidatePageState();
}

class _MessagesCandidatePageState extends State<MessagesCandidatePage> {

  final MessagesCandidateController controller = Get.put(MessagesCandidateController());

  @override
  Widget build(BuildContext context) {
    return Obx(()=> RefreshIndicator(
      onRefresh: controller.getMessages,
      child: controller.homeService.urlloading.value == true ? Center(child: CircularProgressIndicator(strokeWidth: 2)):
      ListView.builder(
        itemCount: controller.messages.length,
        itemBuilder: (context, index) {
          final msg = controller.messages[index];
          return
            GestureDetector(
              onTap: () { Get.to(()=> MessageCandidatePage(), arguments: { 'title': msg["company_name"], 'employer_id': msg['employer_id'], 'candidate_id': msg['candidate_id'], 'sender_id': msg['sender_id']  }, transition: Transition.rightToLeft); },
              child: ListTile(
                leading: CircleAvatar( backgroundImage: NetworkImage(msg["logo"]!), radius: 24 ),
                title: Text( msg["content"]!, style: const TextStyle(fontWeight: FontWeight.bold) ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text( msg["company_name"]!, maxLines: 1, overflow: TextOverflow.ellipsis ),
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
