import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:second_app/layout/appLayout/cubit/Cubit.dart';
import 'package:second_app/layout/appLayout/cubit/States.dart';
import 'package:second_app/modules/changeScreen/ChangePassword.dart';
import 'package:second_app/modules/editProfileScreen/EditProfileScreen.dart';
import 'package:second_app/modules/loginScreen/LoginScreen.dart';
import 'package:second_app/shared/components/Components.dart';
import 'package:second_app/shared/network/local/CacheHelper.dart';

class SettingsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit , AppStates>(
      listener: (context, state){
        if(state is SuccessDeleteAccountAppState) {
          if(state.delete.status == true) {

            showToast(
                message: '${state.delete.message}',
                state: ToastStates.success);
            navigatorToNotBack(context: context, screen: LoginScreen());
            Fluttertoast.showToast(
              msg: 'Register to get started' ,
              timeInSecForIosWeb: 5,
              backgroundColor: Colors.blue.shade700,
              textColor: Colors.white,
              fontSize: 17.0,
            );

          }else{

            showToast(
                message: '${state.delete.message}',
                state: ToastStates.error);

          }
        }
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
                        color: Colors.black,
                        width: 2.0
                    ),
                    borderRadius: BorderRadius.circular(65.0),
                  ),
                  child: Icon(
                    Icons.person,
                    size: 82.0,
                    color: Colors.grey.shade400,
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
                        backgroundColor: Colors.blue.shade700,
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
                            color: Colors.black,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(25.5),
                        ),
                        child: CircleAvatar(
                          radius: 23.5,
                          backgroundColor:Colors.grey.shade200,
                          child: IconButton(
                            onPressed: () {

                            },
                            icon: const Icon(
                              Icons.dark_mode,
                              color: Colors.black,
                            ),
                            tooltip: 'Change Mode',
                          ),
                        ),
                      ),
                      onTap: (){

                      },
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        radius: 19.0,
                        backgroundColor: Colors.blue.shade700,
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
                        color: Colors.grey.shade700,
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
                        backgroundColor: Colors.blue.shade700,
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
                        color: Colors.grey.shade700,
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
                        backgroundColor: Colors.blue.shade700,
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
                        color: Colors.grey.shade700,
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
                        backgroundColor: Colors.blue.shade700,
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
                          color: Colors.blue.shade700,
                        ),
                      ),
                      onTap: () {
                        CacheHelper.removeData(key: 'token').then((value) {
                          if (value == true) {
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
  }
}
