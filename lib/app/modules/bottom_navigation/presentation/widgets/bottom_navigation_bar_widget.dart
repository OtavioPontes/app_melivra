import 'package:flutter/material.dart';

import 'package:flutter_modular/flutter_modular.dart';

import '../../../../core/extensions/screen_extension.dart';
import '../controller/bottom_navigation_controller.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({Key? key}) : super(key: key);

  @override
  _BottomNavigationBarWidgetState createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget>
    with SingleTickerProviderStateMixin {
  final controller = Modular.get<BottomNavigationController>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        BottomNavigationBar(
          iconSize: 30.scale,
          showUnselectedLabels: false,
          selectedLabelStyle: TextStyle(
            fontSize: theme.textTheme.bodyMedium!.fontSize,
          ),
          backgroundColor: theme.colorScheme.background,
          onTap: (value) {
            controller.animatedToIndex(value);
            setState(() {});
          },
          currentIndex: controller.currentIndex,
          elevation: 2,
          selectedItemColor: theme.colorScheme.primary,
          unselectedItemColor: theme.disabledColor,
          items: const [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home),
              activeIcon: Icon(
                Icons.home,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Professores',
              icon: Icon(Icons.people),
            ),
            BottomNavigationBarItem(
              label: 'Institutos',
              icon: Icon(Icons.account_balance),
            ),
            BottomNavigationBarItem(
              label: 'Meu Perfil',
              icon: Icon(Icons.person),
            )
          ],
        ),
      ],
    );
  }
}
