class DeleteModel {
  bool? status;
  String? message;

  DeleteModel.fromJson(Map<String , dynamic>json){
    status = json['status'];
    message = json['message'];
  }


}