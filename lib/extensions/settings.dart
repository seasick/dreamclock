// Provides an extension on BuildContext to access and load settings.
//
// Settings include:
// - batteryPercentage, burnInPrevention,
//   twentyFourHourFormat, showSeconds, backgroundColor, fontColor.

import 'package:flutter/widgets.dart';
import 'package:flutter_daydream/services/settings.dart';

extension SettingsContextExtension<T> on BuildContext {
  static final SettingsObject _settings = SettingsObject();

  Future<void> loadSettings() async {
    return _settings.loadSettings();
  }

  SettingsObject get settings {
    return _settings;
  }
}

class SettingsObject {
  bool _alarm = false;
  Color _backgroundColor = const Color.fromARGB(255, 0, 0, 0);
  Color _fontColor = const Color.fromARGB(255, 209, 209, 209);
  bool _batteryPercentage = false;
  bool _burnInPrevention = false;
  bool _showSeconds = false;
  bool _twentyFourHourFormat = true;

  final SettingsService _settingsService = SettingsService();
  static bool _loaded = false;

  // Getter and setter for alarm
  bool get alarm => _alarm;
  set alarm(bool value) {
    _settingsService.saveBoolSetting('alarm', value);
    _alarm = value;
  }

  // Getter and setter for batteryPercentage
  bool get batteryPercentage => _batteryPercentage;
  set batteryPercentage(bool value) {
    _settingsService.saveBoolSetting('batteryPercentage', value);
    _batteryPercentage = value;
  }

  // Getter and setter for backgroundColor
  Color get backgroundColor => _backgroundColor;
  set backgroundColor(Color value) {
    _settingsService.saveColorSetting('backgroundColor', value);
    _backgroundColor = value;
  }

  // Getter and setter for burnInPrevention
  bool get burnInPrevention => _burnInPrevention;
  set burnInPrevention(bool value) {
    _settingsService.saveBoolSetting('burnInPrevention', value);
    _burnInPrevention = value;
  }

  // Getter and setter for fontColor
  Color get fontColor => _fontColor;
  set fontColor(Color value) {
    _settingsService.saveColorSetting('fontColor', value);
    _fontColor = value;
  }

  // Getter and setter for twentyFourHourFormat
  bool get twentyFourHourFormat => _twentyFourHourFormat;
  set twentyFourHourFormat(bool value) {
    _settingsService.saveBoolSetting('twentyFourHourFormat', value);
    _twentyFourHourFormat = value;
  }

  // Getter and setter for showSeconds
  bool get showSeconds => _showSeconds;
  set showSeconds(bool value) {
    _settingsService.saveBoolSetting('showSeconds', value);
    _showSeconds = value;
  }

  void loadSettings() async {
    if (_loaded) {
      return;
    }

    debugPrint('Loading settings...');

    List<SettingField> fields = [
      SettingField('alarm', 'bool', (value) => _alarm = value, false),
      SettingField('batteryPercentage', 'bool', (value) => _batteryPercentage = value, false),
      SettingField('burnInPrevention', 'bool', (value) => _burnInPrevention = value, false),
      SettingField('twentyFourHourFormat', 'bool', (value) => _twentyFourHourFormat = value, true),
      SettingField('showSeconds', 'bool', (value) => _showSeconds = value, false),
      SettingField('backgroundColor', 'color', (value) => _backgroundColor = value,
          const Color.fromARGB(255, 0, 0, 0)),
      SettingField('fontColor', 'color', (value) => _fontColor = value,
          const Color.fromARGB(255, 209, 209, 209)),
    ];

    for (SettingField field in fields) {
      var key = field.key;
      var type = field.type;

      switch (type) {
        case 'double':
          double? value = await _settingsService.getDoubleSetting(key);
          field.setValue(value ?? field.defaultValue);
          break;
        case 'bool':
          bool? value = await _settingsService.getBoolSetting(key);
          field.setValue(value ?? field.defaultValue);
          break;
        case 'color':
          Color? value = await _settingsService.getColorSetting(key);
          field.setValue(value ?? field.defaultValue);
          break;
      }
    }

    _loaded = true;
  }
}

class SettingField {
  final String key;
  final String type;
  final Function(dynamic) setValue;
  final dynamic defaultValue;

  SettingField(this.key, this.type, this.setValue, this.defaultValue);
}
