import 'package:app_melivra/app/core/stores/user_store.dart';
import 'package:app_melivra/app/modules/inicio/presentation/bloc/inicio_bloc.dart';
import 'package:app_melivra/app/modules/login/domain/services/i_login_service.dart';
import 'package:bloc/bloc.dart';

class InicioController extends Bloc<InicioBlocEvent, InicioBlocState> {
  final ILoginService _loginService;
  final UserStore _userStore;

  InicioController({
    required ILoginService loginService,
    required UserStore userStore,
  })  : _loginService = loginService,
        _userStore = userStore,
        super(InicioBlocEmptyState()) {
    on<InicioBlocSignInEvent>(handleSignIn);
  }

  Future<void> handleSignIn(InicioBlocSignInEvent event, Emitter emit) async {
    emit(InicioBlocLoadingState());
    final result = await _loginService.oauthLogin(idToken: event.idToken);
    result.fold(
      (failure) {
        emit(InicioBlocFailureState(message: "Erro ao logar com o Google"));
        _userStore.clearUser();
      },
      (user) {
        _userStore.setUser(user);
        emit(InicioBlocSuccessState());
      },
    );
  }
}
