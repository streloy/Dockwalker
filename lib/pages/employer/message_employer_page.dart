import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dockwalker/utils/AppColors.dart';
import 'package:dockwalker/controllers/employer/message_employer_controller.dart';
import 'package:dockwalker/services/home_service.dart';

class MessageEmployerPage extends StatefulWidget {
  const MessageEmployerPage({super.key});

  @override
  State<MessageEmployerPage> createState() => _MessageEmployerPageState();
}

class _MessageEmployerPageState extends State<MessageEmployerPage> {

  final MessageEmployerController controller = Get.put(MessageEmployerController());
  final HomeService homeService = Get.find<HomeService>();

  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  dynamic params = Get.arguments;

  List<Map<String, dynamic>> messages = [
    {"text": "Hello!", "isMe": false, "time": "10:00 AM"},
    {"text": "Hi! How are you?", "isMe": true, "time": "10:01 AM"},
    {"text": "I’m good, thanks! And you?", "isMe": false, "time": "10:02 AM"},
  ];

  @override
  void initState() {
    super.initState();
    controller.candidate_id.value = params['candidate_id'];
    print(params['candidate_id']);
  }

  Future sendMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      controller.sendMessage(params['candidate_id'], text);
      messages.add({"text": text, "isMe": true, "time": "Now"});
      _controller.clear();
    });

    // Scroll to bottom
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent + 60,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.secondary,
          foregroundColor: Colors.white,
          title: Text("${params['title']}"),
        ),
        body: Obx(()=> RefreshIndicator(
          onRefresh: controller.getMessages,
          child: controller.homeService.urlloading.value == true ? Center(child: CircularProgressIndicator()):
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    controller: _scrollController,
                    padding: const EdgeInsets.all(8),
                    itemCount: controller.messages.length,
                    itemBuilder: (context, index) {
                      final msg = controller.messages[index];
                      return Align(
                        alignment:
                        msg["sender_id"] == msg['employer_id'] ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          padding: EdgeInsets.symmetric( vertical: 10, horizontal: 14),
                          margin: EdgeInsets.symmetric(vertical: 4),
                          constraints: BoxConstraints( maxWidth: MediaQuery.of(context).size.width * 0.7),
                          decoration: BoxDecoration(
                            color: msg["sender_id"] == msg['employer_id'] ? Colors.blue : Colors.grey[300],
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(12),
                              topRight: const Radius.circular(12),
                              bottomLeft: msg["sender_id"] == msg['employer_id'] ? const Radius.circular(12) : const Radius.circular(0),
                              bottomRight: msg["sender_id"] == msg['employer_id'] ? const Radius.circular(0) : const Radius.circular(12),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                msg["content"],
                                style: TextStyle( color: msg["sender_id"] == msg['employer_id'] ? Colors.white : Colors.black ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                msg["created_at"],
                                style: TextStyle( fontSize: 10, color: msg["sender_id"] == msg['employer_id'] ? Colors.white70 : Colors.black54 ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  color: Colors.grey[100],
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _controller,
                          decoration: const InputDecoration(
                            hintText: "Type a message...",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send, color: Colors.blue),
                        onPressed: sendMessage,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ))
    );
  }
}
