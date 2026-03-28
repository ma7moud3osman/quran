import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'spacer_widget.dart';
import 'package:widgets_box/widgets_box.dart';

import '../extension/colors_extension.dart';

class CustomTextFormField extends StatelessWidget {
  final String? title;
  final bool isRequired;
  final double width;
  final double radius;

  // final String label;
  final String? hintText;
  final String? initialValue;
  final TextInputType? keyboardType;
  final String? Function(String? val)? validator;
  final void Function(String? val)? onSave;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final int maxLines;
  final int minLines;
  final bool enabled;
  final bool obscureText;
  final bool autofocus;
  final bool readOnly;
  final Widget? prefixIcon;
  final Widget? button;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final int? maxLength;
  final List<TextInputFormatter>? textInputFormatter;
  final TextAlign? textAlign;
  final VoidCallback? onSubmit;
  final TextAlignVertical? textAlignVertical;
  final Iterable<String>? autofillHints;

  const CustomTextFormField({
    super.key,
    this.width = double.infinity,
    this.radius = 12,
    this.textInputFormatter,
    this.hintText,
    this.isRequired = false,
    this.title,
    this.initialValue,
    this.validator,
    this.onSave,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.minLines = 1,
    this.enabled = true,
    this.obscureText = false,
    this.textInputAction = TextInputAction.next,
    this.button,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.focusNode,
    this.onTap,
    this.readOnly = false,
    this.autofocus = false,
    this.maxLength,
    this.textAlign,
    this.onSubmit,
    this.textAlignVertical,
    this.autofillHints,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              button ??
                  Text(
                    title!,
                    style: context.bodyMedium?.copyWith(
                      color: context.grey.shade800,
                    ),
                  ),
            ],
          ),
          VerticalSpacer.medium(),
        ],
        SizedBox(
          width: width,
          child: TextFormField(
            autofillHints: autofillHints,
            enabled: enabled,
            autofocus: autofocus,
            onTap: onTap,
            readOnly: readOnly,
            initialValue: initialValue,
            controller: controller,
            style: context.bodyMedium?.copyWith(color: context.primaryColor),
            onChanged: onChanged,
            onSaved: onSave,
            minLines: minLines,
            maxLines: maxLines,
            validator: validator,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            focusNode: focusNode,
            obscureText: obscureText,
            cursorHeight: 13,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            maxLength: maxLength,
            inputFormatters: textInputFormatter,
            textAlign: textAlign ?? TextAlign.start,
            onEditingComplete: onSubmit,
            obscuringCharacter: '*',
            onTapOutside: (event) =>
                FocusManager.instance.primaryFocus?.unfocus(),
            textAlignVertical: textAlignVertical ?? TextAlignVertical.center,

            decoration: InputDecoration(
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              enabled: enabled,
              hintText: hintText?.tr(),
              hintStyle: context.bodySmall?.copyWith(
                color: context.grey.shade700,
              ),
              errorStyle: context.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
