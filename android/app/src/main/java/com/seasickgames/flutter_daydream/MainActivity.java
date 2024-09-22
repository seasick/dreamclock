package com.seasickgames.flutter_daydream;

import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends AbstractActivity {
    @Override
    public void configureFlutterEngine(FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        setupMethodChannel(flutterEngine);
    }

    @Override
    String getInitialRouteData() {
        return "main";
    }
}
