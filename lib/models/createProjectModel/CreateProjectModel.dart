class CreateProjectModel {

  bool? status;
  String? msg;

  CreateProjectModel.fromJson(Map<String , dynamic> json){
    status = json['status'];
    msg = json['message'];
  }


}