class RegisterModel {
  bool? status;
  String? message;
  UserData? user;
  Data? data;

  RegisterModel.fromJson(Map<String , dynamic>json){
    status = json['status'];
    message = json['message'];
    user = (json['user'] != null) ? UserData.fromJson(json['user']) : null;
    data = (json['data'] != null) ? Data.fromJson(json['data']) : null;
  }
}


class UserData {
  int? id;
  String? firstName;
  String? lastName;
  String? email;

  UserData.fromJson(Map<String , dynamic>json){
    id = json['user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
  }


}


class Data {
  Original? original;

  Data.fromJson(Map<String ,dynamic>json) {
    original = Original.fromJson(json['original']);

  }

}

class Original {
  String? token;
  String? tokenType;

  Original.fromJson(Map<String , dynamic>json){
    token = json['token'];
    tokenType = json['token_type'];
  }

}