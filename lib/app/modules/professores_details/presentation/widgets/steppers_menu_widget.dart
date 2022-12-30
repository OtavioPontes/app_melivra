import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../controllers/evalute_professor_controller.dart';

class SteppersMenu extends StatefulWidget {
  const SteppersMenu({
    Key? key,
  }) : super(key: key);

  @override
  State<SteppersMenu> createState() => _SteppersMenuState();
}

class _SteppersMenuState extends State<SteppersMenu> {
  @override
  Widget build(BuildContext context) {
    final EvaluateProfessorController controller =
        Modular.get<EvaluateProfessorController>();
    final ThemeData theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(bottom: 16.scale),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Visibility(
            maintainState: true,
            maintainAnimation: true,
            maintainSize: true,
            visible: controller.currentIndex != 0,
            child: GestureDetector(
              onTap: () {
                controller.setCurrentIndex(controller.currentIndex - 1);
                controller.animatedToIndex();
                setState(() {});
              },
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios,
                    size: 15.scale,
                  ),
                  SizedBox(width: 2.scale),
                  const Text('Anterior')
                ],
              ),
            ),
          ),
          Row(
            children: [
              CircleAvatar(
                backgroundColor: controller.currentIndex != 0
                    ? theme.disabledColor
                    : theme.primaryColor,
                radius: 4,
                child: const SizedBox(),
              ),
              SizedBox(width: 6.scale),
              CircleAvatar(
                backgroundColor: controller.currentIndex != 1
                    ? theme.disabledColor
                    : theme.primaryColor,
                radius: 4,
                child: const SizedBox(),
              ),
              SizedBox(width: 6.scale),
              CircleAvatar(
                backgroundColor: controller.currentIndex != 2
                    ? theme.disabledColor
                    : theme.primaryColor,
                radius: 4,
                child: const SizedBox(),
              ),
              SizedBox(width: 6.scale),
              CircleAvatar(
                backgroundColor: controller.currentIndex != 3
                    ? theme.disabledColor
                    : theme.primaryColor,
                radius: 4,
                child: const SizedBox(),
              ),
            ],
          ),
          Visibility(
            visible: controller.currentIndex != 3,
            maintainAnimation: true,
            maintainState: true,
            maintainSize: true,
            child: GestureDetector(
              onTap: () {
                controller.setCurrentIndex(controller.currentIndex + 1);
                controller.animatedToIndex();
                setState(() {});
              },
              child: Row(
                children: [
                  const Text('Próximo'),
                  SizedBox(width: 2.scale),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 15.scale,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
