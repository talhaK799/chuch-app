import 'package:churchappenings/models/poll.dart';

class CreatePoll {
  String? title;
  int? permissionId;
  String? desc;
  String? type;
  // String? option;
  int? facilityId;
  List<Option>? options;
  DateTime? startDate;
  CreatePoll({
    this.title,
    this.desc,
    this.type,
    this.facilityId,
    this.options,
    this.startDate,
    this.permissionId,
    // this.option
  });
  factory CreatePoll.fromJson(Map<String, dynamic> json) => CreatePoll(
        title: json["title"],
        permissionId: json["permission_id"],
        desc: json["desc"],
        type: json["type"],
        facilityId: json["facility_id"],
        startDate: DateTime.parse(json["start_date"]),
        // option: json["option"],
        options: List<Option>.from(
            json["options"].map((x) => Option.fromJson(x)) ?? []),
      );
  Map<String, dynamic> toJson() => {
        "title": title,
        "desc": desc,
        "type": type,
        // "option": option,
        "permission_id": permissionId,
        "facility_id": facilityId,
        "start_date": startDate?.toIso8601String(),
        "options": List<dynamic>.from(options!.map((x) => x.toJson())),
      };
}
