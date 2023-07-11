class PrivatePostingModel {
  String? senderId;
  String? senderName;
  String? senderDept;
  String? title;
  String? description;
  String? image;

  PrivatePostingModel(
      {this.senderId,
      this.senderName,
      this.senderDept,
      this.title,
      this.description,
      this.image});

  Map tojson() => {
        "sender_id": senderId,
        "sender_name": senderName,
        "sender_dept_id": senderDept,
        "title": title,
        "description": description,
        "image": image,
      };
}
