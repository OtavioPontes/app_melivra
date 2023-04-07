import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../modules/search/search_module.dart';

class SearchWidget extends StatelessWidget {
  final bool onlyProfessor;
  final bool onlyInstitutos;
  const SearchWidget({
    Key? key,
    this.onlyProfessor = false,
    this.onlyInstitutos = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => Modular.to.pushNamed(
        SearchModule.routeName,
        arguments: {
          'onlyProfessores': onlyProfessor,
          'onlyInstitutos': onlyInstitutos,
        },
      ),
      child: Center(
        child: Container(
          padding: EdgeInsets.only(
            left: 16.scale,
            top: 14.scale,
            bottom: 14.scale,
          ),
          decoration: BoxDecoration(
            color: theme.canvasColor,
            borderRadius: BorderRadius.circular(12),
          ),
          width: size.width * 0.85,
          child: Row(
            children: [
              Icon(
                Icons.search,
                color: theme.disabledColor,
              ),
              SizedBox(width: 8.scale),
              if (onlyInstitutos)
                Text(
                  'Pesquisar instituto',
                  style: theme.textTheme.bodyLarge!.merge(
                    TextStyle(color: theme.disabledColor),
                  ),
                ),
              if (onlyProfessor)
                Text(
                  'Pesquisar professor',
                  style: theme.textTheme.bodyLarge!.merge(
                    TextStyle(color: theme.disabledColor),
                  ),
                ),
              if (!onlyProfessor && !onlyInstitutos)
                Text(
                  'Professor ou instituto',
                  style: theme.textTheme.bodyLarge!.merge(
                    TextStyle(color: theme.disabledColor),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
