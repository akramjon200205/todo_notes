import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoTimePickerStyled extends StatefulWidget {
  final TimeOfDay initialTime;
  final ValueChanged<TimeOfDay> onTimeChanged;
  final VoidCallback? onCancel;
  final VoidCallback? onDone;

  const CupertinoTimePickerStyled({
    super.key,
    required this.initialTime,
    required this.onTimeChanged,
    this.onCancel,
    this.onDone,
  });

  @override
  State<CupertinoTimePickerStyled> createState() =>
      _CupertinoTimePickerStyledState();
}

class _CupertinoTimePickerStyledState extends State<CupertinoTimePickerStyled> {
  late FixedExtentScrollController _hourController;
  late FixedExtentScrollController _minuteController;

  late int selectedHour;
  late int selectedMinute;

  static const double _itemExtent = 44.0;
  static const int _visibleItems = 5;

  @override
  void initState() {
    super.initState();
    selectedHour = widget.initialTime.hour;
    selectedMinute = widget.initialTime.minute;

    _hourController = FixedExtentScrollController(initialItem: selectedHour);
    _minuteController = FixedExtentScrollController(
      initialItem: selectedMinute,
    );
  }

  @override
  void dispose() {
    _hourController.dispose();
    _minuteController.dispose();
    super.dispose();
  }

  void _emitTimeChange() {
    widget.onTimeChanged(TimeOfDay(hour: selectedHour, minute: selectedMinute));
  }

  TextStyle _styleFor(bool selected, BuildContext context) {
    return TextStyle(
      fontSize: selected ? 22 : 18,
      fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
      color: selected
          ? CupertinoColors.label.resolveFrom(context)
          : CupertinoColors.inactiveGray,
    );
  }

  Widget _buildPickerColumn({
    required FixedExtentScrollController controller,
    required int count,
    required int selectedIndex,
    required ValueChanged<int> onChanged,
    required String Function(int) display,
  }) {
    return Expanded(
      child: CupertinoPicker(
        backgroundColor: CupertinoColors.systemGroupedBackground,
        selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
          background: CupertinoColors.systemBackground.withOpacity(0.0),
        ),
        scrollController: controller,
        itemExtent: _itemExtent,
        useMagnifier: true,
        magnification: 1.08,
        onSelectedItemChanged: (i) {
          onChanged(i);
          _emitTimeChange();
          setState(() {});
        },
        children: List.generate(
          count,
          (i) => Center(
            child: Text(
              display(i),
              style: _styleFor(i == selectedIndex, context),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalHeight = _itemExtent * _visibleItems;

    return Container(
      color: CupertinoColors.systemGroupedBackground,
      height: totalHeight + 60,
      child: Column(
        children: [
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            color: CupertinoColors.systemGroupedBackground,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: widget.onCancel,
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      color: CupertinoColors.systemBlue,
                      fontSize: 16,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    widget.onDone?.call();
                    _emitTimeChange();
                  },
                  child: const Text(
                    "Done",
                    style: TextStyle(
                      color: CupertinoColors.systemBlue,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Stack(
              children: [
                Row(
                  children: [
                    _buildPickerColumn(
                      controller: _hourController,
                      count: 24,
                      selectedIndex: selectedHour,
                      onChanged: (v) => selectedHour = v,
                      display: (i) => i.toString().padLeft(2, '0'),
                    ),
                    _buildPickerColumn(
                      controller: _minuteController,
                      count: 60,
                      selectedIndex: selectedMinute,
                      onChanged: (v) => selectedMinute = v,
                      display: (i) => i.toString().padLeft(2, '0'),
                    ),
                  ],
                ),

                Center(
                  child: IgnorePointer(
                    child: Container(
                      height: _itemExtent,
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: CupertinoColors.inactiveGray.withOpacity(
                              0.35,
                            ),
                            width: 1,
                          ),
                          bottom: BorderSide(
                            color: CupertinoColors.inactiveGray.withOpacity(
                              0.35,
                            ),
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
