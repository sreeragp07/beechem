class PersonalDetails {
  bool? status;
  List<Data>? data;

  PersonalDetails({this.status, this.data});

  PersonalDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? firstName;
  String? lastName;
  String? address;
  String? latitude;
  String? longitude;
  String? suburb;
  String? state;
  String? postcode;
  String? country;
  String? contactNumber;
  String? additionalNotes;
  String? status;
  String? roleIds;
  String? createdBy;
  String? updatedBy;
  List<RoleDetails>? roleDetails;
  List<String>? apiaryRoleArray;

  Data({
    this.id,
    this.firstName,
    this.lastName,
    this.address,
    this.latitude,
    this.longitude,
    this.suburb,
    this.state,
    this.postcode,
    this.country,
    this.contactNumber,
    this.additionalNotes,
    this.status,
    this.roleIds,
    this.createdBy,
    this.updatedBy,
    this.roleDetails,
    this.apiaryRoleArray,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    suburb = json['suburb'];
    state = json['state'];
    postcode = json['postcode'];
    country = json['country'];
    contactNumber = json['contact_number'];
    additionalNotes = json['additional_notes'];
    status = json['status'];
    roleIds = json['role_ids'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    if (json['role_details'] != null) {
      roleDetails = <RoleDetails>[];
      json['role_details'].forEach((v) {
        roleDetails!.add(new RoleDetails.fromJson(v));
      });
    }
    apiaryRoleArray = json['apiary_role_array'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['address'] = address;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['suburb'] = suburb;
    data['state'] = state;
    data['postcode'] = postcode;
    data['country'] = country;
    data['contact_number'] = contactNumber;
    data['additional_notes'] = additionalNotes;
    data['status'] = status;
    data['role_ids'] = roleIds;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    if (roleDetails != null) {
      data['role_details'] = roleDetails!.map((v) => v.toJson()).toList();
    }
    data['apiary_role_array'] = apiaryRoleArray;
    return data;
  }
}

class RoleDetails {
  int? id;
  String? role;

  RoleDetails({this.id, this.role});

  RoleDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['role'] = role;
    return data;
  }
}
