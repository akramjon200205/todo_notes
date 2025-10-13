import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:todo_notes/feature/list/presentation/bloc/list_bloc.dart';

class ColorPickerWidget extends StatefulWidget {
  const ColorPickerWidget({super.key});

  @override
  State<ColorPickerWidget> createState() => _ColorPickerWidgetState();
}

class _ColorPickerWidgetState extends State<ColorPickerWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListBloc, ListState>(
      builder: (context, state) {
        return BlockPicker(
          pickerColor: context.read<ListBloc>().listColor,
          availableColors: [
            Colors.black,
            Colors.white,
            Colors.amber,
            Colors.blue,
            Colors.blueGrey,
            Colors.brown,
            Colors.cyan,
            Colors.blueAccent,
            Colors.cyanAccent,
            Colors.deepOrange,
            Colors.deepOrangeAccent,
            Colors.deepPurple,
          ],
          onColorChanged: (value) {
            context.read<ListBloc>().add(ChangeColorEvent(value));
          },
        );
      },
    );
  }
}
