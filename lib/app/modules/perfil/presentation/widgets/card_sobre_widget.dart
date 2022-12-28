import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:flutter/material.dart';

class CardSobre extends StatelessWidget {
  const CardSobre({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.85,
      child: Card(
        child: Padding(
          padding: EdgeInsets.only(
            left: 24.scale,
            right: 16.scale,
            top: 16.scale,
            bottom: 16.scale,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.info,
                      size: 32.scale,
                    ),
                    SizedBox(width: 24.scale),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Sobre o App',
                            style: theme.textTheme.headline6!.merge(
                              TextStyle(
                                color: theme.primaryColor,
                              ),
                            ),
                          ),
                          SizedBox(height: 4.scale),
                          Text(
                            'Informações do projeto',
                            style: theme.textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 24.scale,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}