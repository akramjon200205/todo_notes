// ColorPickerWidget.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:todo_notes/feature/list/presentation/bloc/list_bloc.dart';

class ColorPickerWidget extends StatelessWidget {
  final Color color;
  const ColorPickerWidget({required this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListBloc, ListState>(
      builder: (context, state) {
        final bloc = context.read<ListBloc>();
        return BlockPicker(
          pickerColor: bloc.listColor,
          availableColors: [
            Colors.black,
            Colors.white,
            Colors.amber,
            Colors.blue,
            Colors.blueGrey,
            Colors.brown,
            Colors.cyan,
            Colors.blueAccent,
            Colors.deepOrange,
            Colors.deepOrangeAccent,
            Colors.deepPurple,
          ],
          onColorChanged: (value) {
            bloc.add(ChangeColorEvent(value));
          },
        );
      },
    );
  }
}
