import 'package:flutter_daydream/widgets/color_picker_dialog.dart';
import 'package:flutter_settings_ui/flutter_settings_ui.dart';
import 'package:flutter/material.dart';

class ColorPickerTile extends SettingsTile {
  ColorPickerTile({
    super.key,
    super.leading,
    super.trailing,
    required Color value,
    required super.title,
    super.description,
    super.descriptionInlineIos = false,
    required Function(Color) onColorChanged,
    super.enabled = true,
    super.backgroundColor,
  }) : super(
          onPressed: (BuildContext context) {
            debugPrint("ColorPickerTile.onPressed");

            showDialog(
              context: context,
              builder: (context) {
                return ColorPickerDialog(
                  title: title,
                  color: value,
                  onColorChanged: onColorChanged,
                );
              },
            );
          },
        );
}
