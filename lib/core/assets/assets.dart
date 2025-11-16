class Assets {
  Assets._();

  static Icons icons = Icons();
  static SvgIcons svgIcons = SvgIcons();
}

class Icons {
static const String _base = "assets/icons";

String cancel = '$_base/cancel.png';
String plus = '$_base/plus.png';
String checkIcon = '$_base/check_icon.png';
String iconList = '$_base/icon_list.png';
}

class SvgIcons {
  static const String _base = "assets/icons";
  String person = "$_base/vector.svg";
  String edit = "$_base/edit_icon.svg";
}