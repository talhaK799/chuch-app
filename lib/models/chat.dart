class ChatModel {
  String? message;
  String? id;
  DateTime? date;

  ChatModel({
    this.message,
    this.id,
    this.date,
  });

  ChatModel.fromJson(Map<dynamic, dynamic> json)
      : date = DateTime.parse(json['date'] as String),
        id = json['user_id'] as String,
        message = json['message'] as String;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'date': date.toString(),
        'message': message,
        'user_id': id,
      };
}

// class GuestChatModel {
//  int? id; 
//    int?  memberId;
//    String?  message; 
//   DateTime?  createdAt; 
//  String? userName; 
// GuestChatModel( this.id,this.memberId,this.message,this.createdAt,this.userName);
 

//   GuestChatModel.fromJson(Map<dynamic, dynamic> json)
//       : createdAt = DateTime.parse(json['date'] as String),
      
//         id = json['id'] ,
//         memberId = json['member_id'],
        
//         message = json['message'] as String;

//   Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
//         'date': date.toString(),
//         'message': message,
//         'user_id': id,
//       };
// }

