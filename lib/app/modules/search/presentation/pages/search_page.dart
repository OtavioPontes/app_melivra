import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:app_melivra/app/core/style/assets.dart';
import 'package:app_melivra/app/core/widgets/card_info_instituto_widget.dart';
import 'package:app_melivra/app/core/widgets/card_info_professor_widget.dart';
import 'package:app_melivra/app/modules/search/presentation/bloc/search_professor_bloc.dart';
import 'package:app_melivra/app/modules/search/presentation/controllers/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../bloc/search_institutes_bloc.dart';

class SearchPage extends StatefulWidget {
  final bool onlyProfessor;
  final bool onlyInstitutos;
  const SearchPage({
    Key? key,
    this.onlyProfessor = false,
    this.onlyInstitutos = false,
  }) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final SearchController controller = Modular.get<SearchController>();
  late final ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(infiniteScrolling);
    super.initState();
  }

  @override
  void dispose() {
    controller.searchController.dispose();
    controller.dispose();
    super.dispose();
  }

  Future<void> infiniteScrolling() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      controller.setNextPage();
      await controller.getProfessores();
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: theme.primaryColor,
          statusBarIconBrightness: Brightness.light,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              top: 32.scale,
              bottom: 40.scale,
            ),
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24.scale),
                if (widget.onlyInstitutos)
                  Center(
                    child: Container(
                      padding: EdgeInsets.only(
                        left: 8.scale,
                        top: 4.scale,
                        bottom: 4.scale,
                      ),
                      decoration: BoxDecoration(
                        color: theme.canvasColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      width: size.width * 0.85,
                      child: TextField(
                        autofocus: true,
                        controller: controller.searchController,
                        onChanged: (value) {
                          if (value.length > 1) {
                            controller.resetLists();
                            controller.getInstitutos();
                          }
                        },
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: GestureDetector(
                            onTap: Modular.to.pop,
                            child: const Icon(Icons.cancel),
                          ),
                          hintText: 'Pesquisar instituto',
                          hintStyle: theme.textTheme.bodyText1!.merge(
                            TextStyle(color: theme.disabledColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                if (widget.onlyProfessor)
                  Center(
                    child: Container(
                      padding: EdgeInsets.only(
                        left: 8.scale,
                        top: 4.scale,
                        bottom: 4.scale,
                      ),
                      decoration: BoxDecoration(
                        color: theme.canvasColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      width: size.width * 0.85,
                      child: TextField(
                        autofocus: true,
                        controller: controller.searchController,
                        onChanged: (value) {
                          if (value.length > 1) {
                            controller.resetLists();
                            controller.getProfessores();
                          }
                        },
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: GestureDetector(
                            onTap: Modular.to.pop,
                            child: const Icon(Icons.cancel),
                          ),
                          hintText: 'Pesquisar professor',
                          hintStyle: theme.textTheme.bodyText1!.merge(
                            TextStyle(color: theme.disabledColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                if (!widget.onlyProfessor && !widget.onlyInstitutos)
                  Center(
                    child: Container(
                      padding: EdgeInsets.only(
                        left: 8.scale,
                        top: 4.scale,
                        bottom: 4.scale,
                      ),
                      decoration: BoxDecoration(
                        color: theme.canvasColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      width: size.width * 0.85,
                      child: TextField(
                        autofocus: true,
                        controller: controller.searchController,
                        onChanged: (value) {
                          if (value.length > 1) {
                            controller.resetLists();
                            controller.getProfessores();
                            controller.getInstitutos();
                          }
                        },
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: GestureDetector(
                            onTap: Modular.to.pop,
                            child: const Icon(Icons.cancel),
                          ),
                          hintText: 'Professor ou instituto',
                          hintStyle: theme.textTheme.bodyText1!.merge(
                            TextStyle(color: theme.disabledColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                SizedBox(height: 24.scale),
                Stack(
                  children: [
                    SvgPicture.asset(
                      AssetsMeLivra.waveHome,
                      width: size.width,
                      fit: BoxFit.fitWidth,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32.scale),
                      child: Column(
                        children: [
                          SizedBox(height: 32.scale),
                          BlocBuilder(
                            bloc: controller.searchProfessorsBloc,
                            builder: (context, state) {
                              if (state is SearchProfessorsLoadingState) {
                                return CircularProgressIndicator(
                                  color: theme.backgroundColor,
                                );
                              }
                              if (state is SearchProfessorsEmptyState) {
                                return const SizedBox.shrink();
                              }
                              if (state is SearchProfessorsSuccessState) {
                                final professors = state.professors;
                                return Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.school,
                                          color: theme.backgroundColor,
                                        ),
                                        SizedBox(width: 16.scale),
                                        Text(
                                          'Professores (${controller.professorResponse?.totalItems ?? 0})',
                                          style:
                                              theme.textTheme.headline5!.merge(
                                            TextStyle(
                                              color: theme.backgroundColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 32.scale),
                                    ListView.separated(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return CardInfoProfessor(
                                          professor: professors[index],
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          SizedBox(height: 16.scale),
                                      itemCount: professors.length,
                                    ),
                                  ],
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                          SizedBox(height: 32.scale),
                          BlocBuilder(
                            bloc: controller.searchInstitutesBloc,
                            builder: (context, state) {
                              if (state is SearchInstitutesLoadingState) {
                                return CircularProgressIndicator(
                                  color: theme.backgroundColor,
                                );
                              }
                              if (state is SearchInstitutesEmptyState) {
                                return const SizedBox.shrink();
                              }
                              if (state is SearchInstitutesSuccessState) {
                                final institutes = state.institutes;
                                return Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.school,
                                          color: theme.backgroundColor,
                                        ),
                                        SizedBox(width: 16.scale),
                                        Text(
                                          'Institutos (${controller.institutoResponse?.totalItems ?? 0})',
                                          style:
                                              theme.textTheme.headline5!.merge(
                                            TextStyle(
                                              color: theme.backgroundColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 32.scale),
                                    ListView.separated(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return CardInfoInstituto(
                                          instituto: institutes[index],
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          SizedBox(height: 16.scale),
                                      itemCount: institutes.length,
                                    ),
                                  ],
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
