part of 'bottom_navbar_controller.dart';

class BottomNavBarState extends Equatable {
  final int visit;
  final double height;
  final Color colorSelect;
  final Color color;
  final Color color2;
  final Color bgColor;

  BottomNavBarState(
      {this.visit = 0,
      this.height = 30,
      this.colorSelect = const Color(0XFF0686F8),
      this.color = const Color(0XFF7AC0FF),
      this.color2 = const Color(0XFF96B1FD),
      this.bgColor = const Color(0XFF1752FE)});

  BottomNavBarState copyWith(
      {int? visit,
      double? height,
      Color? colorSelect,
      Color? color,
      Color? color2,
      Color? bgColor}) {
    return BottomNavBarState(
      visit: visit ?? this.visit,
      height: height ?? this.height,
      colorSelect: colorSelect ?? this.colorSelect,
      color: color ?? this.color,
      color2: color2 ?? this.color2,
      bgColor: bgColor ?? this.bgColor,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props =>
      [visit, height, colorSelect, color, color2, bgColor];
}
