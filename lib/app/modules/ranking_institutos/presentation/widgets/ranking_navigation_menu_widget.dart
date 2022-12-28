import 'package:flutter/material.dart';

import 'package:app_melivra/app/core/extensions/screen_extension.dart';

import '../controllers/ranking_controller.dart';

class RankingMenu extends StatefulWidget {
  final RankController controller;

  const RankingMenu({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<RankingMenu> createState() => _RankingMenuState();
}

class _RankingMenuState extends State<RankingMenu> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;

    return Builder(builder: (context) {
      if (widget.controller.config!.totalPages > 0) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.controller.page != 1
                ? GestureDetector(
                    onTap: () {
                      widget.controller.page--;
                      widget.controller.getInstitutos();
                      setState(() {});
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                    ),
                  )
                : SizedBox(
                    width: 16.scale,
                  ),
            SizedBox(width: 16.scale),
            widget.controller.page != 1
                ? CircleAvatar(
                    backgroundColor: theme.cardColor,
                    radius: 13,
                    child: Text(
                      '1',
                      style: theme.textTheme.bodyText2!.merge(
                        TextStyle(
                          color: theme.primaryColor,
                        ),
                      ),
                    ),
                  )
                : CircleAvatar(
                    backgroundColor: theme.primaryColor,
                    radius: 13,
                    child: const Text('1'),
                  ),
            widget.controller.page != widget.controller.config!.totalPages &&
                    widget.controller.page != 1
                ? Row(
                    children: [
                      SizedBox(
                        width: 20,
                        child: Center(
                          child: Text(
                            '...',
                            style: theme.textTheme.bodyText2!.merge(
                              TextStyle(
                                color: theme.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: CircleAvatar(
                          backgroundColor: theme.primaryColor,
                          radius: 13,
                          child: Text(
                            widget.controller.page.toString(),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                        child: Center(
                          child: Text(
                            '...',
                            style: theme.textTheme.bodyText2!.merge(
                              TextStyle(
                                color: theme.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : SizedBox(
                    width: 20,
                    child: Center(
                      child: Text(
                        '...',
                        style: theme.textTheme.bodyText2!.merge(
                          TextStyle(
                            color: theme.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
            widget.controller.page != widget.controller.config!.totalPages
                ? CircleAvatar(
                    backgroundColor: theme.cardColor,
                    radius: 13,
                    child: Text(
                      widget.controller.config!.totalPages.toString(),
                      style: theme.textTheme.bodyText2!.merge(
                        TextStyle(
                          color: theme.primaryColor,
                        ),
                      ),
                    ),
                  )
                : CircleAvatar(
                    backgroundColor: theme.primaryColor,
                    radius: 13,
                    child: Text(
                      widget.controller.config!.totalPages.toString(),
                    ),
                  ),
            SizedBox(width: 16.scale),
            widget.controller.page != widget.controller.config!.totalPages
                ? GestureDetector(
                    onTap: () {
                      widget.controller.page++;
                      widget.controller.getInstitutos();
                      setState(() {});
                    },
                    child: const Icon(
                      Icons.arrow_forward_ios,
                    ),
                  )
                : SizedBox(
                    width: 16.scale,
                  ),
          ],
        );
      }
      return const SizedBox.shrink();
    });
  }
}
