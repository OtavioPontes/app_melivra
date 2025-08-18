import 'package:app_melivra/app/modules/bottom_navigation/bottom_navigation_module.dart';
import 'package:flutter/material.dart';

import 'package:flutter_modular/flutter_modular.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({Key? key}) : super(key: key);

  @override
  _BottomNavigationBarWidgetState createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget>
    with SingleTickerProviderStateMixin {
  int selectedIndex = 0;

  void onDestinationSelected(int index) {
    if (index == 0) {
      Modular.to.navigate("${BottomNavigationModule.routeName}/home/");
    }
    if (index == 1) {
      Modular.to.navigate("${BottomNavigationModule.routeName}/professores/");
    }
    if (index == 2) {
      Modular.to.navigate("${BottomNavigationModule.routeName}/institutos/");
    }
    if (index == 3) {
      Modular.to.navigate("${BottomNavigationModule.routeName}/perfil/");
    }
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    onDestinationSelected(selectedIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.people),
          label: 'Professores',
        ),
        NavigationDestination(
          icon: Icon(Icons.account_balance),
          label: 'Institutos',
        ),
        NavigationDestination(
          icon: Icon(Icons.person),
          label: 'Meu Perfil',
        ),
      ],
    );
  }
}
