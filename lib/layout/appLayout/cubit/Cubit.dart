
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_app/endPoints.dart';
import 'package:second_app/layout/appLayout/cubit/States.dart';
import 'package:second_app/models/changeModel/ChangePassModel.dart';
import 'package:second_app/models/createProjectModel/CreateProjectModel.dart';
import 'package:second_app/models/deleteModel/DeleteModel.dart';
import 'package:second_app/models/detailsModel/DetailsModel.dart';
import 'package:second_app/models/loginModel/LoginModel.dart';
import 'package:second_app/models/profileModel/ProfileModel.dart';
import 'package:second_app/models/updateProfileModel/UpdateModel.dart';
import 'package:second_app/modules/homeScreen/HomeScreen.dart';
import 'package:second_app/modules/settingsScreen/SettingsScreen.dart';
import 'package:second_app/shared/components/Constant.dart';
import 'package:second_app/shared/network/remot/DioHelper.dart';

class AppCubit extends Cubit<AppStates>{

  AppCubit() : super(InitialAppState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  final List<BottomNavigationBarItem> items = [
     const BottomNavigationBarItem(
         icon: Icon(Icons.home),
         label: 'Home',
     ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings',
    ),
  ];

  final List<Widget> screens = [
    HomeScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index){
   currentIndex = index;
   emit(ChangeBottomAppState());

  }

  IconData fabIcon = Icons.edit;
  bool isShow = false;

  void changeBottomSheet({required IconData icon , required bool isActive}){
    fabIcon = icon;
    isShow = isActive;
    emit(ShowBottomSheetAppState());
  }

  String title = 'Welcome!';

  void changeTitle({required String text}){
    title = text;
    emit(ChangeTitleAppState());
  }


  bool isHide1 = true;
  bool isHide2 = true;
  bool isHide3 = true;
  bool isHide4 = true;
  bool isHide5 = true;
  bool isHide6 = true;
  bool isHide7 = true;


  void showFullText1(){
    isHide1 = !isHide1;
    emit(ShowFullTextAppState());
  }

  void showFullText2(){
    isHide2 = !isHide2;
    emit(ShowFullTextAppState());
  }

  void showFullText3(){
    isHide3 = !isHide3;
    emit(ShowFullTextAppState());
  }

  void showFullText4(){
    isHide4 = !isHide4;
    emit(ShowFullTextAppState());
  }

  void showFullText5(){
    isHide5 = !isHide5;
    emit(ShowFullTextAppState());
  }

  void showFullText6(){
    isHide5 = !isHide5;
    emit(ShowFullTextAppState());
  }

  void showFullText7(){
    isHide5 = !isHide5;
    emit(ShowFullTextAppState());
  }


  ProfileModel? profile;
  UpdateModel? update;
  ChangePassModel? change;
  DeleteModel? delete;

  void getProfile(){
    emit(LoadingProfileAppState());
    DioHelper.getData(
        url: PROFILE,
        token: 'Bearer $token',
    ).then((value) {
      // print(value?.data);
      profile = ProfileModel.fromJson(value?.data);
      // print(profile?.firstName);
      emit(SuccessProfileAppState(profile!));

    }).catchError((error){

      print(error.toString());
      emit(ErrorProfileAppState(error));

    });

  }

  void updateProfile({
    required String firstName,
    required String lastName,
    required String email,
}){
    emit(LoadingUpdateProfileAppState());
    DioHelper.putData(
        url: '/api/update-profile/$id',
        data: {
          'first_name': firstName,
          'last_name': lastName,
          'email': email,
        },
        token: 'Bearer $token',
    ).then((value) {
      // print(value?.data);
      update = UpdateModel.fromJson(value?.data);
      emit(SuccessUpdateProfileAppState(update!));

    }).catchError((error){

      print(error.toString());
      emit(ErrorUpdateProfileAppState(error));

    });

  }


  void changePassword({
    required String password,
}){
    emit(LoadingChangePassAppState());
    DioHelper.putData(
        url: '/api/change-password/$id',
        data: {
          'password': password,
        },
      token: token,
    ).then((value) {

      change = ChangePassModel.fromJson(value?.data);
      emit(SuccessChangePassAppState(change!));

    }).catchError((error){

      print(error.toString());
      emit(ErrorChangePassAppState(error));

    });
  }

  void deleteAccount(){
    emit(LoadingDeleteAccountAppState());
    DioHelper.deleteData(
        url: '/api/delete/$id',
        token: 'Bearer $token',
    ).then((value) {

      delete = DeleteModel.fromJson(value?.data);
      emit(SuccessDeleteAccountAppState(delete!));

    }).catchError((error){

      print(error.toString());
      emit(ErrorDeleteAccountAppState(error));

    });
  }

}