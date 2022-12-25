import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_app/modules/registerScreen/cubit/States.dart';

class RegisterCubit extends Cubit<RegisterStates>{

  RegisterCubit() : super(InitialRegisterState());

  static RegisterCubit get(context) => BlocProvider.of(context);

}