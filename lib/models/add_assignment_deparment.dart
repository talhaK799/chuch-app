class InsertDepartment {
  String? datetime;
  int? deptid;
  String? description;
  String? assignee;
  String? id;
  String? title;
  String? bulletinId;
String? deptHappeningId;
String? uuid;

String? type;
  InsertDepartment({
    this.datetime,
    this.deptid,
    this.description,
    this.assignee,
    this.id,
    this.title,
    this.bulletinId,
    this.deptHappeningId,
    this.type,
    this.uuid,

  });

  Map<String, dynamic> toJson() {
    return {
      "date_time": datetime,
      "dept_id": deptid,
      "description": description,
      "id": id,
      "title": title,
      "bulletin_id": bulletinId,
    };
  }
}
