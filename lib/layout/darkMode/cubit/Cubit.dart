
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:second_app/layout/darkMode/cubit/States.dart';
import 'package:second_app/shared/network/local/CacheHelper.dart';

class ThemeCubit extends Cubit<ThemeStates>{

  ThemeCubit() : super(InitialThemeState());

  static ThemeCubit get(context) => BlocProvider.of(context);

  bool isDark = false;


  void changeTheme({bool? fromShared}){
    if(fromShared != null){
      isDark = fromShared;
    }else {
      isDark = !isDark;
      CacheHelper.saveData(key: 'isDark', value: isDark).then((value) {
        emit(ChangeThemeState());
      });
    }
  }

}