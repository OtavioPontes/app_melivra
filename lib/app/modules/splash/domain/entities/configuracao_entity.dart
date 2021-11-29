import 'package:equatable/equatable.dart';

class Configuracao extends Equatable {
  final String versaoMinima;
  final String ultimaVersao;

  const Configuracao({
    required this.versaoMinima,
    required this.ultimaVersao,
  });

  Configuracao copyWith({
    String? versaoMinima,
    String? ultimaVersao,
  }) {
    return Configuracao(
      versaoMinima: versaoMinima ?? this.versaoMinima,
      ultimaVersao: ultimaVersao ?? this.ultimaVersao,
    );
  }

  @override
  List<Object> get props => [
        versaoMinima,
        ultimaVersao,
      ];
}
