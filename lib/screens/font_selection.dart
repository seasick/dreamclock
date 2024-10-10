import 'package:flutter_daydream/extensions/brightness.dart';
import 'package:flutter_daydream/extensions/settings.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';

class FontSelection extends StatefulWidget {
  const FontSelection({super.key});

  @override
  FontSelectionState createState() => FontSelectionState();
}

class FontSelectionState extends State<FontSelection> {
  @override
  Widget build(BuildContext context) {
    String selectedFont = context.settings.font;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick a font'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.canPop(context) ? Navigator.pop(context) : SystemNavigator.pop();
          },
        ),
      ),
      // Fetch the pubspec.yaml file to get the list of fonts
      body: FutureBuilder(
          future: rootBundle.loadString("pubspec.yaml"),
          builder: (context, snapshot) {
            List<String> fonts = [];

            if (snapshot.hasData) {
              YamlMap yaml = loadYaml(snapshot.data!);
              fonts = List<String>.from(yaml["flutter"]["fonts"].toList().map((font) {
                return font["family"].toString();
              }));

              // Sort the fonts by name
              fonts.sort();
            }

            return Center(
              child: SettingsList(brightness: context.brightness, sections: [
                SettingsSection(
                  tiles: fonts.map((fontName) {
                    return SettingsTile(
                      title: Text(
                        fontName,
                        style: TextStyle(fontFamily: fontName),
                      ),
                      onPressed: (BuildContext context) {
                        setState(() {
                          selectedFont = fontName;
                          context.settings.font = fontName;
                        });
                      },
                      trailing: Icon(
                        selectedFont == fontName ? Icons.check : null,
                      ),
                    );
                  }).toList(),
                ),
              ]),
            );
          }),
    );
  }
}
