import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:app_melivra/app/core/extensions/screen_extension.dart';

class LoginFailureDialog extends StatelessWidget {
  final String message;
  const LoginFailureDialog({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);
    return Stack(
      children: [
        Dialog(
          elevation: 10,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
            ),
            height: size.height * 0.5,
            width: size.width * 0.6,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: 64.scale),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headline5,
                  ),
                  const Spacer(),
                  TextButton(
                    style:
                        TextButton.styleFrom(backgroundColor: theme.errorColor),
                    onPressed: Modular.to.pop,
                    child: Text(
                      'Ok',
                      style: TextStyle(
                        color: theme.cardColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.scale),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: size.height * 0.2,
          width: size.width,
          child: CircleAvatar(
            backgroundColor: theme.cardColor,
            radius: 30,
            child: Icon(
              Icons.cancel,
              color: theme.errorColor,
              size: 50,
            ),
          ),
        ),
        Positioned(
          top: 50 - MediaQuery.of(context).viewInsets.bottom * 0.5,
          right: 20,
          child: GestureDetector(
            onTap: Modular.to.pop,
            child: Icon(
              Icons.close,
              size: 50,
              color: theme.backgroundColor,
            ),
          ),
        ),
      ],
    );
  }
}
