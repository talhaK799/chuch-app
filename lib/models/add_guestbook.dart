// class GuestBookInputModel {
//    int? age;
//    String? churchAffiliation;
//    String? country;
//    String? dateOfVisit;
//    String? description;
//    String? email;
//    bool? requestCall;
//    int? requestedFacilityId;
//    int? requesterMemberId;
//    String? state;
//    String? name;
//    String? phoneNo;

//   GuestBookInputModel({
//      this.age,
//      this.churchAffiliation,
//      this.country,
//      this.dateOfVisit,
//      this.description,
//      this.email,
//      this.name,
//      this.phoneNo,
//      this.requestCall,
//      this.requestedFacilityId,
//      this.requesterMemberId,
//      this.state,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'age': age,
//       'church_affiliation': churchAffiliation,
//       'country': country,
//       'date_of_visit': dateOfVisit,
//       'description': description,
//       'email': email,
//       'name': name,
//       'phone_no': phoneNo,
//       'request_call': requestCall,
//       'requested_facility_id': requestedFacilityId,
//       'requester_member_id': requesterMemberId,
//       'state': state,
//     };
//   }
// }
class GuestBookInputModel {
  int? age;
  String? churchAffiliation;
  String? country;
  String? dateOfVisit;
  String? description;
  String? email;
  String? name;
  String? phoneNo;
  bool? requestCall;
  int? requestedFacilityId;
  int? requesterMemberId;
  String? state;

  GuestBookInputModel({
    this.age,
    this.churchAffiliation,
    this.country,
    this.dateOfVisit,
    this.description,
    this.email,
    this.name,
    this.phoneNo,
    this.requestCall,
    this.requestedFacilityId,
    this.requesterMemberId,
    this.state,
  });

  Map<String, dynamic> toJson() {
    return {
      'age': age,
      'church_affiliation': churchAffiliation,
      'country': country,
      'date_of_visit': dateOfVisit,
      'description': description,
      'email': email,
      'name': name,
      'phone_no': phoneNo,
      'request_call': requestCall,
      'requested_facility_id': requestedFacilityId,
      'requester_member_id': requesterMemberId,
      'state': state,
    };
  }

  factory GuestBookInputModel.fromJson(Map<String, dynamic> json) {
    return GuestBookInputModel(
      age: json['age'],
      churchAffiliation: json['church_affiliation'],
      country: json['country'],
      dateOfVisit: json['date_of_visit'],
      description: json['description'],
      email: json['email'],
      name: json['name'],
      phoneNo: json['phone_no'],
      requestCall: json['request_call'],
      requestedFacilityId: json['requested_facility_id'],
      requesterMemberId: json['requester_member_id'],
      state: json['state'],
    );
  }
}
