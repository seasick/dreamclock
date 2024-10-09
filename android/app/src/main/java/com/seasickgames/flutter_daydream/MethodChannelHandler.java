package com.seasickgames.flutter_daydream;

import android.content.ContextWrapper;
import android.os.BatteryManager;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import java.util.function.Function;
import java.util.HashMap;

public class MethodChannelHandler {

    /**
     * The channel name for the Flutter app to communicate with the Android platform.
     */
    private final String CHANNEL = "seasickgames.com/daydream";

    /**
     * The method channel for the Flutter app to communicate with the Android platform.
     */
    private final MethodChannel channel;

    /**
     * The context of the Android platform.
     */
    private final ContextWrapper context;

    /**
     * The initial route of the Flutter app.
     */
    private final String initialRoute;

    /**
     * Creates a new method channel handler for the Flutter app to communicate with the Android platform.
     *
     * @param flutterEngine The Flutter engine.
     * @param context The context of the Android platform.
     * @param initialRoute The initial route of the Flutter app.
     */
    public MethodChannelHandler(FlutterEngine flutterEngine, ContextWrapper context, String initialRoute) {
        this.context = context;
        this.initialRoute = initialRoute;

        channel = new MethodChannel(
            flutterEngine.getDartExecutor().getBinaryMessenger(),
            CHANNEL
        );

        channel.setMethodCallHandler(
            (call, result) -> {
                if (call.method.equals("getBatteryLevel")) {
                    result.success(getBatteryLevel());
                } else if (call.method.equals("getInitialRoute")) {
                    result.success(getInitialRoute());
                } else {
                    result.notImplemented();
                }
            }
        );
    }

    private String getInitialRoute() {
        return initialRoute;
    }

    private int getBatteryLevel() {
        BatteryManager bm = (BatteryManager) context.getSystemService(BatteryManager.class);
        int batLevel = bm.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY);

        return batLevel;
    }
}
