import 'package:churchappenings/api/guest_chat_api.dart';
import 'package:churchappenings/models/guest_chat_model.dart';
import 'package:churchappenings/pages/departments/guest_chat_controller.dart';
import 'package:churchappenings/widgets/navigate-back-widget.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:get/get.dart';

class GuestChatScreen extends StatefulWidget {
  const GuestChatScreen({Key? key}) : super(key: key);

  @override
  State<GuestChatScreen> createState() => _GuestChatScreenState();
}

class _GuestChatScreenState extends State<GuestChatScreen> {
  final ChatController chatController = Get.put(ChatController());

  TextEditingController _textEditingController = TextEditingController();
  List<String> textList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: navigateToWidget(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Guest Messages",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
                height: 1.5,
              ),
            ),
            Flexible(
              child: Obx(
                () => ListView.builder(
                  reverse: true,
                  itemCount: chatController.chatMessages.length,
                  itemBuilder: (BuildContext context, int index) {
                    final message = chatController.chatMessages[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 13),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(message.userName ?? ""),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Text(
                                message.message ?? " ",
                              ),
                            ),
                          ),
                          Text(message.createdAt.toString())
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: TextField(
              
                controller: _textEditingController,
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: () {
                      String text = _textEditingController.text;
                      if (text.isNotEmpty) {
                        chatController.sendGuestMessage(text);
                        chatController.fetchChatMessages();
                       
                        _textEditingController.clear();
                      }
                    },
                    child: Padding(
                      padding:
                          const EdgeInsets.only(right: 10, top: 5, bottom: 5),
                      child: Container(
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.grey,
                        ),
                        child: Center(
                          child: Text(
                            'Submit',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  labelText: 'Enter your text',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                    // borderRadius: BorderRadius.circular(10.0), // Border radius
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
