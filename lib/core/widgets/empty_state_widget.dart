import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:widgets_box/widgets_box.dart';

class EmptyStateWidget extends StatelessWidget {
  final String? emptyText;
  final Widget? emptyWidget;
  final TextStyle? textStyle;

  const EmptyStateWidget({
    super.key,
    this.emptyText,
    this.emptyWidget,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    if (emptyWidget != null) return emptyWidget!;
    final displayText = (emptyText?.trim().isNotEmpty ?? false)
        ? emptyText!.trim()
        : 'no_data_available';

    return Center(
      child: Text(
        displayText.tr(),
        textAlign: TextAlign.center,
        style: textStyle ?? context.bodyMedium,
      ),
    );
  }
}
