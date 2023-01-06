import 'package:second_app/models/changeModel/ChangePassModel.dart';
import 'package:second_app/models/createProjectModel/CreateProjectModel.dart';
import 'package:second_app/models/deleteModel/DeleteModel.dart';
import 'package:second_app/models/detailsModel/DetailsModel.dart';
import 'package:second_app/models/profileModel/ProfileModel.dart';
import 'package:second_app/models/updateProfileModel/UpdateModel.dart';

abstract class AppStates {}

class InitialAppState extends AppStates {}

class ChangeBottomAppState extends AppStates {}

class ShowBottomSheetAppState extends AppStates {}

class ChangeTitleAppState extends AppStates {}


class ShowFullTextAppState extends AppStates {}


class LoadingProfileAppState extends AppStates {}

class SuccessProfileAppState extends AppStates {
  final ProfileModel? profile;
  SuccessProfileAppState(this.profile);
}

class ErrorProfileAppState extends AppStates {
  final String error;
  ErrorProfileAppState(this.error);
}


class LoadingUpdateProfileAppState extends AppStates {}

class SuccessUpdateProfileAppState extends AppStates {
  final UpdateModel? update;
  SuccessUpdateProfileAppState(this.update);
}

class ErrorUpdateProfileAppState extends AppStates {
  final String error;
  ErrorUpdateProfileAppState(this.error);
}


class LoadingChangePassAppState extends AppStates {}

class SuccessChangePassAppState extends AppStates {
  final ChangePassModel change;
  SuccessChangePassAppState(this.change);
}

class ErrorChangePassAppState extends AppStates {
  final String error;
  ErrorChangePassAppState(this.error);
}


class LoadingLogOutAppState extends AppStates {}

class SuccessLogOutAppState extends AppStates {

}

class ErrorLogOutAppState extends AppStates {
  final String error;
  ErrorLogOutAppState(this.error);
}


class LoadingDeleteAccountAppState extends AppStates {}

class SuccessDeleteAccountAppState extends AppStates {
  final DeleteModel delete;
  SuccessDeleteAccountAppState(this.delete);
}

class ErrorDeleteAccountAppState extends AppStates {
  final String error;
  ErrorDeleteAccountAppState(this.error);
}