import 'package:flutter_daydream/extensions/brightness.dart';
import 'package:flutter_daydream/extensions/settings.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class FontSelection extends StatefulWidget {
  const FontSelection({super.key});

  @override
  FontSelectionState createState() => FontSelectionState();
}

class FontSelectionState extends State<FontSelection> {
  @override
  Widget build(BuildContext context) {
    String selectedFont = context.settings.font;

    // TODO These fonts should be downloaded at build time
    final List<String> myGoogleFonts = [
      "Concert One",
      "Monoton",
      "Orbitron",
      "Pirata One",
      "Pixelify Sans",
      "Roboto",
      "Silkscreen",
      "Sixtyfour",
    ];

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
      body: Center(
        child: SettingsList(brightness: context.brightness, sections: [
          SettingsSection(
            tiles: myGoogleFonts.map((fontName) {
              return SettingsTile(
                title: Text(
                  fontName,
                  style: GoogleFonts.getFont(fontName),
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
      ),
    );
  }
}
