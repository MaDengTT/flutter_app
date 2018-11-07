package com.mmd.flutterapp;

import android.os.Bundle;
import android.os.SystemClock;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    PluginsTest.registerWith(this.registrarFor("com.mmd.flutterapp.PluginsTest"));

    new EventChannel(getFlutterView(),"samples.flutter.io/charging").setStreamHandler(
            new EventChannel.StreamHandler() {
              @Override
              public void onListen(Object o, EventChannel.EventSink eventSink) {
                //这个onListen是Flutter端开始监听这个channel时的回调，第二个参数 EventSink是用来传数据的载体。
//                eventSink.success(""); //发送
//                eventSink.error("","","");
                threadTest(eventSink);
              }

              @Override
              public void onCancel(Object o) {
                //对面不在接受
                  isRun = false;
              }
            }
    );
  }
  int i=0;
    boolean isRun = false;

  private void threadTest(final EventChannel.EventSink eventSink) {
      isRun = true;
      new Thread(new Runnable() {
        @Override
        public void run() {
            while (isRun){
                SystemClock.sleep(1000);
                eventSink.success(i++);
            }
        }
      }).start();

  }

}
