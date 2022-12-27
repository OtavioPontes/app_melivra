import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldInicio extends StatefulWidget {
  final String fieldHint;
  final IconData prefixIcon;
  final bool isPassword;
  final String? Function(String? value)? validator;
  final TextEditingController controller;
  const TextFieldInicio({
    Key? key,
    this.validator,
    this.isPassword = false,
    required this.fieldHint,
    required this.prefixIcon,
    required this.controller,
  }) : super(key: key);

  @override
  State<TextFieldInicio> createState() => _TextFieldInicioState();
}

class _TextFieldInicioState extends State<TextFieldInicio> {
  bool hidePassword = true;
  double bottomPadding = 0;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.only(
          left: 16.scale, right: 8.scale, bottom: bottomPadding),
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        controller: widget.controller,
        validator: (value) {
          if (widget.validator != null) {
            setState(() {
              bottomPadding = 8.scale;
            });
            String? result = widget.validator!(value);
            if (result == null) {
              setState(() {
                bottomPadding = 0;
              });
            }
            return result;
          }
          return null;
        },
        textAlignVertical: TextAlignVertical.center,
        obscureText: widget.isPassword && hidePassword,
        decoration: InputDecoration(
          errorBorder: const UnderlineInputBorder(),
          hintText: widget.fieldHint,
          suffixIcon: widget.isPassword
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      hidePassword = !hidePassword;
                    });
                  },
                  child: Icon(
                    hidePassword
                        ? CupertinoIcons.eye_fill
                        : CupertinoIcons.eye_slash_fill,
                  ),
                )
              : null,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Icon(widget.prefixIcon),
          ),
        ),
      ),
    );
  }
}
