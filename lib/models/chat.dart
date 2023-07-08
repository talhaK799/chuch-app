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
