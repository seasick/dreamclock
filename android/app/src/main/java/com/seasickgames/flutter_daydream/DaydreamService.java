package com.seasickgames.flutter_daydream;

import android.view.WindowManager.LayoutParams;
import android.service.dreams.DreamService;

import io.flutter.FlutterInjector;
import io.flutter.embedding.android.FlutterView;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.dart.DartExecutor;
import io.flutter.embedding.engine.loader.FlutterLoader;
import io.flutter.embedding.engine.plugins.shim.ShimPluginRegistry;
import io.flutter.embedding.engine.plugins.util.GeneratedPluginRegister;

import com.seasickgames.flutter_daydream.R;

public class DaydreamService extends DreamService {
    private FlutterEngine flutterEngine;
    private FlutterView flutterView;

    @Override
    public void onAttachedToWindow() {
        super.onAttachedToWindow();

        setInteractive(true);
        setFullscreen(true);

        // Initialiser Flutter Engine
        flutterEngine = new FlutterEngine(this);
        flutterEngine.getDartExecutor().executeDartEntrypoint(
            DartExecutor.DartEntrypoint.createDefault()
        );

        setContentView(R.layout.flutter_wrap);

        flutterView = findViewById(R.id.flutterView);
        flutterView.attachToFlutterEngine(flutterEngine);
    }

    @Override
    public void onDestroy() {
        flutterEngine.destroy();
        flutterEngine = null;

        super.onDestroy();
    }

    @Override
    public void onDreamingStarted() {
        super.onDreamingStarted();
        flutterEngine.getLifecycleChannel().appIsResumed();
    }

    @Override
    public void onDreamingStopped() {
        super.onDreamingStopped();
        flutterEngine.getLifecycleChannel().appIsPaused();
    }

    @Override
    public void onDetachedFromWindow() {
        super.onDetachedFromWindow();

        flutterView.detachFromFlutterEngine();
        flutterView = null;

        flutterEngine.getLifecycleChannel().appIsDetached();
        flutterEngine.destroy();
        flutterEngine = null;
    }
}
