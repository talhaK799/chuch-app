class GuestChatModel {
   int? id;
  final int? memberId;
   String? message;
   DateTime? createdAt;
   String? userName;

  GuestChatModel({
     this.id,
     this.memberId,
     this.message,
     this.createdAt,
     this.userName,
  });

  factory GuestChatModel.fromJson(Map<String, dynamic> json) {
    final memberData = json['member'];
    final userData = memberData['user'];

    return GuestChatModel(
      id: json['id'],
      memberId: json['member_id'],
      message: json['message'],
      createdAt: DateTime.parse(json['created_at']),
      userName: userData['name'],
    );
  }

  void add(String text) {}
}
