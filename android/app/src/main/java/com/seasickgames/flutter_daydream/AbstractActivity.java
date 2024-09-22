package com.seasickgames.flutter_daydream;

import com.seasickgames.flutter_daydream.utils.MethodChannelFactory;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugin.common.MethodChannel;
import java.util.HashMap;
import java.util.function.Function;

abstract public class AbstractActivity extends FlutterActivity {

    abstract String getInitialRouteData();

    public MethodChannel setupMethodChannel(FlutterEngine flutterEngine) {
        HashMap<String, Function> handlers = new HashMap<>();
        handlers.put("getInitialRoute", (args) -> getInitialRouteData());

        return MethodChannelFactory.create(flutterEngine, handlers);
    }
}
