class Permission {
  String? title;
  bool? isRead;
  bool? isModify;
  bool? isCheckBox;
  bool? isShow;
  String? departmentsId;
  Permission(
      {this.title,
      this.isShow,
      this.isRead,
      this.isModify,
      this.isCheckBox,
      this.departmentsId});

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "isRead": isRead,
      "isModify": isModify,
      "departmentsId": departmentsId
    };
  }

  Permission.fromJson(Map<String, dynamic> json) {
    title = json["title"] ?? "";
    isRead = json["isRead"] ?? false;
    isModify = json["isModify"] ?? false;
    departmentsId = json["departmentsId"] ?? "";
  }
}
