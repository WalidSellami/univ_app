class ProfileModel {
 int? id;
 String? firstName;
 String? lastName;
 String? email;

 ProfileModel.fromJson(Map<String , dynamic> json){
   id = json['id'];
   firstName = json['first_name'];
   lastName = json['last_name'];
   email = json['email'];
 }


}