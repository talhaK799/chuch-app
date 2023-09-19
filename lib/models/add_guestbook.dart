class GuestBookInputModel {
   int? age;
   String? churchAffiliation;
   String? country;
   String? dateOfVisit;
   String? description;
   String? email;
   bool? requestCall;
   int? requestedFacilityId;
   int? requesterMemberId;
   String? state;
   String? name;
   String? phoneNo;

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
}
