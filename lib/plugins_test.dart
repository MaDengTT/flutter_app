import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

const MethodChannel _channel =
const MethodChannel('com.mmd.flutter_app/plugins_test');

Future<int> getBatteryLevel() async {
  if (Platform.isIOS)
    throw new UnsupportedError("Functionality not available on iOS");
  final int level = await _channel.invokeMethod('getBatteryLevel');
  return level;
}

//_channel.setMethodCallHandler(platformCallHandler);

Future<dynamic> platformCallHandler(MethodCall call)async{
  switch(call.method) {
    case "getName":
      return "Hello from Flutter";
      break;
  }
}

const EventChannel _eventChannel =
const EventChannel("samples.flutter.io/charging");

void registerAndroidStream(Function onEvent,Function onError){
  _eventChannel.receiveBroadcastStream().listen(onEvent,onError: onError);
}