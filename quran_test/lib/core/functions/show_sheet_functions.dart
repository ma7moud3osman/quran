import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:widgets_box/widgets_box.dart';
import '../extension/colors_extension.dart';
import '../utils/app_decoration/app_radius.dart';
import '../widgets/spacer_widget.dart';

class CustomBottomSheet {
  static void headerWidget({
    required BuildContext context,
    required Widget child,
    required String title,
    required String subtitle,
    TextAlign titleAlign = TextAlign.center,
    TextAlign subtitleAlign = TextAlign.center,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Material(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.9,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const HeaderBottomSheet(),
                VerticalSpacer.extra(),
                Text(
                  title.tr(),
                  textAlign: titleAlign,
                  style: context.headlineLarge,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    subtitle.tr(),
                    textAlign: subtitleAlign,
                    style: context.labelLarge,
                  ),
                ),
                VerticalSpacer.extra(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: child,
                ),
                VerticalSpacer.extra(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HeaderBottomSheet extends StatelessWidget {
  const HeaderBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 5,
          margin: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: context.borderColor,
            borderRadius: AppRadius.radiusAll,
          ),
        ),
      ],
    );
  }
}
