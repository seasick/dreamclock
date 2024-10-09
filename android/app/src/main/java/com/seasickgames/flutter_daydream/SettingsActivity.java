package com.seasickgames.flutter_daydream;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;

import com.seasickgames.flutter_daydream.MethodChannelHandler;

public class SettingsActivity extends FlutterActivity {

    /*
     * This method is called when the Flutter engine is ready to be used.
     * It sets up the method channel for the Flutter app to communicate with the Android platform.
     */
    @Override
    public void configureFlutterEngine(FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);

        MethodChannelHandler handler = new MethodChannelHandler(
            flutterEngine, this, "settings"
        );
    }
}
