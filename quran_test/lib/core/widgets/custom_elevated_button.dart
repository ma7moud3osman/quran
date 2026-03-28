import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:widgets_box/widgets_box.dart';

import '../extension/colors_extension.dart';
import '../utils/app_decoration/app_radius.dart';
import '../utils/app_height.dart';

enum CustomButtonType { primary, secondary }

class CustomElevatedButton extends StatelessWidget {
  final CustomButtonType type;
  final void Function()? onPressed;
  final String? label;
  final Widget? child;
  final String? imagePath;
  final Widget? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? disableColor;
  final bool isLoading;
  final bool showShadow;
  final Color? borderColor;
  final bool smallSize;
  final double? paddingHorizontal;
  final double paddingVertical;
  final double width;
  final bool isDisable;
  final IconAlignment iconAlignment;

  const CustomElevatedButton({
    super.key,
    this.type = CustomButtonType.primary,
    this.label,
    this.child,
    this.icon,
    this.onPressed,
    this.imagePath,
    this.isDisable = false,
    this.backgroundColor,
    this.textColor,
    this.disableColor,
    this.isLoading = false,
    this.showShadow = true,
    this.borderColor,
    this.smallSize = false,
    this.paddingHorizontal,
    this.paddingVertical = 0,
    this.width = double.infinity,
    this.iconAlignment = IconAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    final isSecondary = type == CustomButtonType.secondary;
    final effectiveTextColor =
        textColor ??
        (isSecondary ? context.primaryColor : context.grey.shade100);

    final effectiveBgColor =
        backgroundColor ??
        (isSecondary ? context.cardColor : context.primaryColor);

    final effectiveBorderColor =
        borderColor ??
        (isSecondary ? context.primaryColor : context.borderColor);

    final iconWidget = imagePath != null
        ? Image.asset(
            imagePath!,
            width: 30,
            height: 30,
            color: effectiveTextColor,
          )
        : icon;

    final textWidget = Text(
      label?.tr() ?? '',
      textAlign: TextAlign.center,
      style: context.bodyMedium?.copyWith(
        color: isDisable ? context.grey.shade100 : effectiveTextColor,
      ),
    );

    return ElevatedButton(
      style: ButtonStyle(
        elevation: WidgetStateProperty.all<double?>(0),
        minimumSize: WidgetStateProperty.all<Size>(
          smallSize ? const Size(0, 40) : Size(width, AppHeight.button),
        ),
        padding: WidgetStateProperty.all<EdgeInsets>(
          EdgeInsets.symmetric(
            vertical: paddingVertical,
            horizontal: paddingHorizontal ?? 16,
          ),
        ),
        foregroundColor: WidgetStateProperty.all<Color>(effectiveTextColor),
        backgroundColor: WidgetStateProperty.resolveWith<Color>(
          (Set<WidgetState> states) => states.contains(WidgetState.disabled)
              ? disableColor ?? context.grey.shade300
              : effectiveBgColor,
        ),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: AppRadius.button,
            side: BorderSide(color: effectiveBorderColor, width: 1),
          ),
        ),
      ),
      onPressed: isLoading || isDisable ? null : onPressed,
      child: isLoading
          ? Center(
              child: SizedBox(
                width: 15,
                height: 15,
                child: CircularProgressIndicator(
                  color: backgroundColor,
                  backgroundColor: textColor,
                ),
              ),
            )
          : iconWidget == null
          ? child ?? textWidget
          : SizedBox(
              width: smallSize && width == double.infinity ? null : width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // spacing: AppSpacer.horizontalSmall,
                children: iconAlignment == IconAlignment.start
                    ? [iconWidget, const SizedBox(width: 8), textWidget]
                    : [textWidget, const SizedBox(width: 8), iconWidget],
              ),
            ),
    );
  }
}
