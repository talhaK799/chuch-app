import 'dart:developer';

import 'package:churchappenings/api/department.dart';
import 'package:churchappenings/models/department.dart';
import 'package:churchappenings/models/posting_.dart';
import 'package:churchappenings/services/local_data.dart';
import 'package:churchappenings/widgets/Dialogues/dialogue.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../api/chat.dart';
import '../../api/inventory.dart';
import '../../api/private_posting.dart';
import '../../api/profile.dart';
import '../../api/upload-image.dart';
import '../../models/chat.dart';
import '../../models/inventory.dart';
import '../../models/private_posting.dart';

class DepartmentController extends GetxController {
  final localData = LocalData();
  InventoryApi inventoryApi = InventoryApi();
  ProfileAPI profileApi = ProfileAPI.to;
  late bool memberStatus;
  PrivatePostingApi privatePostingApi = PrivatePostingApi();
  PrivatePosting privatePostingModel = PrivatePosting();
  bool loading = true;
  DepartmentAPI departmentApi = DepartmentAPI();
  var response;
  List<Departments> departments = [];
  List departmentsMember = [];
  // List<dynamic> deptPublicPosting = [];
  List<DeptPublicPosting> publicPosting = [];
  List dumyData = [];
  String? imagePath;
  List<String> chatMessages = [];

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descController = TextEditingController();

  TextEditingController get titleController => _titleController;
  TextEditingController get descController => _descController;
  TextEditingController messageController = TextEditingController();

  var getPrivatePosting;

  ChatDao chatDao = ChatDao();
  ChatModel chatModel = ChatModel();
  Stream<dynamic>? messagesStream;
  final chatList = <ChatModel>[].obs;

  RxInt currentPageIndex = 0.obs;
  List<Inventory> inventoryList = [];
  List<Inventory> inventoryBorrowedList = [];

  DepartmentController([String? screenName, bool? isSreeen]) {
    switch (screenName) {
      case "PrivatePostingScreen":
        {
          getPrivatePost();
        }
        break;

      case "ChatScreen":
        {
          getMessage(Get.arguments['deptId']);
        }
        break;
      case "AddDepartmentPage":
        {
          getAllDepartments();
        }
        break;

      case "InventoryScreen":
        {
          getInventory();
          getBorrowedInventory();
        }
        break;
    }

    permissionInventory();

    //! new it will be created in switch

    // bool? isScreenShow = isSreeen;

    // if (isSreeen == null) {
    //   isScreenShow = false;
    // }

    // if (isScreenShow == true) getPrivatePost();

    // if (isScreenShow == true) getMessage(Get.arguments['deptId']);

    // getAllDepartments();
    // getPublicDepartment(id);
  }

  @override
  onInit() async {
    super.onInit();
    memberStatus = await localData.getMemberStatus();
    log('member status .....${memberStatus}');
    getAllDepartments();
    getMyDepartments();
    // getMessage();
    // String deptId = Get.arguments['deptId'];
    if (Get.arguments != null && Get.arguments['deptId'] != null) {
      getPublicDepartment(Get.arguments['deptId']);
    }
  }

  Future<void> permissionInventory() async {
    await inventoryApi.permission(
        deptId: Get.arguments['deptId'],
        memberId: profileApi.memberId.toString());
  }

  Future<void> getInventory() async {
    loading = true;
    update();
    var res = await inventoryApi.fetchInventory(Get.arguments['deptId']);
    res.forEach((value) {
      inventoryList.add(Inventory.fromJson(value));
    });
    loading = false;

    update();
    log("test001: ${inventoryList[0].name}");
  }

  onChangePage(int value) {
    currentPageIndex.value = value;
    update();
  }

  Future<void> getBorrowedInventory() async {
    var res = await inventoryApi.borrowedInventory(Get.arguments['deptId']);
    res.forEach((value) {
      inventoryBorrowedList.add(Inventory.fromJson(value));
    });
    update();
    log("test101: ${inventoryBorrowedList[0].borrowedFrom}");
  }

  String getCurrentUserId() {
    String senderId = profileApi.memberId!.toString();
    return senderId;
  }

  void sendMessage(String privatePostId) {
    String senderId = profileApi.memberId!.toString();
    log("user=> $senderId");
    chatModel.date = DateTime.now();

    chatModel.id = senderId;
    chatDao.saveMessage(chatModel, senderId, privatePostId);
    update();
  }

  Stream<List<ChatModel>> getMessage(String privatePostId) {
    log("test2 run");
    // Remove the chatList initialization here

    // Replace this with your actual implementation to get the stream from chatDao
    Stream stream = chatDao.listenToMessages(privatePostId);
    stream.listen((event) {
      // Remove the chatList = [] line
      print("check1123: ${event.snapshot.value.toString()}");
      ChatModel message =
          ChatModel.fromJson(Map<String, dynamic>.from(event.snapshot.value));
      // Use the chatList.insert(0, message) method to add the new message at the beginning of the list

      chatList.insert(0, message);

      // chatList[0].date

      message = ChatModel();
      update();
    });

    // Store the stream in messagesStream
    messagesStream = stream;

    // Return the chatList as a stream using the Rx method .stream
    return chatList.stream;
  }

  Future<void> getPrivatePost() async {
    String deptId = Get.arguments['deptId'];
    getPrivatePosting = await privatePostingApi.fetchPrivatePost(deptId);
    update();
    log("a11: ${getPrivatePosting[0]["id"]}");
  }

  getMyDepartments() async {
    var res = await departmentApi.getDepartmentsYourMemberOff();
    //log("message $res");
    res.forEach((value) {
      departmentsMember.add(Departments.fromJson(value['department']));
    });

    loading = false;
    update();
  }

  getAllDepartments() async {
    log("message ");
    if (memberStatus == false) {
      log("message ");
      var result = await departmentApi.getDepartmentsYourGuestrOff();
      log("message $result");
      result.forEach((value) {
        departments.add(Departments.fromJson(value));

        log("message $result");
      });
    } else {
      var res = await departmentApi.getAllDepartments();
      log("message $res");
      res.forEach((value) {
        departments.add(Departments.fromJson(value));
      });
    }

    loading = false;
    update();

    // var result = response = await departmentApi.getAllDepartments();
    // result.forEach((value) {
    //   departments.add(Departments.fromJson(value));
    // });
    // update();
    log("test 88: ${departments[0].name}");
    // print("**** Response ==== >>> $response");
    // res.forEach((value) {
    //   departments.add(Departments.fromJson(response["department"]));
    // });
    // for (int i = 0; i < response.length; i++) {
    //   departments.add(Departments.fromJson(response[i]["department"]));
    // }
  }

  getPublicDepartment(String deptId) async {
    deptId = Get.arguments['deptId'];

    publicPosting = [];
    var res = await departmentApi.getPublicDepartment(deptId);

    res.forEach((element) {
      publicPosting.add(DeptPublicPosting.fromJson(element));
    });
    update();

    log("get posting data ${publicPosting.length}");

    // res.then((value) {
    //   // Access the data returned by the query
    //   deptPublicPosting = value;
    //   // int id = deptPublicPosting[1]["id"];
    //   // String message = deptPublicPosting[0]["message"];
    //   // String senderName = deptPublicPosting[0]["sender_name"];
    //   // String bulletinName = deptPublicPosting[0]["bulletin"]["name"];
    //   // String bulletinImage = deptPublicPosting[0]["bulletin"]["image"];
    //   // String bulletinSubtitle = deptPublicPosting[0]["bulletin"]["subtitle"];
    //   // log("aa:$id");
    // });
  }

  // getDepartmentsMember() async {
  //   var res = await departmentApi.getDepartmentsYourMemberOff();
  //   res.
  // }

  sendJoinRequest(int deptId) async {
    loading = true;
    update();
   

     await departmentApi.deptJoinRequest(deptId);
   
   
    Get.snackbar("Success", "Department join request sent successfully",
        snackPosition: SnackPosition.BOTTOM);
    loading = false;
    update();
  }

  Future uploadEventImage() async {
    imagePath = await selectImage();
    update();
  }

  Future savePrivatePost() async {
    String deptId = Get.arguments['deptId'];
    log("aa22 $deptId");
    String uploadedImageUrl = await uploadImage(imagePath!);
    privatePostingApi.createPrivatePosting(
      title: titleController.text,
      description: descController.text,
      image: uploadedImageUrl,
      deptId: deptId,
    );

    // privatePostingModel.title = titleController.text;
    // privatePostingModel.image = uploadedImageUrl;
    // privatePostingModel.description = descController.text;
    // privatePostingModel.senderId = senderId;
    // privatePostingModel.senderName = senderName;
    // privatePostingModel.senderDept = deptId;
  }

  addDummyData() {
    dumyData.add({titleController.text, descController.text, imagePath});
    update();
  }
}
