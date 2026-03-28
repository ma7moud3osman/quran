import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_colors_dark.dart';
import '../utils/app_decoration/app_radius.dart';
import '../utils/font/app_style_text.dart';
import '../utils/font/font_size.dart';

InputDecorationTheme getInputDecorationTheme({required bool isDark}) {
  return InputDecorationTheme(
    fillColor: WidgetStateColor.resolveWith((states) {
      if (states.contains(WidgetState.focused)) {
        return isDark ? AppColorsDark.cardDark : AppColors.cardLight;
      } else if (states.contains(WidgetState.disabled)) {
        return isDark ? AppColorsDark.borderDark : AppColors.borderLight;
      }
      return isDark ? AppColorsDark.cardDark : AppColors.cardLight;
    }),
    iconColor: isDark ? AppColorsDark.error : AppColors.error,
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    filled: true,

    prefixIconColor: WidgetStateColor.resolveWith((states) {
      if (states.contains(WidgetState.focused)) {
        return isDark ? AppColorsDark.primary : AppColors.primary;
      } else if (states.contains(WidgetState.focused)) {
        return isDark ? AppColorsDark.borderDark : AppColors.borderLight;
      }
      return isDark ? Colors.grey.shade400 : Colors.grey.shade400;
    }),
    hintStyle: getMediumStyle(
      fontSize: FontSize.s14,
      height: 0,
      color: isDark ? AppColorsDark.textDark : AppColors.bodyLight,
    ),
    counterStyle: getRegularStyle(
      fontSize: FontSize.s16,
      color: isDark ? AppColorsDark.textDark : AppColors.titleLight,
    ),

    // iconColor: AppColors.error,
    labelStyle: WidgetStateTextStyle.resolveWith((states) {
      if (states.contains(WidgetState.focused)) {
        return getMediumStyle(
          color: isDark ? AppColorsDark.textDark : AppColors.titleLight,
          fontSize: FontSize.s16,
        );
      } else if (states.contains(WidgetState.disabled)) {
        return getMediumStyle(
          color: isDark ? AppColorsDark.textDark : AppColors.bodyLight,
          fontSize: FontSize.s16,
        );
      }
      return getMediumStyle(
        color: isDark ? Colors.grey.shade400 : AppColors.titleLight,
        fontSize: FontSize.s16,
      );
    }),
    floatingLabelStyle: WidgetStateTextStyle.resolveWith((states) {
      if (states.contains(WidgetState.focused)) {
        return getMediumStyle(
          color: isDark ? AppColorsDark.whiteDark : AppColors.primary,
          fontSize: FontSize.s16,
        );
      }
      return getMediumStyle(
        color: isDark ? AppColorsDark.whiteDark : Colors.grey.shade400,
        fontSize: FontSize.s16,
      );
    }),

    errorStyle: getMediumStyle(
      color: isDark ? AppColorsDark.error : AppColors.error,
      fontSize: FontSize.s12,
    ),

    disabledBorder: getOutlineInputBorder(
      color: isDark ? AppColorsDark.borderDark : AppColors.borderLight,
    ),
    focusedBorder: getOutlineInputBorder(
      color: isDark ? AppColorsDark.borderDark : AppColors.grey,
    ),
    enabledBorder: getOutlineInputBorder(
      color: isDark ? AppColorsDark.borderDark : AppColors.borderLight,
    ),

    errorBorder: getOutlineInputBorder(
      color: isDark ? AppColorsDark.error : AppColors.error,
    ),
    focusedErrorBorder: getOutlineInputBorder(
      color: isDark ? AppColorsDark.borderDark : AppColors.borderLight,
    ),
    border: getOutlineInputBorder(
      color: isDark ? AppColorsDark.error : AppColors.error,
    ),
  );
}

OutlineInputBorder getOutlineInputBorder({required Color color}) {
  return OutlineInputBorder(
    borderRadius: AppRadius.border,
    borderSide: BorderSide(color: color, width: 1),
  );
}
