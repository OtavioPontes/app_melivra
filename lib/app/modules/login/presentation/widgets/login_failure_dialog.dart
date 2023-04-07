import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginFailureDialog extends StatelessWidget {
  final String message;
  const LoginFailureDialog({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Stack(
      children: [
        Dialog(
          elevation: 10,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
            ),
            height: 250.scale,
            width: size.width * 0.6,
            child: Padding(
              padding: EdgeInsets.all(8.scale),
              child: Column(
                children: [
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.all(12.scale),
                    child: Text(
                      message,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineSmall,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: theme.colorScheme.error,),
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
          top: 220.scale,
          width: size.width,
          child: CircleAvatar(
            backgroundColor: theme.cardColor,
            radius: 30,
            child: Icon(
              Icons.cancel,
              color: theme.colorScheme.error,
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
              color: theme.colorScheme.background,
            ),
          ),
        ),
      ],
    );
  }
}
