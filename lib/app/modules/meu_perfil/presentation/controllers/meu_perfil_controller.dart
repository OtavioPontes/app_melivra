import 'package:app_melivra/app/core/stores/user_store.dart';
import 'package:app_melivra/app/modules/meu_perfil/domain/repository/i_perfil_repository.dart';
import 'package:app_melivra/app/modules/meu_perfil/presentation/bloc/meu_perfil_bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MeuPerfilController {
  final IPerfilRepository _repository;
  final MeuPerfilBloc bloc;
  final UserStore store;

  MeuPerfilController({
    required IPerfilRepository repository,
    required this.bloc,
    required this.store,
  }) : _repository = repository {
    nameController = TextEditingController(text: store.loggedUser?.name);
    emailController = TextEditingController(text: store.loggedUser?.email);
  }

  TextEditingController? nameController;
  TextEditingController? emailController;

  Future<void> updateProfile() async {
    bloc.add(MeuPerfilLoadingEvent());
    final result = await _repository.update(
      email: emailController!.text,
      name: nameController!.text,
    );
    await result.fold(
      (failure) {
        bloc.add(MeuPerfilFailureEvent(message: failure.message));
      },
      (success) async {
        bloc.add(MeuPerfilSuccessEvent());
        await store.setUser(
          store.loggedUser!.copyWith(
            email: emailController!.text,
            name: nameController!.text,
          ),
        );
        await Fluttertoast.showToast(
          msg: "Perfil atualizado com sucesso ✅",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.greenAccent,
          textColor: Colors.black,
          fontSize: 12,
        );
      },
    );
  }

  Future<void> deleteProfile() async {
    bloc.add(MeuPerfilLoadingEvent());
    final result = await _repository.delete();
    await result.fold(
      (failure) {
        bloc.add(MeuPerfilFailureEvent(message: failure.message));
      },
      (success) async {
        bloc.add(MeuPerfilDeleteEvent());
      },
    );
  }
}
