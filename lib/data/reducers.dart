
import 'package:flutter_app/bean/user.dart';
enum Actions{
  Increase,
  Login,
  LoginSuccess,
  LogoutSuccess
}

class AuthState{
  bool isLogin;
  UserBean userBean;
  AuthState({this.isLogin:false,this.userBean});
}

class Action{
  final Actions type;
  Action({this.type});
}

class LoginSuccessAction extends Action{
  final UserBean userBean;
  LoginSuccessAction({
    this.userBean
}):super(type:Actions.LoginSuccess);
}

class AppState{
  AuthState authState;

  AppState({this.authState});
}

AppState mainReducer(AppState state,dynamic action){
  if(action is LoginSuccessAction){
    state.authState.isLogin = true;
    state.authState.userBean = action.userBean;
  }

  if(action == Actions.LogoutSuccess){
    state.authState.isLogin = false;
    state.authState.userBean = null;
  }
  return state;
}

