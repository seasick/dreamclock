import 'package:dreamclock/extensions/brightness.dart';
import 'package:dreamclock/extensions/settings.dart';
import 'package:dreamclock/screens/font_selection.dart';
import 'package:dreamclock/widgets/color_picker_tile.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  SettingsState createState() => SettingsState();
}

class SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.canPop(context) ? Navigator.pop(context) : SystemNavigator.pop();
          },
        ),
      ),
      body: Center(
        child: SettingsList(
          brightness: context.brightness,
          sections: [
            // Common settings
            SettingsSection(
              // title: Text('Section'),
              tiles: [
                SettingsTile.switchTile(
                  title: const Text('Alarm'),
                  description: const Text('Show next alarm time'),
                  leading: const Icon(Icons.alarm),
                  initialValue: context.settings.alarm,
                  onToggle: (bool value) {
                    setState(() {
                      context.settings.alarm = value;
                    });
                  },
                ),
                SettingsTile.switchTile(
                  title: const Text('Battery Percentage'),
                  description: const Text('Show battery percentage on screen'),
                  leading: const Icon(Icons.battery_5_bar),
                  initialValue: context.settings.batteryPercentage,
                  onToggle: (bool value) {
                    setState(() {
                      context.settings.batteryPercentage = value;
                    });
                  },
                ),
                SettingsTile.switchTile(
                  title: const Text('Burn-in prevention'),
                  description: const Text('Moves the clock slightly'),
                  leading: const Icon(Icons.fit_screen),
                  initialValue: context.settings.burnInPrevention,
                  onToggle: (bool value) {
                    setState(() {
                      context.settings.burnInPrevention = value;
                    });
                  },
                ),
              ],
            ),

            // Clock
            SettingsSection(
              title: const Text('Clock'),
              tiles: [
                SettingsTile.switchTile(
                  title: const Text('24h format'),
                  description: const Text('Show time in 24h format'),
                  leading: const Icon(Icons.hourglass_bottom),
                  initialValue: context.settings.twentyFourHourFormat,
                  onToggle: (bool value) {
                    setState(() {
                      context.settings.twentyFourHourFormat = value;
                    });
                  },
                ),
                SettingsTile.switchTile(
                  title: const Text('Show seconds'),
                  description: const Text('Show seconds in the clock'),
                  leading: const Icon(Icons.timelapse),
                  initialValue: context.settings.showSeconds,
                  onToggle: (bool value) {
                    setState(() {
                      context.settings.showSeconds = value;
                    });
                  },
                ),
              ],
            ),

            // Colors & Fonts
            SettingsSection(
              title: const Text('Colors & Fonts'),
              tiles: [
                SettingsTile.navigation(
                  title: const Text("Font"),
                  leading: const Icon(Icons.font_download),
                  onPressed: (context) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FontSelection(),
                      ),
                    ).then((context) {
                      // FontSelection will update the font in the settings,
                      // so we need to update the UI
                      setState(() {});
                    });
                  },
                  trailing: Text(
                    context.settings.font,
                    style: TextStyle(fontFamily: context.settings.font),
                  ),
                ),
                ColorPickerTile(
                  title: const Text('Font Color'),
                  leading: const Icon(Icons.color_lens),
                  value: context.settings.fontColor,
                  onColorChanged: (Color color) {
                    setState(() {
                      context.settings.fontColor = color;
                    });
                  },
                  trailing: Icon(Icons.circle, color: context.settings.fontColor),
                ),
                ColorPickerTile(
                  title: const Text('Background Color'),
                  leading: const Icon(Icons.color_lens),
                  value: context.settings.backgroundColor,
                  onColorChanged: (Color color) {
                    setState(() {
                      context.settings.backgroundColor = color;
                    });
                  },
                  trailing: Icon(Icons.circle, color: context.settings.backgroundColor),
                ),
              ],
            ),

            // About section
            SettingsSection(title: const Text('About'), tiles: [
              SettingsTile(
                title: const Text('Show Licences'),
                description: const Text('Shows licenses for software used by this application'),
                leading: const Icon(Icons.battery_5_bar),
                onPressed: (BuildContext context) {
                  showLicensePage(
                    context: context,
                  );
                },
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
