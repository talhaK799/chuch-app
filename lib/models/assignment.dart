class Assginment {
  String? datetime;
  int? deptid;
  String? description;
  String? assignee;
  String? id;
  String? title;
  String? bulletinId;
  String? deptHappeningId;
  String? uuid;
  String? assignmentType;
  String? type;
  String? status;

  Assginment(
      {this.datetime,
      this.deptid,
      this.description,
      this.assignee,
      this.id,
      this.title,
      this.bulletinId,
      this.deptHappeningId,
      this.type,
      this.uuid,
      this.assignmentType,
      this.status});

  Map<String, dynamic> toJson() {
    return {
      "date_time": datetime,
      "dept_id": deptid,
      "description": description,
      "id": deptid,
      "title": title,
      "bulletin_id": bulletinId,
      "assignment_type": assignmentType,
      "status": status,
      "assignee": assignee
    };
  }
}
