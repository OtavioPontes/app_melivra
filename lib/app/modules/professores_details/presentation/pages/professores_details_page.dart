import 'package:app_melivra/app/modules/professores_details/presentation/controllers/professor_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:app_melivra/app/core/style/colors.dart';

import '../../../../core/style/assets.dart';
import '../../../../core/widgets/score_big_widget.dart';
import '../../../../core/widgets/score_tiny_widget.dart';
import '../../../professores/domain/entities/professor_entity.dart';
import '../bloc/professor_details_bloc.dart';

class ProfessoresDetailsPage extends StatefulWidget {
  const ProfessoresDetailsPage({Key? key}) : super(key: key);

  @override
  State<ProfessoresDetailsPage> createState() => _ProfessoresDetailsPageState();
}

class _ProfessoresDetailsPageState extends State<ProfessoresDetailsPage>
    with TickerProviderStateMixin {
  final ProfessorDetailsController controller =
      Modular.get<ProfessorDetailsController>();
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: theme.primaryColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            fixedSize: Size(60.scale, 60.scale),
            backgroundColor: ColorsMeLivra().lightPurple,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                100,
              ),
            ),
          ),
          child: const Icon(
            Icons.thumb_up,
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 32.scale),
            child: Stack(
              children: [
                SvgPicture.asset(
                  AssetsMeLivra.waveHome,
                  width: size.width,
                  fit: BoxFit.fitWidth,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 40.scale, bottom: 64.scale),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 24.scale),
                        child: BlocBuilder(
                          bloc: controller.bloc,
                          builder: (context, state) {
                            if (state is ProfessorDetailsEmptyState) {
                              return Padding(
                                padding: EdgeInsets.all(16.scale),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: IconButton(
                                        highlightColor: Colors.transparent,
                                        splashColor: Colors.transparent,
                                        onPressed: Modular.to.pop,
                                        icon: Icon(
                                          Icons.arrow_back_ios,
                                          size: 40.scale,
                                          color: theme.backgroundColor,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 64.scale),
                                    Center(
                                      child: Text(
                                        'Não encontramos nada aqui 😥',
                                        style: theme.textTheme.headline6!.merge(
                                          TextStyle(
                                            color: theme.backgroundColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                            if (state is ProfessorDetailsLoadingState) {
                              return Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: IconButton(
                                      highlightColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      onPressed: Modular.to.pop,
                                      icon: Icon(
                                        Icons.arrow_back_ios,
                                        size: 40.scale,
                                        color: theme.backgroundColor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 64.scale),
                                  Center(
                                    child: CircularProgressIndicator(
                                        color: theme.backgroundColor),
                                  ),
                                ],
                              );
                            }
                            if (state is ProfessorDetailsSuccessState) {
                              final Professor professor = state.professor;
                              return Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      IconButton(
                                        highlightColor: Colors.transparent,
                                        splashColor: Colors.transparent,
                                        onPressed: Modular.to.pop,
                                        icon: Icon(
                                          Icons.arrow_back_ios,
                                          size: 40.scale,
                                          color: theme.backgroundColor,
                                        ),
                                      ),
                                      SizedBox(width: 16.scale),
                                      Flexible(
                                        child: Column(
                                          children: [
                                            Text(
                                              professor.name,
                                              style: theme.textTheme.headline4!
                                                  .merge(
                                                TextStyle(
                                                  color: theme.backgroundColor,
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 16.scale),
                                            Text(
                                              professor.instituto.name,
                                              textAlign: TextAlign.center,
                                              style: theme.textTheme.bodyText2!
                                                  .merge(
                                                TextStyle(
                                                  color: theme.backgroundColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 64.scale),
                                    ],
                                  ),
                                  SizedBox(height: 40.scale),
                                  Card(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 32.scale),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 32.scale,
                                          horizontal: 16.scale),
                                      child: Column(
                                        children: [
                                          ScoreBigWidget(
                                              score: professor.averageGrade ??
                                                  professor.grades?.average),
                                          SizedBox(height: 24.scale),
                                          Text(
                                            '30 avaliações',
                                            style:
                                                theme.textTheme.overline!.merge(
                                              TextStyle(
                                                color: theme.disabledColor,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 16.scale),
                                          GridView.count(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 20,
                                            childAspectRatio: 2,
                                            padding:
                                                EdgeInsets.only(left: 32.scale),
                                            children: [
                                              const Center(
                                                child: Text(
                                                  'Organização do Quadro',
                                                ),
                                              ),
                                              ScoreTinyWidget(
                                                score: professor
                                                    .grades?.boardOrganization,
                                              ),
                                              const Center(
                                                child: Text(
                                                  'Clareza na Explicação',
                                                ),
                                              ),
                                              ScoreTinyWidget(
                                                score: professor
                                                    .grades?.clearExplanation,
                                              ),
                                              const Center(
                                                child: Text(
                                                  'Avaliação Coerente',
                                                ),
                                              ),
                                              ScoreTinyWidget(
                                                score: professor
                                                    .grades?.coherentEvaluation,
                                              ),
                                              const Center(
                                                child: Text(
                                                  'Tratamento Respeitoso',
                                                ),
                                              ),
                                              ScoreTinyWidget(
                                                score: professor.grades
                                                    ?.respectfulTreatment,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          DraggableScrollableSheet(
            maxChildSize: 0.9,
            initialChildSize: 0.15,
            minChildSize: 0.1,
            builder: (context, scrollController) {
              return Material(
                elevation: 10,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20.scale),
                ),
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  controller: scrollController,
                  slivers: [
                    SliverPersistentHeader(
                      delegate: BadgeBottomSheet(),
                      pinned: true,
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        height: size.height * 0.9,
                        decoration: BoxDecoration(
                          color: theme.cardColor,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20.scale),
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 120.scale,
                              child: Column(
                                children: [
                                  SvgPicture.asset(
                                    AssetsMeLivra.waveChat,
                                    width: size.width,
                                    height: size.height,
                                    fit: BoxFit.fitWidth,
                                    color: theme.primaryColor,
                                  ),
                                  Container(
                                    color: theme.primaryColor,
                                  )
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                SizedBox(height: 16.scale),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 24.scale),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Icon(
                                        Icons.chat,
                                        color: theme.colorScheme.onPrimary,
                                      ),
                                      SizedBox(width: 32.scale),
                                      Flexible(
                                        child: Text(
                                          'Avaliações e Comentários',
                                          style: theme.textTheme.headline5!,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 32.scale),
                                Stack(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16.scale,
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
                                            color: theme.colorScheme.onPrimary
                                                .withOpacity(0.2),
                                            offset: const Offset(-1, 2),
                                            blurRadius: 5,
                                            spreadRadius: 2,
                                          )
                                        ],
                                        color: theme.cardColor,
                                      ),
                                      child: TextField(
                                        minLines: 2,
                                        maxLines: 2,
                                        decoration: InputDecoration(
                                            hintText:
                                                'Escreva seu comentário...',
                                            hintStyle: theme
                                                .textTheme.bodyText2!
                                                .merge(
                                              TextStyle(
                                                color: theme.disabledColor,
                                              ),
                                            )),
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      bottom: 0,
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: CircleAvatar(
                                          radius: 25,
                                          backgroundColor:
                                              ColorsMeLivra().lightPurple,
                                          child: Icon(
                                            Icons.send,
                                            color: theme.primaryColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

class BadgeBottomSheet extends SliverPersistentHeaderDelegate {
  final double height;
  BadgeBottomSheet({
    this.height = 50,
  });
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final ThemeData theme = Theme.of(context);
    return Material(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(20),
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxHeight: 8, maxWidth: 70),
          decoration: BoxDecoration(
            color: theme.primaryColor,
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;
}
