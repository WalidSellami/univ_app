
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_app/endPoints.dart';
import 'package:second_app/models/forgotModel/ForgotModel.dart';
import 'package:second_app/modules/forgotScreen/cubit/States.dart';
import 'package:second_app/shared/components/Constant.dart';
import 'package:second_app/shared/network/remot/DioHelper.dart';

class ForgotCubit extends Cubit<ForgotStates> {

  ForgotCubit() : super(InitialForgotState());

  static ForgotCubit get(context) => BlocProvider.of(context);

  ForgotModel? forgot;

  void changePassword({
   required String password,
}){
    emit(LoadingForgotState());
    DioHelper.putData(
        url: '/api/reset-password/${emailCnt.text}',
        data: {
          'password' : password,
        }).then((value) {

          forgot = ForgotModel.fromJson(value?.data);
          emit(SuccessForgotState(forgot!));

    }).catchError((error){

      print(error.toString());
      emit(ErrorForgotState(error));

    });
}

}