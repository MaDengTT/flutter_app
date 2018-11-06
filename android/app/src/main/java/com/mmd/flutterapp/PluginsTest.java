package com.mmd.flutterapp;


import android.content.Context;
import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.BatteryManager;
import android.os.Build;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

import static android.content.Context.BATTERY_SERVICE;

/**
 * Created by MaDeng on 2018/11/6.
 */
public class PluginsTest implements MethodChannel.MethodCallHandler {

    private final PluginRegistry.Registrar mRegistrar;
    Context context;

    public PluginsTest(PluginRegistry.Registrar registrar) {
        this.mRegistrar = registrar;
        this.context = mRegistrar.context();
    }

    public static void registerWith(PluginRegistry.Registrar registrar) {
        MethodChannel channel =
                new MethodChannel(registrar.messenger(), "com.mmd.flutter_app/plugins_test");
        PluginsTest instance = new PluginsTest(registrar);
        channel.setMethodCallHandler(instance);
    }

    @Override
    public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
        switch (methodCall.method) {
            case "getBatteryLevel":
                result.success(getBatteryLevel());
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    /**
     * 获取电池电量
     *
     * @return
     */
    private int getBatteryLevel() {

        int batteryLevel = -1;
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            BatteryManager batteryManager = (BatteryManager) context.getSystemService(BATTERY_SERVICE);
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY);
        } else {
            Intent intent = new ContextWrapper(context.getApplicationContext()).
                    registerReceiver(null, new IntentFilter(Intent.ACTION_BATTERY_CHANGED));
            batteryLevel = (intent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100) /
                    intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1);
        }
        return batteryLevel;
    }

}
