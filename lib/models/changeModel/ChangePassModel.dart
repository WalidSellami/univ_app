class ChangePassModel {
  bool? status;
  String? message;

  ChangePassModel.fromJson(Map<String , dynamic>json){
    status = json['status'];
    message = json['message'];
  }


}