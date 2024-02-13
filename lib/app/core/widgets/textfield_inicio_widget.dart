import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldInicio extends StatefulWidget {
  final String fieldHint;
  final IconData prefixIcon;
  final bool isPassword;
  final TextInputAction? textInputAction;
  final String? Function(String? value)? validator;
  final String? Function(String? value)? onChange;
  final Function()? onDone;
  final TextEditingController? controller;
  const TextFieldInicio({
    Key? key,
    this.validator,
    this.onChange,
    this.onDone,
    this.textInputAction = TextInputAction.next,
    this.isPassword = false,
    required this.fieldHint,
    required this.prefixIcon,
    this.controller,
  }) : super(key: key);

  @override
  State<TextFieldInicio> createState() => _TextFieldInicioState();
}

class _TextFieldInicioState extends State<TextFieldInicio> {
  bool hidePassword = true;
  double bottomPadding = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final theme = Theme.of(context);
    return Container(
      width: size.width,
      constraints: BoxConstraints(minHeight: 40.scale),
      padding: EdgeInsets.only(
        left: 16.scale,
        right: 8.scale,
        bottom: bottomPadding,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: TextFormField(
          onChanged: widget.onChange,
          controller: widget.controller,
          textInputAction: widget.textInputAction,
          onEditingComplete: widget.onDone,
          validator: (value) {
            if (widget.validator != null) {
              setState(() {
                bottomPadding = 8.scale;
              });
              final result = widget.validator!(value);
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
                      !hidePassword
                          ? CupertinoIcons.eye_fill
                          : CupertinoIcons.eye_slash_fill,
                      size: 15.scale,
                    ),
                  )
                : null,
            prefixIcon: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Icon(widget.prefixIcon, size: 15.scale),
            ),
          ),
        ),
      ),
    );
  }
}
