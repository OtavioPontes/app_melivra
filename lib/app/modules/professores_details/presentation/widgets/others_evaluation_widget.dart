import 'package:app_melivra/app/core/domain/entities/grade_response.dart';
import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:app_melivra/app/core/widgets/score_tiny_widget.dart';
import 'package:flutter/material.dart';

import '../../../../core/style/colors.dart';

class OthersEvaluation extends StatelessWidget {
  final GradeResponse response;
  const OthersEvaluation({
    Key? key,
    required this.response,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
            padding: EdgeInsets.symmetric(
              horizontal: 24.scale,
              vertical: 16.scale,
            ),
            width: size.width * 0.8,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.onPrimary.withOpacity(0.2),
                  offset: const Offset(-1, 2),
                  blurRadius: 5,
                  spreadRadius: 2,
                )
              ],
              color: theme.cardColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ScoreTinyWidget(score: response.averageGrade),
                    SizedBox(width: 16.scale),
                    Text(
                      response.userName,
                      style: theme.textTheme.bodyText1,
                    )
                  ],
                ),
                SizedBox(height: 16.scale),
                Text(
                  response.description,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 32.scale),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.thumb_up,
                        color: ColorsMeLivra().green,
                        size: 20,
                      ),
                      SizedBox(width: 4.scale),
                      Text(
                        '(1)',
                        style: theme.textTheme.caption,
                      ),
                      SizedBox(width: 8.scale),
                      Icon(
                        Icons.thumb_down,
                        color: ColorsMeLivra().red,
                        size: 20,
                      ),
                      SizedBox(width: 4.scale),
                      Text(
                        '(5)',
                        style: theme.textTheme.caption,
                      ),
                    ],
                  ),
                )
              ],
            )),
        Positioned(
          right: 0,
          bottom: 0,
          child: GestureDetector(
            onTap: () {},
            child: CircleAvatar(
              radius: 20,
              backgroundColor: ColorsMeLivra().yellow,
              child: Icon(
                Icons.warning,
                color: theme.backgroundColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}