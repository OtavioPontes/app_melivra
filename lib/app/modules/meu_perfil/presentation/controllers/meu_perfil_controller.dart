import 'package:app_melivra/app/core/stores/user_store.dart';
import 'package:app_melivra/app/modules/meu_perfil/domain/services/i_update_perfil_service.dart';
import 'package:app_melivra/app/modules/meu_perfil/presentation/bloc/meu_perfil_bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MeuPerfilController {
  final IUpdatePerfilService _updatePerfilService;
  final MeuPerfilBloc bloc;
  final UserStore store;

  MeuPerfilController({
    required IUpdatePerfilService updatePerfilService,
    required this.bloc,
    required this.store,
  }) : _updatePerfilService = updatePerfilService {
    nameController = TextEditingController(text: store.loggedUser?.name);
    emailController = TextEditingController(text: store.loggedUser?.email);
  }

  TextEditingController? nameController;
  TextEditingController? emailController;

  Future<void> updateProfile() async {
    bloc.add(MeuPerfilLoadingEvent());
    final result = await _updatePerfilService(
      email: emailController!.text,
      name: nameController!.text,
    );
    result.fold(
      (failure) {
        bloc.add(MeuPerfilFailureEvent(message: failure.message));
      },
      (success) async {
        bloc.add(MeuPerfilSuccessEvent());
        store.setUser(
          store.loggedUser!.copyWith(
            email: emailController!.text,
            name: nameController!.text,
          ),
        );
        await Fluttertoast.showToast(
          msg: "Perfil atualizado com sucesso ✅",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.greenAccent,
          textColor: Colors.black,
          fontSize: 12.0,
        );
      },
    );
  }
}
