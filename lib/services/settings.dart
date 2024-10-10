import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  final SharedPreferencesAsync asyncPrefs = SharedPreferencesAsync();

  Future<void> saveSetting(String key, String value) async {
    debugPrint("SettingsService.saveSetting");
    await asyncPrefs.setString(key, value);
  }

  Future<String?> getSetting(String key) async {
    String? value = await asyncPrefs.getString(key);
    debugPrint("SettingsService.getSetting($key) => $value");
    return value;
  }

  Future<void> saveBoolSetting(String key, bool value) async {
    debugPrint("SettingsService.saveBoolSetting");
    await asyncPrefs.setBool(key, value);
  }

  Future<bool?> getBoolSetting(String key) async {
    bool? value = await asyncPrefs.getBool(key);
    debugPrint("SettingsService.getBoolSetting($key) => $value");
    return value;
  }

  Future<void> saveColorSetting(String key, Color value) async {
    debugPrint("SettingsService.saveColorSetting");
    await asyncPrefs.setInt(key, value.value);
  }

  Future<Color?> getColorSetting(String key) async {
    final int? colorValue = await asyncPrefs.getInt(key);
    debugPrint("SettingsService.getColorSetting($key) => $colorValue");

    if (colorValue != null) {
      return Color(colorValue);
    }
    return null;
  }

  Future<void> saveDoubleSetting(String key, double value) async {
    debugPrint("SettingsService.saveDoubleSetting");
    await asyncPrefs.setDouble(key, value);
  }

  Future<double?> getDoubleSetting(String key) async {
    double? value = await asyncPrefs.getDouble(key);
    debugPrint("SettingsService.getDoubleSetting($key) => $value");
    return value;
  }

  Future<void> saveIntSetting(String key, int value) async {
    debugPrint("SettingsService.saveIntSetting");
    await asyncPrefs.setInt(key, value);
  }

  Future<int?> getIntSetting(String key) async {
    int? value = await asyncPrefs.getInt(key);
    debugPrint("SettingsService.getIntSetting($key) => $value");
    return value;
  }
}
