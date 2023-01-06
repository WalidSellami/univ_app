class UpdateModel {

  bool? status;
  String? msg;
  UserData? user;

  UpdateModel.fromJson(Map<String , dynamic> json){
    status = json['status'];
    msg = json['message'];
    user = UserData.fromJson(json['user']);
  }

}


class UserData {
  int? id;
  String? firstName;
  String? lastName;
  String? email;

  UserData.fromJson(Map<String, dynamic>json){
    id = json['user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
  }

}
