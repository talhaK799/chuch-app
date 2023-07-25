import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../models/chat.dart';
import 'departments-controller.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.privatePostId});
  final String privatePostId;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<String> messages = [];

  // TextEditingController messageController = TextEditingController();

  // void sendMessage() {
  //   setState(() {
  //     String message = messageController.text;
  //     messages.add(message);
  //     messageController.clear();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Chat Screen'),
        ),
        body: GetBuilder<DepartmentController>(
            init: DepartmentController("ChatScreen", true),
            global: false,
            builder: (_) {
              if (_.loading) {
                return Center(child: CircularProgressIndicator());
              }
              return Column(
                children: [
                  // Expanded(
                  //   child: FirebaseAnimatedList(
                  //     controller: _scrollController,
                  //     query: widget.messageDao.getMessageQuery(),
                  //     itemBuilder: (context, snapshot, animation, index) {
                  //       final json = snapshot.value as Map<dynamic, dynamic>;
                  //       final message = Message.fromJson(json);
                  //       return MessageWidget(message.text, message.date);
                  //     },
                  //   ),
                  // ),
                  Expanded(
                    child: Obx(
                      () => ListView.builder(
                        itemCount: _.chatList.length,
                        shrinkWrap: true,
                        reverse: true,
                        itemBuilder: (context, index) {
                          ChatModel chat = _.chatList[index];
                          String message = chat.message!;
                          DateTime date = chat.date!;
                          String id = chat.id!;

                          bool isCurrentUser = id == _.getCurrentUserId();

                          var alignment = isCurrentUser
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start;
                          return Container(
                            child: Row(
                              mainAxisAlignment: alignment,
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 14,
                                        right: 14,
                                        top: 10,
                                        bottom: 10),
                                    child: Align(
                                      alignment: isCurrentUser
                                          ? Alignment.topRight
                                          : Alignment.topLeft,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: isCurrentUser
                                              ? Colors.blue[200]
                                              : Colors.grey.shade200,
                                        ),
                                        padding: EdgeInsets.all(16),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              message,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "${date.hour}:${date.minute}:${date.second}",
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  // Expanded(
                  //   child: ListView.builder(
                  //     itemCount: messages.length,
                  //     itemBuilder: (context, index) {
                  //       return ListTile(
                  //         title: Text(messages[index]),
                  //       );
                  //     },
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _.messageController,
                              decoration: InputDecoration(
                                  hintText: 'Type a message',
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(left: 10)),
                              onChanged: (value) {
                                _.chatModel.message = value;
                              },
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.send),
                            onPressed: () {
                              _.sendMessage(widget.privatePostId);
                              _.messageController.clear();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }));
  }
}
