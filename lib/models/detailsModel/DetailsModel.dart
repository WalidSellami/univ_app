class DetailsModel {

  List<DetailData> detail = [];
  DetailsModel.fromJson(Map<String , dynamic> json){
    json['detail'].forEach((element){
      detail.add(DetailData.fromJson(element));
    });
  }

}

class DetailData {
  dynamic id;
  String? projectName;
  dynamic year;
  String? firstStudent;
  String? secondStudent;
  String? thirdStudent;
  String? supervisorName;
  dynamic supervisorMark;
  String? presidentName;
  dynamic presidentMark;
  String? examinerName;
  dynamic examinerMark;
  dynamic finalMark;

  DetailData.fromJson(Map<String , dynamic>json){
    id = json['detail_id'];
    projectName = json['project_name'];
    year = json['year'];
    firstStudent = json['first_student_name'];
    secondStudent = json['second_student_name'];
    thirdStudent = json['third_student_name'];
    supervisorName = json['supervisor_name'];
    supervisorMark = json['supervisor_mark'];
    presidentName = json['president_name'];
    presidentMark = json['president_mark'];
    examinerName = json['examiner_name'];
    examinerMark = json['examiner_mark'];
    finalMark = json['final_mark'];
  }
}