import 'package:app_melivra/app/core/widgets/score_tiny_widget.dart';
import 'package:app_melivra/app/modules/instituto_details/presentation/bloc/instituto_details_bloc.dart';
import 'package:app_melivra/app/modules/instituto_details/presentation/bloc/instituto_professors_bloc.dart';
import 'package:app_melivra/app/modules/instituto_details/presentation/controllers/instituto_details_controller.dart';
import 'package:flutter/material.dart';

import 'package:app_melivra/app/core/extensions/screen_extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/style/assets.dart';
import '../../../../core/widgets/card_info_professor_widget.dart';
import '../../../../core/widgets/score_big_widget.dart';
import '../../../institutos/domain/entities/instituto_entity.dart';

class InstitutoDetailsPage extends StatefulWidget {
  const InstitutoDetailsPage({Key? key}) : super(key: key);

  @override
  State<InstitutoDetailsPage> createState() => _InstitutoDetailsPageState();
}

class _InstitutoDetailsPageState extends State<InstitutoDetailsPage> {
  final InstitutoDetailsController controller =
      Modular.get<InstitutoDetailsController>();
  late final ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(infiniteScrolling);
    super.initState();
  }

  Future<void> infiniteScrolling() async {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      controller.setNextPage();
      await controller.getProfessoresByInstituto();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: theme.primaryColor,
      body: SingleChildScrollView(
        controller: _scrollController,
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
              padding: EdgeInsets.only(top: 32.scale),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 24.scale),
                    child: BlocBuilder(
                      bloc: controller.bloc,
                      builder: (context, state) {
                        if (state is InstitutoDetailsEmptyState) {
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
                        if (state is InstitutoDetailsLoadingState) {
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
                        if (state is InstitutoDetailsSuccessState) {
                          final Instituto instituto = state.institute;
                          return Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                                    child: Text(
                                      instituto.name,
                                      textAlign: TextAlign.center,
                                      style: theme.textTheme.headline5!.merge(
                                        TextStyle(
                                          color: theme.backgroundColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 64.scale),
                                ],
                              ),
                              SizedBox(height: 40.scale),
                              Card(
                                margin:
                                    EdgeInsets.symmetric(horizontal: 32.scale),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 32.scale, horizontal: 16.scale),
                                  child: Column(
                                    children: [
                                      ScoreBigWidget(
                                        score: instituto.averageGrade ??
                                            instituto.grades?.average,
                                      ),
                                      SizedBox(height: 32.scale),
                                      GridView.count(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        crossAxisCount: 2,
                                        childAspectRatio: 1.8,
                                        crossAxisSpacing: 20,
                                        padding:
                                            EdgeInsets.only(left: 32.scale),
                                        children: [
                                          const Center(
                                            child:
                                                Text('Organização do Quadro'),
                                          ),
                                          ScoreTinyWidget(
                                            score: instituto
                                                .grades?.boardOrganization,
                                          ),
                                          const Center(
                                            child:
                                                Text('Clareza na Explicação'),
                                          ),
                                          ScoreTinyWidget(
                                            score: instituto
                                                .grades?.clearExplanation,
                                          ),
                                          const Center(
                                            child: Text('Avaliação Coerente'),
                                          ),
                                          ScoreTinyWidget(
                                            score: instituto
                                                .grades?.coherentEvaluation,
                                          ),
                                          const Center(
                                            child:
                                                Text('Tratamento Respeitoso'),
                                          ),
                                          ScoreTinyWidget(
                                            score: instituto
                                                .grades?.respectfulTreatment,
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
                  SizedBox(height: 40.scale),
                  BlocBuilder(
                    bloc: controller.professorsBloc,
                    builder: (context, state) {
                      if (state is InstitutoProfessorsFailureState) {
                        return Padding(
                          padding: EdgeInsets.all(16.scale),
                          child: Center(
                            child: Text(
                              state.message,
                              style: theme.textTheme.headline6!.merge(
                                TextStyle(
                                  color: theme.backgroundColor,
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                      if (state is InstitutoProfessorsEmptyState) {
                        return Padding(
                          padding: EdgeInsets.all(16.scale),
                          child: Center(
                            child: Text(
                              'Não encontramos nada aqui 😥',
                              style: theme.textTheme.headline6!.merge(
                                TextStyle(
                                  color: theme.backgroundColor,
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                      if (state is InstitutoProfessorsLoadingState) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: theme.backgroundColor,
                          ),
                        );
                      }
                      if (state is InstitutoProfessorsSuccessState) {
                        final list = state.professor;
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 32.scale),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.school,
                                    color: theme.backgroundColor,
                                  ),
                                  SizedBox(width: 16.scale),
                                  Text(
                                    'Professores (${controller.response?.totalItems})',
                                    style: theme.textTheme.headline5!.merge(
                                      TextStyle(
                                        color: theme.backgroundColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16.scale),
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(
                                  parent: BouncingScrollPhysics(),
                                ),
                                itemCount: list.length,
                                itemBuilder: (context, index) {
                                  final item = list[index];
                                  return CardInfoProfessor(
                                    professor: item,
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    SizedBox(height: 16.scale),
                              )
                            ],
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
