import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:second_app/layout/appLayout/cubit/Cubit.dart';
import 'package:second_app/layout/appLayout/cubit/States.dart';
import 'package:second_app/layout/checkConection/cubit/Cubit.dart';
import 'package:second_app/layout/checkConection/cubit/States.dart';
import 'package:second_app/layout/darkMode/cubit/Cubit.dart';
import 'package:second_app/models/detailsModel/DetailsModel.dart';
import 'package:second_app/models/pdf/Pdf.dart';
import 'package:second_app/modules/homeScreen/cubit/Cubit.dart';
import 'package:second_app/modules/homeScreen/cubit/States.dart';
import 'package:second_app/modules/sendScreen/SendScreen.dart';
import 'package:second_app/shared/components/Components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:second_app/shared/components/Constant.dart';

class HomeScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit , AppStates>(
          listener: (context , state){
            if(state is SuccessProfileAppState){
              HomeCubit.get(context).getDetails();
            }
          },
          builder: (context , state){
            return BlocConsumer<HomeCubit , HomeStates>(
              listener: (context , state){
                if(state is SuccessDeleteProjectHomeState){
                  if(state.deletePrj.status == true){

                    HomeCubit.get(context).getDetails();
                    showToast(message: '${state.deletePrj.message}', state: ToastStates.success);

                  }else{

                    showToast(message: '${state.deletePrj.message}', state: ToastStates.error);

                  }
                }
              },

              builder: (context , state){
                var detail = HomeCubit.get(context).projectDetail;

                return ConditionalBuilder(
                  condition: ((detail?.detail.length) ?? 0) > 0,
                  builder: (context) => ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context , index) => buildItem(detail?.detail[index], context),
                    itemCount: (detail?.detail.length) ?? 0,
                  ),
                    fallback: (context) => (state is LoadingGetDetailsHomeState) ? Center(child: CircularProgressIndicator(color: ThemeCubit.get(context).isDark
                        ? HexColor('198989') : Colors.blue.shade700,)) :  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'No Projects Added',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'Press on the button to add projects',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                );
              },
            );
          },
        );
      }
  }

  Widget buildItem(DetailData? data , context) => Padding(
    padding: const EdgeInsets.only(
     left: 16.0,
     right: 16.0,
     top: 20.0,
     bottom: 50.0,
    ),
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            border: Border.all(
               width: 2.0,
               color: ThemeCubit.get(context).isDark ? Colors.white : Colors.black,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  radius: 20.0,
                  backgroundColor: ThemeCubit.get(context).isDark ? Colors.grey.shade700.withOpacity(.6) : Colors.grey.shade200,
                  child: IconButton(
                    onPressed: (){
                      projectId = data?.id;
                      HomeCubit.get(context).deleteProject();
                    },
                    icon: Icon(
                      Icons.close_rounded,
                      color: ThemeCubit.get(context).isDark ? Colors.white : Colors.black,
                      size: 25.0,
                    ),
                    tooltip: 'Remove',
                  ),
                ),
              ),
              Row(
                children:  [
                  const Text(
                    'Project Name :',
                    style: TextStyle(
                      fontSize: 19.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        AppCubit.get(context).showFullText1();
                      },
                      child: Text(
                        '${data?.projectName}',
                        maxLines: AppCubit.get(context).isHide1 ? 1 : null,
                        overflow: AppCubit.get(context).isHide1 ? TextOverflow.ellipsis : null,
                        style: const TextStyle(
                          fontSize: 19.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15.0,
              ),
              Row(
                children: [
                  const Text(
                    'Year :',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Expanded(
                    child: Text(
                      '${data?.year}',
                      style: const TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15.0,
              ),
              Row(
                children: [
                  const Text(
                    '1- Student Name :',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        AppCubit.get(context).showFullText2();
                      },
                      child: Text(
                        '${data?.firstStudent}',
                        maxLines:  AppCubit.get(context).isHide2 ? 1 : null,
                        overflow:  AppCubit.get(context).isHide2 ? TextOverflow.ellipsis : null,
                        style: const TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15.0,
              ),
              (data?.secondStudent != '') ?
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 14.0,
                  ),
                  child: Row(
                    children: [
                      const Text(
                        '2- Student Name :',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            AppCubit.get(context).showFullText3();
                          },
                          child: Text(
                            '${data?.secondStudent}',
                            maxLines:  AppCubit.get(context).isHide3 ? 1 : null,
                            overflow:  AppCubit.get(context).isHide3 ? TextOverflow.ellipsis : null,
                            style: const TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ) : Container(),
                // const SizedBox(
                //   height: 15.0,
                //
              (data?.thirdStudent != '') ?
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 14.0,
                  ),
                  child: Row(
                  children:  [
                    const Text(
                      '3- Student Name :',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          AppCubit.get(context).showFullText4();
                        },
                        child: Text(
                          '${data?.thirdStudent}',
                          maxLines:  AppCubit.get(context).isHide4 ? 1 : null,
                          overflow:  AppCubit.get(context).isHide4 ? TextOverflow.ellipsis : null,
                          style: const TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                  ],
              ),
                ) : Container(),
              // const SizedBox(
              //   height: 15.0,
              // ),
              Row(
                children:  [
                  const Text(
                    'Supervisor Name :',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        AppCubit.get(context).showFullText5();
                      },
                      child: Text(
                        '${data?.supervisorName}',
                        maxLines:  AppCubit.get(context).isHide5 ? 1 : null,
                        overflow:  AppCubit.get(context).isHide5 ? TextOverflow.ellipsis : null,
                        style: const TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 14.0,
              ),
              Row(
                children:  [
                  const Text(
                    'Supervisor Mark :',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    '${data?.supervisorMark}',
                    style: const TextStyle(
                      fontSize: 19.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15.0,
              ),
              Row(
                children: [
                  const Text(
                    'President Name :',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        AppCubit.get(context).showFullText6();
                      },
                      child: Text(
                        '${data?.presidentName}',
                        maxLines:  AppCubit.get(context).isHide6 ? 1 : null,
                        overflow:  AppCubit.get(context).isHide6 ? TextOverflow.ellipsis : null,
                        style: const TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15.0,
              ),
              Row(
                children: [
                  const Text(
                    'President Mark :',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    '${data?.presidentMark}',
                    style: const TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15.0,
              ),
              Row(
                children:  [
                  const Text(
                    'Examiner Name :',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        AppCubit.get(context).showFullText7();
                      },
                      child: Text(
                        '${data?.examinerName}',
                        maxLines:  AppCubit.get(context).isHide7 ? 1 : null,
                        overflow:  AppCubit.get(context).isHide7 ? TextOverflow.ellipsis : null,
                        style: const TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15.0,
              ),
              Row(
                children:  [
                  const Text(
                    'Examiner Mark :',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    '${data?.examinerMark}',
                    style: const TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 9.0,
              ),
               Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: Divider(
                  color: ThemeCubit.get(context).isDark ? Colors.white : Colors.black,
                  thickness: 1.0,
                ),
              ),
              const SizedBox(
                height: 9.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Final Mark :',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    '${data?.finalMark}',
                    style: const TextStyle(
                      fontSize: 21.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  defaultElevatedButton(
                      text: 'Send a copy',
                      onPress: (){
                        print(data?.id);
                        subjectController.text = 'ViVa Detail';
                        messageController.text = 'Year : ${data?.year}\nSupervisor Name : ${data?.supervisorName}\nSupervisor Mark: ${data?.supervisorMark}\nPresident Name : ${data?.presidentName}\nPresident Mark: ${data?.presidentMark}\nExaminer Name : ${data?.examinerName}\nExaminer Mark: ${data?.examinerMark}\n'
                            '1- Student Name : ${data?.firstStudent}\n2- Student Name : ${data?.secondStudent}\n3- Student Name : ${data?.thirdStudent}\nFinalMark : ${data?.finalMark}';
                        navigatorTo(context: context, screen: SendScreen());
                      },
                    color:ThemeCubit.get(context).isDark ? HexColor('198989') : Colors.blue.shade700,
                  ),

                  defaultElevatedButton(
                    text: 'Generate PDF',
                    onPress: () async{
                      final pdfFile = await Pdf.generate(
                        projectName: data?.projectName,
                        year: data?.year,
                        firstStudent: data?.firstStudent,
                        secondStudent: data?.secondStudent,
                        thirdStudent: data?.thirdStudent,
                        supervisorName: data?.supervisorName,
                        supervisorMark: data?.supervisorMark,
                        presidentName: data?.presidentName,
                        presidentMark: data?.presidentMark,
                        examinerName: data?.examinerName,
                        examinerMark: data?.examinerMark,
                        finalMark: data?.finalMark,
                      );
                      Pdf.openFile(pdfFile);
                    },
                    color:ThemeCubit.get(context).isDark ? HexColor('198989') : Colors.blue.shade700,
                  ),
                ],
              ),
              const SizedBox(
                height: 8.0,
              ),
            ],
          ),
        ),
      ],
    ),
  );
