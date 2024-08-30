import 'package:flutter/material.dart';
import 'package:mobileapp_roadreport/core/constants/colors.dart';
import 'package:mobileapp_roadreport/core/constants/font_size.dart';
import 'package:mobileapp_roadreport/core/constants/font_weigth.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatefulWidget {
  final String? label;
  final bool enable;
  final String? hint;
  final String? Function(String?)? validator;
  final bool? obscureText;
  final TextEditingController controller;
  final IconButton? suffixIcon;
  final int? maxLength;
  final TextInputAction textInputAction;
  final Function(String?)? onChanged;
  final String? helperText;
  final TextInputType? keyboardType;
  final int? maxLines;
  final Widget? icon;
  final bool? isError;

  const CustomTextFormField({
    super.key,
    required this.textInputAction,
    this.label,
    this.hint,
    required this.validator,
    this.obscureText = false,
    required this.controller,
    this.suffixIcon,
    this.maxLength,
    this.onChanged,
    this.helperText,
    this.keyboardType,
    this.maxLines,
    this.icon,
    this.isError = false,
    required this.enable,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.enable,
      controller: widget.controller,
      textInputAction: widget.textInputAction,
      keyboardType: widget.keyboardType,
      maxLines: widget.maxLines,
      style: const TextStyle(
        color: Colors.black,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(20),
        border: Theme.of(context).inputDecorationTheme.border,
        filled: true,
        fillColor: widget.enable ? Colors.white : AppColors.neutral50,
        errorStyle: const TextStyle(
          color: Colors.red,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.neutral300,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.neutral300,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.primary500,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        hintText: widget.hint,
        hintStyle: const TextStyle(
          fontWeight: AppFontWeight.bodyRegular,
          fontSize: AppFontSize.bodySmall,
          color: AppColors.neutral600,
        ),
      ),
      validator: (value) => widget.validator!(value),
    );
  }
}
