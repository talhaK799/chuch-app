import 'dart:convert';

List<PollModel> pollModelFromJson(String str) =>
    List<PollModel>.from(json.decode(str).map((x) => PollModel.fromJson(x)));

String pollModelToJson(List<PollModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PollModel {
  PollModel({
    required this.id,
    required this.title,
    required this.desc,
    required this.options,
    required this.userPols,
  });

  int id;
  String title;
  String desc;
  List<Option> options;
  List<UserPol> userPols;

  factory PollModel.fromJson(Map<String, dynamic> json) => PollModel(
        id: json["id"],
        title: json["title"],
        desc: json["desc"],
        options:
            List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
        userPols: List<UserPol>.from(
            json["user_pols"].map((x) => UserPol.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "desc": desc,
        "options": List<dynamic>.from(options.map((x) => x.toJson())),
        "user_pols": List<dynamic>.from(userPols.map((x) => x.toJson())),
      };
}

class Option {
  Option({
    required this.id,
    required this.option,
  });

  int id;
  String option;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        id: json["id"],
        option: json["option"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "option": option,
      };
}

class UserPol {
  UserPol({
    required this.selectedOption,
  });

  String selectedOption;

  factory UserPol.fromJson(Map<String, dynamic> json) => UserPol(
        selectedOption: json["selected_option"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "selected_option": selectedOption,
      };
}
