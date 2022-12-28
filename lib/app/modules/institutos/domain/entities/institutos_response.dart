import 'dart:convert';

import 'package:app_melivra/app/modules/institutos/data/models/instituto_model.dart';
import 'package:equatable/equatable.dart';

import 'package:app_melivra/app/modules/institutos/domain/entities/instituto_entity.dart';

class InstitutosResponse extends Equatable {
  final int totalItems;
  final int totalPages;
  final int itemsPerPage;
  final List<Instituto> institutos;

  const InstitutosResponse({
    required this.totalItems,
    required this.totalPages,
    required this.itemsPerPage,
    required this.institutos,
  });
  @override
  List<Object> get props => [
        totalItems,
        totalPages,
        itemsPerPage,
        institutos,
      ];

  InstitutosResponse copyWith({
    int? totalItems,
    int? totalPages,
    int? itemsPerPage,
    List<Instituto>? institutos,
  }) {
    return InstitutosResponse(
      totalItems: totalItems ?? this.totalItems,
      totalPages: totalPages ?? this.totalPages,
      itemsPerPage: itemsPerPage ?? this.itemsPerPage,
      institutos: institutos ?? this.institutos,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'totalItems': totalItems,
      'totalPages': totalPages,
      'itemsPerPage': itemsPerPage,
      'institutos':
          institutos.map((x) => InstitutoModel.fromEntity(x).toMap()).toList(),
    };
  }

  factory InstitutosResponse.fromMap(Map<String, dynamic> map) {
    return InstitutosResponse(
      totalItems: map['totalItems']?.toInt() ?? 0,
      totalPages: map['totalPages']?.toInt() ?? 0,
      itemsPerPage: map['itemsPerPage']?.toInt() ?? 0,
      institutos: List<Instituto>.from(
        map['institutos']?.map(
          (x) => InstitutoModel.fromMap(x).toEntity(),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory InstitutosResponse.fromJson(String source) =>
      InstitutosResponse.fromMap(json.decode(source));
}
