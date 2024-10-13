import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;
import 'package:yaml/yaml.dart';

extension FontsContextExtension<T> on BuildContext {
  static bool _loaded = false;
  static List<Map> _fonts = [];

  Future<void> loadFonts() async {
    if (_loaded) {
      return;
    }

    debugPrint('Loading Fonts');
    try {
      await _loadFonts();
    } on PlatformException catch (e) {
      debugPrint("Failed to get load fonts: '${e.message}'.");
    }

    _loaded = true;
  }

  get fonts {
    return _fonts;
  }

  static Future<void> _loadFonts() async {
    YamlMap yaml = await loadYaml(await rootBundle.loadString("pubspec.yaml"));
    AssetManifest assetManifest = await AssetManifest.loadFromAssetBundle(rootBundle);

    final licences = assetManifest.listAssets().where((string) {
      debugPrint(string);
      return string.startsWith("fonts/") && string.endsWith(".txt");
    }).toList();

    debugPrint("Found ${licences.length} license files");

    _fonts = List<Map>.from(yaml["flutter"]["fonts"].toList().map((font) {
      // Determine directory of font
      String directory = path.dirname(font["fonts"][0]["asset"].toString());

      // Find license file
      String licensePath = licences.firstWhere((element) {
        return element.contains(directory) && element.endsWith(".txt");
      });

      return {
        "family": font["family"].toString(),
        "license": licensePath,
      };
    }));

    // Sort the _fonts list by family name
    _fonts.sort((a, b) => a["family"].compareTo(b["family"]));

    // Add fonts to licence registry
    for (Map font in _fonts) {
      debugPrint("Register license for ${font["family"]} from ${font["license"]}");
      LicenseRegistry.addLicense(() async* {
        final license = await rootBundle.loadString(font["license"]);
        yield LicenseEntryWithLineBreaks([font["family"]], license);
      });
    }
  }
}
