import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Cupertino style hour:minute picker that visually matches iOS look:
/// - two thin horizontal lines in center (selection zone)
/// - selected item is darker & larger
/// - fallback overlay if selectionOverlay not applied on some Flutter versions
class CupertinoTimePickerStyled extends StatefulWidget {
  final TimeOfDay initialTime;
  final ValueChanged<TimeOfDay> onTimeChanged;

  const CupertinoTimePickerStyled({
    super.key,
    required this.initialTime,
    required this.onTimeChanged,
  });

  @override
  State<CupertinoTimePickerStyled> createState() =>
      _CupertinoTimePickerStyledState();
}

class _CupertinoTimePickerStyledState extends State<CupertinoTimePickerStyled> {
  late int selectedHour;
  late int selectedMinute;

  static const double _itemExtent = 44.0;
  static const int _visibleItems = 5;
  final FixedExtentScrollController _hourController =
      FixedExtentScrollController();
  final FixedExtentScrollController _minuteController =
      FixedExtentScrollController();

  @override
  void initState() {
    super.initState();
    selectedHour = widget.initialTime.hour;
    selectedMinute = widget.initialTime.minute;
    // jumpToItem after first frame to avoid controller errors
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _hourController.jumpToItem(selectedHour);
      _minuteController.jumpToItem(selectedMinute);
    });
  }

  @override
  void dispose() {
    _hourController.dispose();
    _minuteController.dispose();
    super.dispose();
  }

  void _onChanged() {
    widget.onTimeChanged(TimeOfDay(hour: selectedHour, minute: selectedMinute));
  }

  TextStyle _styleFor(bool selected, BuildContext context) {
    // selected - bold and darker; others - faded gray
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
        // Selection overlay (works on modern Flutter)
        selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
          background: CupertinoColors.systemBackground.withOpacity(0.0),
        ),
        scrollController: controller,
        itemExtent: _itemExtent,
        useMagnifier: true,
        magnification: 1.08,
        onSelectedItemChanged: (i) {
          setState(() {
            onChanged(i);
          });
          _onChanged();
        },
        children: List<Widget>.generate(count, (i) {
          final selected = i == selectedIndex;
          return Center(
            child: Builder(
              builder: (context) {
                return Text(display(i), style: _styleFor(selected, context));
              },
            ),
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // total height = itemExtent * visibleItems
    final double totalHeight = _itemExtent * _visibleItems;

    return Container(
      height: totalHeight,
      color: CupertinoColors.systemGroupedBackground,
      child: Stack(
        children: [
          // Row with two pickers
          Row(
            children: [
              _buildPickerColumn(
                controller: _hourController,
                count: 24,
                selectedIndex: selectedHour,
                onChanged: (v) => selectedHour = v,
                display: (i) => i.toString().padLeft(2, '0'),
              ),
              // colon
              // SizedBox(
              //   width: 28,
              //   child: Center(
              //     child: Text(':',
              //         style: TextStyle(
              //             fontSize: 22,
              //             color: CupertinoColors.label.resolveFrom(context),
              //             fontWeight: FontWeight.bold)),
              //   ),
              // ),
              _buildPickerColumn(
                controller: _minuteController,
                count: 60,
                selectedIndex: selectedMinute,
                onChanged: (v) => selectedMinute = v,
                display: (i) => i.toString().padLeft(2, '0'),
              ),
            ],
          ),

          // Custom selection overlay (fallback & visual separator lines)
          // Center a transparent container with top & bottom borders
          Center(
            child: IgnorePointer(
              ignoring: true,
              child: Container(
                height: _itemExtent,
                decoration: BoxDecoration(
                  // Transparent fill so underlying picker shows
                  color: Colors.transparent,
                  border: Border(
                    top: BorderSide(
                      color: CupertinoColors.inactiveGray.withOpacity(0.35),
                      width: 1.0,
                    ),
                    bottom: BorderSide(
                      color: CupertinoColors.inactiveGray.withOpacity(0.35),
                      width: 1.0,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Optional faint overlay to slightly highlight selection strip background
          // (uncomment if you want a subtle background color behind selected row)
          /*
          Center(
            child: Container(
              height: _itemExtent,
              color: CupertinoColors.systemGrey.withOpacity(0.03),
            ),
          ),
          */
        ],
      ),
    );
  }
}
