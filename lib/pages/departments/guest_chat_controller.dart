import 'dart:developer';

import 'package:churchappenings/api/guest_chat_api.dart';
import 'package:churchappenings/models/guest_chat_model.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../api/profile.dart';

class ChatController extends GetxController {
  RxList<GuestChatModel> chatMessages = <GuestChatModel>[].obs;
  GuestChatModel cht = GuestChatModel();
  ProfileAPI profileApi = ProfileAPI.to;

  @override
  onInit() async {
    super.onInit();
    log('hhhh');
    fetchChatMessages();
    update();
  }

  Future<void> fetchChatMessages() async {
    try {
      List<GuestChatModel> messages = await GuestChatApi().getChatMessages();
      chatMessages.assignAll(messages);
      update();
    } catch (error) {
      print("Error fetching chat messages: $error");
    }
  }

  Future<void> sendGuestMessage(text) async {
    try {
      cht.message = text;
      cht.userName = profileApi.name;
      cht.createdAt = DateTime.now();
      chatMessages.add(cht);
      GuestChatApi().sendMessage(text);
      update();
    } catch (e) {}
  }
}
