import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:second_app/layout/appLayout/cubit/Cubit.dart';
import 'package:second_app/layout/appLayout/cubit/States.dart';
import 'package:second_app/layout/checkConection/cubit/Cubit.dart';
import 'package:second_app/layout/checkConection/cubit/States.dart';
import 'package:second_app/layout/darkMode/cubit/Cubit.dart';
import 'package:second_app/layout/darkMode/cubit/States.dart';
import 'package:second_app/modules/changePasswordScreen/ChangePassword.dart';
import 'package:second_app/modules/editProfileScreen/EditProfileScreen.dart';
import 'package:second_app/modules/loginScreen/LoginScreen.dart';
import 'package:second_app/shared/components/Components.dart';
import 'package:second_app/shared/components/Constant.dart';
import 'package:second_app/shared/network/local/CacheHelper.dart';

class SettingsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ThemeCubit , ThemeStates>(
          listener: (context , state){},
          builder: (context , state){
            return BlocConsumer<AppCubit , AppStates>(
              listener: (context, state){
                // if(state is SuccessDeleteAccountAppState) {
                //   if(state.delete.status == true) {
                //
                //     showToast(
                //         message: '${state.delete.message}',
                //         state: ToastStates.success);
                //
                //   }else{
                //
                //     showToast(
                //         message: '${state.delete.message}',
                //         state: ToastStates.error);
                //
                //   }
                // }
              },
              builder: (context , state){
                var profileData = AppCubit.get(context).profile;
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10.0,
                      ),
                      Center(
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: ThemeCubit.get(context).isDark ? Colors.white : Colors.black,
                                width: 2.0
                            ),
                            color: ThemeCubit.get(context).isDark ? Colors.grey.shade800.withOpacity(.1) : Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(65.0),
                          ),
                          child: Icon(
                            Icons.person,
                            size: 82.0,
                            color: ThemeCubit.get(context).isDark ? Colors.grey.shade300 : Colors.grey.shade800,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 14.0,
                      ),
                      Text(
                        '${profileData?.firstName} ' '${profileData?.lastName}',
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 14.0,
                      ),
                      Text(
                        '${profileData?.email}',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 35.0,
                      ),
                      Expanded(
                        child: ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            ListTile(
                              leading: CircleAvatar(
                                radius: 19.0,
                                backgroundColor: ThemeCubit.get(context).isDark
                                    ? HexColor('198989')
                                    : Colors.blue.shade700,
                                child: const Icon(
                                  Icons.dark_mode,
                                  color: Colors.white,
                                ),
                              ),
                              title: const Text(
                                'Dark Mode',
                                style: TextStyle(
                                  fontSize: 17.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: ThemeCubit.get(context).isDark ? Colors.white : Colors.black,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(25.5),
                                ),
                                child: CircleAvatar(
                                  radius: 23.5,
                                  backgroundColor: ThemeCubit.get(context).isDark
                                      ? Colors.grey.shade700.withOpacity(.6)
                                      : Colors.grey.shade100,
                                  child: IconButton(
                                    onPressed: () {
                                      ThemeCubit.get(context).changeTheme();
                                    },
                                    icon: ThemeCubit.get(context).isDark
                                        ? Icon(
                                        Icons.light_mode,
                                        color: Colors.grey.shade200
                                    )
                                        : const Icon(
                                      Icons.dark_mode,
                                      color: Colors.black,
                                    ),
                                    tooltip: 'Change Mode',
                                  ),
                                ),
                              ),
                              onTap: (){
                                ThemeCubit.get(context).changeTheme();
                              },
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            ListTile(
                              leading: CircleAvatar(
                                radius: 19.0,
                                backgroundColor: ThemeCubit.get(context).isDark
                                    ? HexColor('198989')
                                    : Colors.blue.shade700,
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                              ),
                              title: const Text(
                                'Edit Profile',
                                style: TextStyle(
                                  fontSize: 17.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: ThemeCubit.get(context).isDark ? Colors.grey.shade200 : Colors.grey.shade700,
                                size: 20.0,
                              ),
                              onTap: () {
                                navigatorTo(context: context, screen: EditProfile());
                              },
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            ListTile(
                              leading: CircleAvatar(
                                radius: 19.0,
                                backgroundColor: ThemeCubit.get(context).isDark
                                    ? HexColor('198989')
                                    : Colors.blue.shade700,
                                child: const Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                ),
                              ),
                              title: const Text(
                                'Change Password',
                                style: TextStyle(
                                  fontSize: 17.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: ThemeCubit.get(context).isDark ? Colors.grey.shade200 : Colors.grey.shade700,
                                size: 20.0,
                              ),
                              onTap: (){
                                navigatorTo(context: context, screen: ChangePassword());
                              },
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            ListTile(
                              leading: CircleAvatar(
                                radius: 20.0,
                                backgroundColor: ThemeCubit.get(context).isDark
                                    ? HexColor('198989')
                                    : Colors.blue.shade700,
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                              title: const Text(
                                'Delete Account',
                                style: TextStyle(
                                  fontSize: 17.5,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: ThemeCubit.get(context).isDark ? Colors.grey.shade200 : Colors.grey.shade700,
                                size: 20.0,
                              ),
                              onTap: (){
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0),
                                        ),
                                        title: const Text(
                                          'Are you sure to delete your account?',
                                          style: TextStyle(
                                            letterSpacing: 0.4,
                                            height: 1.2,
                                            fontSize: 21.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: (){
                                              Navigator.pop(context);
                                            },
                                            child: const Text(
                                              'No',
                                              style: TextStyle(
                                                fontSize: 19.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: (){
                                              AppCubit.get(context).deleteAccount();
                                              CacheHelper.removeData(key: 'token').then((value) {
                                                if (value == true) {
                                                  CacheHelper.removeData(key: 'id');
                                                  navigatorToNotBack(
                                                      context: context, screen: LoginScreen());
                                                }
                                              });
                                              showToast(
                                                  message: 'Deleted done successfully',
                                                  state: ToastStates.success);
                                              AppCubit.get(context).currentIndex = 0;
                                            },
                                            child: const Text(
                                              'Yes',
                                              style: TextStyle(
                                                fontSize: 19.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    });
                              },
                            ),
                            const SizedBox(
                              height: 15.0,
                            ),
                            ListTile(
                              leading: CircleAvatar(
                                radius: 20.0,
                                backgroundColor: ThemeCubit.get(context).isDark
                                    ? HexColor('198989')
                                    : Colors.blue.shade700,
                                child: const Icon(
                                  Icons.logout_outlined,
                                  color: Colors.white,
                                ),
                              ),
                              title: Text(
                                'Log out',
                                style: TextStyle(
                                  fontSize: 19.0,
                                  fontWeight: FontWeight.bold,
                                  color: ThemeCubit.get(context).isDark
                                      ? HexColor('35c2c2')
                                      : Colors.blue.shade700,
                                ),
                              ),
                              onTap: () {
                                CacheHelper.removeData(key: 'token').then((value) {
                                  if (value == true) {
                                    CacheHelper.removeData(key: 'id');
                                    navigatorToNotBack(
                                        context: context, screen: LoginScreen());
                                  }
                                });
                                AppCubit.get(context).currentIndex = 0;
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
          },
        );

      },
    );
  }
}
