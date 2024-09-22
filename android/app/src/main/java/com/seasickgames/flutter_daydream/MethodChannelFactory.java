package com.seasickgames.flutter_daydream.utils;

import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import java.util.HashMap;
import java.util.function.Function;

public class MethodChannelFactory {

    private static final String CHANNEL = "seasickgames.com/daydream";

    public static MethodChannel create(FlutterEngine flutterEngine, HashMap<String, Function> handlers) {
        MethodChannel channel = new MethodChannel(
            flutterEngine.getDartExecutor().getBinaryMessenger(),
            CHANNEL
        );

        channel.setMethodCallHandler(
            (call, result) -> {
                if (handlers.containsKey(call.method)) {
                    Object value = handlers.get(call.method).apply(null);
                    result.success(value);
                } else {
                    result.notImplemented();
                }
            }
        );

        return channel;
    }
}
