import 'package:flutter/material.dart';

class AppGrid {
  AppGrid._();

  static SliverGridDelegateWithFixedCrossAxisCount tabletGridDelegateFixed({
    required double mainAxisExtent,
  }) {
    return SliverGridDelegateWithFixedCrossAxisCount(
      mainAxisExtent: mainAxisExtent,
      crossAxisCount: 2,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 1,
    );
  }

  static SliverGridDelegateWithFixedCrossAxisCount get gridDelegateFixed =>
      const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisExtent: 102,
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1,
      );

  static SliverGridDelegateWithFixedCrossAxisCount get gridItemDelegateFixed =>
      const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisExtent: 135,
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1,
      );
}
