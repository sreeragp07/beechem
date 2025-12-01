class PersonalDetailsAddResponse {
  bool? status;
  int? id;
  String? message;

  PersonalDetailsAddResponse({this.status, this.id, this.message});

  factory PersonalDetailsAddResponse.fromJson(Map<String, dynamic> json) {
    return PersonalDetailsAddResponse(
      status: json['status'] as bool?,
      id: json['id'] as int?,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'id': id,
    'message': message,
  };
}
