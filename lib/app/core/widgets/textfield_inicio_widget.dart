import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:flutter/material.dart';

class TextFieldInicio extends StatelessWidget {
  final String fieldHint;
  final IconData prefixIcon;
  final bool isPassword;
  final TextEditingController controller;
  const TextFieldInicio({
    Key? key,
    this.isPassword = false,
    required this.fieldHint,
    required this.prefixIcon,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.only(left: 16.scale, right: 8.scale),
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: fieldHint,
          suffixIcon: isPassword ? Icon(Icons.remove_red_eye) : null,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Icon(prefixIcon),
          ),
        ),
      ),
    );
  }
}
