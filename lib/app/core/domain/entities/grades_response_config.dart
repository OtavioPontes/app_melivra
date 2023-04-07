import 'dart:convert';

import 'package:app_melivra/app/core/domain/entities/grade_response.dart';
import 'package:equatable/equatable.dart';

class GradesResponseConfig extends Equatable {
  final int totalItems;
  final int totalPages;
  final int itemsPerPage;
  final List<GradeResponse> response;

  const GradesResponseConfig({
    required this.totalItems,
    required this.totalPages,
    required this.itemsPerPage,
    required this.response,
  });

  @override
  List<Object> get props => [
        totalItems,
        totalPages,
        itemsPerPage,
        response,
      ];

  GradesResponseConfig copyWith({
    int? totalItems,
    int? totalPages,
    int? itemsPerPage,
    List<GradeResponse>? response,
  }) {
    return GradesResponseConfig(
      totalItems: totalItems ?? this.totalItems,
      totalPages: totalPages ?? this.totalPages,
      itemsPerPage: itemsPerPage ?? this.itemsPerPage,
      response: response ?? this.response,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'totalItems': totalItems,
      'totalPages': totalPages,
      'itemsPerPage': itemsPerPage,
      'data': response.map((x) => x.toMap()).toList(),
    };
  }

  factory GradesResponseConfig.fromMap(Map<String, dynamic> map) {
    return GradesResponseConfig(
      totalItems: map['total_items']?.toInt() ?? 0,
      totalPages: map['total_pages']?.toInt() ?? 0,
      itemsPerPage: map['items_per_page']?.toInt() ?? 0,
      response: map['data'] != null
          ? List<GradeResponse>.from(
              map['data']?.map((x) => GradeResponse.fromMap(x)),
            )
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory GradesResponseConfig.fromJson(String source) =>
      GradesResponseConfig.fromMap(json.decode(source));
}
