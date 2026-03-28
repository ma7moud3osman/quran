import 'package:flutter/material.dart';

extension ToSliver on Widget {
  SliverToBoxAdapter get toSliver => SliverToBoxAdapter(child: this);
}

extension ListSpaceBetweenExtension on List<Widget> {
  List<Widget> separated({required Widget separatedWidget}) => [
    for (int i = 0; i < length; i++) ...[if (i > 0) separatedWidget, this[i]],
  ];
}
