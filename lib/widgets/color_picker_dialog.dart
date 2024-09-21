// A stateful widget wrapping around the AlertDialog
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';

class ColorPickerDialog extends StatefulWidget {
  const ColorPickerDialog({
    super.key,
    required this.title,
    required this.color,
    required this.onColorChanged,
  });

  final String title;
  final Color color;
  final void Function(Color) onColorChanged;

  @override
  State<ColorPickerDialog> createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {
  late Color pickerColor;

  @override
  void initState() {
    super.initState();
    pickerColor = widget.color;
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("ColorPickerDialog.build");

    return AlertDialog(
      title: Text(widget.title),
      content: SingleChildScrollView(
        child: ColorPicker(
          enableShadesSelection: false,
          pickersEnabled: const <ColorPickerType, bool>{
            ColorPickerType.accent: false,
            ColorPickerType.primary: false,
            ColorPickerType.wheel: true,
          },
          color: pickerColor,
          onColorChanged: (Color color) => setState(() => pickerColor = color),
          width: 44,
          height: 44,
          borderRadius: 22,
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          child: const Text('Got it'),
          onPressed: () {
            debugPrint("ColorPickerDialog.actions.pressed");
            widget.onColorChanged(pickerColor);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
