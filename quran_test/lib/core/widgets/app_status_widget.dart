import 'package:flutter/material.dart';
import 'package:widgets_box/widgets_box.dart';

class AppStatusWidget extends StatelessWidget {
  final String name;
  final Color color;
  final AlignmentGeometry alignment;

  const AppStatusWidget({
    super.key,
    required this.name,
    required this.color,
    this.alignment = AlignmentDirectional.center,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: FittedBox(
        child: StatusWidget(
          text: name,
          textColor: Colors.white,
          backgroundColor: color,
          borderRadius: BorderRadiusDirectional.only(
            topEnd: Radius.circular(16),
            bottomStart: Radius.circular(16),
          ),
        ),
      ),
    );
  }
}
