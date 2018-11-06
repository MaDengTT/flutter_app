import 'dart:io';

import 'package:flutter_app/main.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'package:redux/redux.dart';
import 'package:sqflite/sqflite.dart';
import 'data/reducers.dart';
import 'data/sp.dart' as SP;
Test()async{
  Directory documentsDirectory = await getApplicationDocumentsDirectory();
  print(documentsDirectory);
}

void main() {
  Store<AppState> store = new Store<AppState>(mainReducer,initialState: new AppState(
    authState: new AuthState(),
  ));
  SP.isLogin().then((value){
    if(value!=null&&value) {
      return SP.getUserId();
    }else{
      print("not login");
    }
  }).then((userID){
    print(userID);
  }).whenComplete(()=>(print("complete")));
  print("main");
  Test();
  runApp(new MyApp(store:store));}