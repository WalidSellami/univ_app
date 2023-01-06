import 'package:second_app/models/createProjectModel/CreateProjectModel.dart';
import 'package:second_app/models/deleteModel/DeleteModel.dart';
import 'package:second_app/models/detailsModel/DetailsModel.dart';

abstract class HomeStates {}

class InitialHomeState extends HomeStates {}

class LoadingCreateProjectHomeState extends HomeStates {}

class SuccessCreateProjectHomeState extends HomeStates {
  final CreateProjectModel projectModel;
  SuccessCreateProjectHomeState(this.projectModel);
}

class ErrorCreateProjectHomeState extends HomeStates {
  final String error;
  ErrorCreateProjectHomeState(this.error);
}



class LoadingGetDetailsHomeState extends HomeStates {}

class SuccessGetDetailsHomeState extends HomeStates {
  final DetailsModel projectDetail;
  SuccessGetDetailsHomeState(this.projectDetail);
}

class ErrorGetDetailsHomeState extends HomeStates {
  final String error;
  ErrorGetDetailsHomeState(this.error);
}


class LoadingDeleteProjectHomeState extends HomeStates {}

class SuccessDeleteProjectHomeState extends HomeStates {
  final DeleteModel deletePrj;
  SuccessDeleteProjectHomeState(this.deletePrj);
}

class ErrorDeleteProjectHomeState extends HomeStates {
  final String error;
  ErrorDeleteProjectHomeState(this.error);
}

