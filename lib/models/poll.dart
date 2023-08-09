import 'dart:convert';

List<PollModel> pollModelFromJson(String str) =>
    List<PollModel>.from(json.decode(str).map((x) => PollModel.fromJson(x)));

String pollModelToJson(List<PollModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PollModel {
  PollModel({
    this.id,
    this.title,
    this.desc,
    this.options,
    this.userPols,
  });

  int? id;
  String? title;
  String? desc;
  var options;
  List<UserPol>? userPols;

  PollModel.fromJson(v) {
    id = v["id"];
    title = v["title"];
    desc = v["desc"];
    options = v["options"].runtimeType == String
        ? List<Option>.from(
            jsonDecode(v["options"]).map((x) => Option.fromJson(x)))
        : List<Option>.from(v["options"].map((x) => Option.fromJson(x)));
    userPols =
        List<UserPol>.from(v["user_pols"].map((x) => UserPol.fromJson(x)));
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "desc": desc,
        "options": List<dynamic>.from(options!.map((x) => x.toJson())),
        "user_pols": List<dynamic>.from(userPols!.map((x) => x.toJson())),
      };
}

class Option {
  Option({
    required this.id,
    required this.option,
  });

  int id;
  String option;

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      id: json["id"],
      option: json["option"],
    );
  }

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
