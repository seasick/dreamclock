package com.seasickgames.dreamclock;

import android.service.dreams.DreamService;
import io.flutter.embedding.android.FlutterView;
import io.flutter.embedding.engine.dart.DartExecutor;
import io.flutter.embedding.engine.FlutterEngine;

import com.seasickgames.dreamclock.MethodChannelHandler;
import com.seasickgames.dreamclock.R;

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

        // Initialiser Method Channel Handler
        MethodChannelHandler handler = new MethodChannelHandler(
            flutterEngine, this, "dream"
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
