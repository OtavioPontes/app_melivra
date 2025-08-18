import 'package:app_melivra/app/modules/suggestions/domain/services/i_send_suggestion_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SuggestionsController {
  final ISendSuggestionService _sendSuggestionService;
  SuggestionsController({
    required ISendSuggestionService sendSuggestionService,
  }) : _sendSuggestionService = sendSuggestionService;

  TextEditingController suggestionController = TextEditingController();

  Future<void> sendSuggestion() async {
    final result = await _sendSuggestionService(
      suggestion: suggestionController.text,
    );

    await result.fold(
      (failure) async => Fluttertoast.showToast(
        msg: failure.message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.redAccent,
        textColor: Colors.black,
        fontSize: 12,
      ),
      (success) async {
        suggestionController.clear();
        return Fluttertoast.showToast(
          msg: "Sugestão enviada com sucesso ✅",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.greenAccent,
          textColor: Colors.black,
          fontSize: 12,
        );
      },
    );
  }
}
