import 'package:flutter_app/main.dart';
import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:flutter_app/bean/user.dart';


class APPState{
  UserBean userBean;
  APPState(this.userBean);
}

APPState mainReducer(APPState state,dynamic action){
  state = action;
  return state;
}


void main() {
  final store = new Store<APPState>(mainReducer,initialState: new APPState(null));
  runApp(new MyApp());}