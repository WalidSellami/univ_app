
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_app/endPoints.dart';
import 'package:second_app/models/createProjectModel/CreateProjectModel.dart';
import 'package:second_app/models/detailsModel/DetailsModel.dart';
import 'package:second_app/modules/homeScreen/cubit/States.dart';
import 'package:second_app/shared/components/Constant.dart';
import 'package:second_app/shared/network/remot/DioHelper.dart';

import '../../../models/deleteModel/DeleteModel.dart';

class HomeCubit extends Cubit<HomeStates> {

  HomeCubit() : super(InitialHomeState());

  static HomeCubit get(context) => BlocProvider.of(context);


  CreateProjectModel? projectModel;
  DetailsModel? projectDetail;
  DeleteModel? deletePrj;


  void createProject({
    required String projectName,
    required String year,
    required String firstStudentName,
    String? secondStudentName,
    String? thirdStudentName,
    required String supervisorName,
    required String supervisorMark,
    required String presidentName,
    required String presidentMark,
    required String examinerName,
    required String examinerMark,
    required dynamic userId,

  }){

    emit(LoadingCreateProjectHomeState());
    DioHelper.postData(
      url: CREATE_PROJECT,
      data: {
        'project_name': projectName,
        'year': year,
        'first_student_name' : firstStudentName,
        'second_student_name' : secondStudentName,
        'third_student_name' : thirdStudentName,
        'supervisor_name' : supervisorName,
        'supervisor_mark' : supervisorMark,
        'president_name' : presidentName,
        'president_mark' : presidentMark,
        'examiner_name' : examinerName,
        'examiner_mark' : examinerMark,
        'user_id' : userId,

      },
      token: 'Bearer $token',
    ).then((value) {

      // print(value?.data);
      projectModel = CreateProjectModel.fromJson(value?.data);
      emit(SuccessCreateProjectHomeState(projectModel!));

    }).catchError((error){

      print(error.toString());
      emit(ErrorCreateProjectHomeState(error));
    });

  }


  void getDetails(){
    emit(LoadingGetDetailsHomeState());
    DioHelper.getData(
      url: '/api/project/$id',
      token: 'Bearer $token',
    ).then((value) {

      projectDetail = DetailsModel.fromJson(value?.data);
      emit(SuccessGetDetailsHomeState(projectDetail!));

    }).catchError((error){

      print(error.toString());
      emit(ErrorGetDetailsHomeState(error));

    });
  }

  void deleteProject(){
    emit(LoadingDeleteProjectHomeState());
    DioHelper.deleteData(
        url: '/api/delete-project/$projectId',
        token: 'Bearer $token',
    ).then((value) {

      deletePrj = DeleteModel.fromJson(value?.data);
      emit(SuccessDeleteProjectHomeState(deletePrj!));

    }).catchError((error){

      print(error.toString());
      emit(ErrorDeleteProjectHomeState(error));

    });
  }


}