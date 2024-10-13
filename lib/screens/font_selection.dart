import 'package:flutter_daydream/extensions/brightness.dart';
import 'package:flutter_daydream/extensions/fonts.dart';
import 'package:flutter_daydream/extensions/settings.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      body: Center(
        child: SettingsList(brightness: context.brightness, sections: [
          SettingsSection(
            tiles: List<AbstractSettingsTile>.from(
              context.fonts.map((font) {
                return SettingsTile(
                  title: Text(
                    font["family"],
                    style: TextStyle(fontFamily: font["family"]),
                  ),
                  onPressed: (BuildContext context) {
                    setState(() {
                      selectedFont = font["family"];
                      context.settings.font = font["family"];
                    });
                  },
                  trailing: Icon(
                    selectedFont == font["family"] ? Icons.check : null,
                  ),
                );
              }),
            ),
          ),
        ]),
      ),
    );
  }
}
