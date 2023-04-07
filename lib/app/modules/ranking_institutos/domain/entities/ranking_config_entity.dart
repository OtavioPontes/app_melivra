import 'dart:convert';

import 'package:app_melivra/app/modules/institutos/data/models/instituto_model.dart';
import 'package:app_melivra/app/modules/institutos/domain/entities/instituto_entity.dart';
import 'package:equatable/equatable.dart';

class RankingConfig extends Equatable {
  final int totalItems;
  final int totalPages;
  final int itemsPerPage;
  final List<Instituto> institutos;

  const RankingConfig({
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

  RankingConfig copyWith({
    int? totalItems,
    int? totalPages,
    int? itemsPerPage,
    List<Instituto>? institutos,
  }) {
    return RankingConfig(
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

  factory RankingConfig.fromMap(Map<String, dynamic> map) {
    return RankingConfig(
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

  factory RankingConfig.fromJson(String source) =>
      RankingConfig.fromMap(json.decode(source));
}
