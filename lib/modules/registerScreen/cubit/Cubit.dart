import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_app/endPoints.dart';
import 'package:second_app/models/registerModel/RegisterModel.dart';
import 'package:second_app/modules/registerScreen/cubit/States.dart';
import 'package:second_app/shared/network/remot/DioHelper.dart';

class RegisterCubit extends Cubit<RegisterStates>{

  RegisterCubit() : super(InitialRegisterState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  RegisterModel? register;

  void userRegister({
    required String firstName,
    required String lastName,
    required String email,
    required String password,

  }){
    emit(RegisterLoadingState());
    DioHelper.postData(
        url: REGISTER,
        data: {
          'first_name': firstName,
          'last_name': lastName,
          'email' : email,
          'password' : password,
        },
    ).then((value) {
      register = RegisterModel.fromJson(value?.data);

      emit(RegisterSuccessState(register!));

    }).catchError((error){

      print(error.toString());
      emit(RegisterErrorState());

    });
  }

}