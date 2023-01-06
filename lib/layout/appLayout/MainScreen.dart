import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:second_app/layout/appLayout/cubit/Cubit.dart';
import 'package:second_app/layout/appLayout/cubit/States.dart';
import 'package:second_app/layout/checkConection/cubit/Cubit.dart';
import 'package:second_app/layout/checkConection/cubit/States.dart';
import 'package:second_app/layout/darkMode/cubit/Cubit.dart';
import 'package:second_app/layout/darkMode/cubit/States.dart';
import 'package:second_app/modules/homeScreen/cubit/Cubit.dart';
import 'package:second_app/modules/homeScreen/cubit/States.dart';
import 'package:second_app/shared/components/Components.dart';
import 'package:second_app/shared/components/Constant.dart';

// This is a main screen that contain HomeScreen and SettingsScreen
class MainScreen extends StatelessWidget {

  // scaffoldKey is a key that let us to controller the BottomSheet that contain a form to fill
  var scaffoldKey = GlobalKey<ScaffoldState>();

  var formKey = GlobalKey<FormState>();

  var projectController = TextEditingController();
  var yearController = TextEditingController();
  var firstStudentController = TextEditingController();
  var secondStudentController = TextEditingController();
  var thirdStudentController = TextEditingController();
  var supervisorController = TextEditingController();
  var supMarkController = TextEditingController();
  var presidentController = TextEditingController();
  var preMarkController = TextEditingController();
  var examinerController = TextEditingController();
  var exaMarkController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ThemeCubit , ThemeStates>(
          listener: (context , state){},
          builder: (context , state){
            return BlocConsumer<AppCubit , AppStates>(
              listener: (context , state){},
              builder: (context , state){
                return BlocConsumer<HomeCubit , HomeStates>(
                  listener: (context , state){
                    if(state is SuccessCreateProjectHomeState){
                      if(state.projectModel.status == true){

                        HomeCubit.get(context).getDetails();
                        showToast(message: '${state.projectModel.msg}', state: ToastStates.success);
                        Navigator.pop(context);

                      }else{

                        showToast(message: '${state.projectModel.msg}', state: ToastStates.error);

                      }
                    }
                  },
                  builder: (context , state){
                    var cubit = AppCubit.get(context);

                    return Scaffold(
                      key: scaffoldKey,
                      appBar: AppBar(
                        systemOverlayStyle: SystemUiOverlayStyle(
                          statusBarColor: ThemeCubit.get(context).isDark ? HexColor('141414') : Colors.white,
                          statusBarIconBrightness: ThemeCubit.get(context).isDark? Brightness.light : Brightness.dark,
                        ),
                        title: Text(
                          cubit.title,
                          style: const TextStyle(
                            fontSize: 19.0,
                            letterSpacing: 1.0,
                            fontWeight:FontWeight.bold,
                          ),
                        ),
                      ),
                      body: cubit.screens[cubit.currentIndex],
                      bottomNavigationBar: BottomNavigationBar(
                        items: cubit.items,
                        currentIndex: cubit.currentIndex,
                        onTap: (index){
                          cubit.changeBottom(index);
                        },
                      ),
                      floatingActionButton: (cubit.currentIndex == 0) ? FloatingActionButton(
                        onPressed: (){
                          if(cubit.isShow){
                            if(formKey.currentState!.validate()){
                              HomeCubit.get(context).createProject(
                                projectName: projectController.text,
                                year: yearController.text,
                                firstStudentName: firstStudentController.text,
                                secondStudentName: secondStudentController.text,
                                thirdStudentName: thirdStudentController.text,
                                supervisorName: supervisorController.text,
                                supervisorMark: supMarkController.text,
                                presidentName: presidentController.text,
                                presidentMark: preMarkController.text,
                                examinerName: examinerController.text,
                                examinerMark: exaMarkController.text,
                                userId: id,
                              );
                            }

                            if(state is SuccessGetDetailsHomeState) {
                              projectController.text = '';
                              yearController.text = '';
                              firstStudentController.text = '';
                              secondStudentController.text = '';
                              thirdStudentController.text = '';
                              supervisorController.text = '';
                              supMarkController.text = '';
                              presidentController.text = '';
                              preMarkController.text = '';
                              exaMarkController.text = '';
                              exaMarkController.text = '';
                            }

                          }else{
                            scaffoldKey.currentState!.showBottomSheet((context) {
                              cubit.changeTitle(text: 'Fill The Form');
                              return Container(
                                color: ThemeCubit.get(context).isDark ? Colors.grey.shade900.withOpacity(.6) : Colors.grey.shade100,
                                child: Form(
                                  key: formKey,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    physics: const BouncingScrollPhysics(),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        right: 20.0,
                                        left: 20.0,
                                        top: 40.0,
                                        bottom: 20.0,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          defaultSimpleFormField(
                                              text: 'Project Name',
                                              controller: projectController,
                                              type: TextInputType.text,
                                              helperText: 'required',
                                              validate: (value){
                                                if(value == null || value.isEmpty){
                                                  return 'Project Name must not be empty';
                                                }else{
                                                  return null;
                                                }
                                              }),
                                          const SizedBox(
                                            height: 25.0,
                                          ),
                                          defaultSimpleFormField(
                                              text: 'Year',
                                              controller: yearController,
                                              type: TextInputType.number,
                                              helperText: 'required',
                                              validate: (value){
                                                if(value == null || value.isEmpty){
                                                  return 'Year must not be empty';
                                                }else{
                                                  return null;
                                                }
                                              }),
                                          const SizedBox(
                                            height: 25.0,
                                          ),
                                          defaultSimpleFormField(
                                              text: 'First Student Full Name',
                                              controller: firstStudentController,
                                              type: TextInputType.text,
                                              helperText: 'required',
                                              validate: (value){
                                                if(value == null || value.isEmpty){
                                                  return 'First Student Full Name must not be empty';
                                                }else{
                                                  return null;
                                                }
                                              }),
                                          const SizedBox(
                                            height: 25.0,
                                          ),
                                          defaultSimpleFormField(
                                              text: 'Second Student Full Name',
                                              controller: secondStudentController,
                                              type: TextInputType.text,
                                              validate: (value){
                                                return null;
                                              }),
                                          const SizedBox(
                                            height: 25.0,
                                          ),
                                          defaultSimpleFormField(
                                              text: 'Third Student Full Name',
                                              controller: thirdStudentController,
                                              type: TextInputType.text,
                                              validate: (value){
                                                return null;
                                              }),
                                          const SizedBox(
                                            height: 25.0,
                                          ),
                                          defaultSimpleFormField(
                                              text: 'Supervisor Full Name',
                                              controller: supervisorController,
                                              type: TextInputType.text,
                                              helperText: 'required',
                                              validate: (value){
                                                if(value == null || value.isEmpty){
                                                  return 'Supervisor Full Name must not be empty';
                                                }else{
                                                  return null;
                                                }
                                              }),
                                          const SizedBox(
                                            height: 25.0,
                                          ),
                                          defaultSimpleFormField(
                                              text: 'Supervisor Mark',
                                              controller: supMarkController,
                                              type: TextInputType.number,
                                              helperText: 'required',
                                              validate: (value){
                                                if(value == null || value.isEmpty){
                                                  return 'Supervisor Mark must not be empty';
                                                }else{
                                                  return null;
                                                }
                                              }),
                                          const SizedBox(
                                            height: 25.0,
                                          ),
                                          defaultSimpleFormField(
                                              text: 'President Full Name',
                                              controller: presidentController,
                                              type: TextInputType.text,
                                              helperText: 'required',
                                              validate: (value){
                                                if(value == null || value.isEmpty){
                                                  return 'President Full Name must not be empty';
                                                }else{
                                                  return null;
                                                }
                                              }),
                                          const SizedBox(
                                            height: 25.0,
                                          ),
                                          defaultSimpleFormField(
                                              text: 'President Mark',
                                              controller: preMarkController,
                                              type: TextInputType.number,
                                              helperText: 'required',
                                              validate: (value){
                                                if(value == null || value.isEmpty){
                                                  return 'President Mark must not be empty';
                                                }else{
                                                  return null;
                                                }
                                              }),
                                          const SizedBox(
                                            height: 25.0,
                                          ),
                                          defaultSimpleFormField(
                                              text: 'Examiner Full Name',
                                              controller: examinerController,
                                              type: TextInputType.text,
                                              helperText: 'required',
                                              validate: (value){
                                                if(value == null || value.isEmpty){
                                                  return 'Examiner Full Name must not be empty';
                                                }else{
                                                  return null;
                                                }
                                              }),
                                          const SizedBox(
                                            height: 25.0,
                                          ),
                                          defaultSimpleFormField(
                                              text: 'Examiner Mark',
                                              controller: exaMarkController,
                                              type: TextInputType.number,
                                              helperText: 'required',
                                              validate: (value){
                                                if(value == null || value.isEmpty){
                                                  return 'Examiner Mark must not be empty';
                                                }else{
                                                  return null;
                                                }
                                              }),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                              elevation: 25.0,
                            ).closed.then((value) {
                              cubit.changeBottomSheet(icon: Icons.edit, isActive: false);
                              cubit.changeTitle(text: 'Welcome!');
                            });
                            cubit.changeBottomSheet(icon: Icons.add, isActive: true);
                          }
                        },
                        child: Icon(
                          cubit.fabIcon,
                          color: Colors.white,
                        ),
                      ) : null,
                    );
                  },
                );

              },
            );
          },
        );

      }
  }
