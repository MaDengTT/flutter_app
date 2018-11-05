import 'package:flutter_app/main.dart';
import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:flutter_app/bean/user.dart';
import 'data/reducers.dart';





void main() {
  Store<AppState> store = new Store<AppState>(mainReducer,initialState: new AppState(
    authState: new AuthState(),
  ));
  runApp(new MyApp(store:store));}