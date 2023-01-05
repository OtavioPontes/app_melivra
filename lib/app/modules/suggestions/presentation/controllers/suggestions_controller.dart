import 'package:app_melivra/app/modules/suggestions/data/services/send_suggestion_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SuggestionsController {
  final SendSuggestionService _sendSuggestionService;
  SuggestionsController({
    required SendSuggestionService sendSuggestionService,
  }) : _sendSuggestionService = sendSuggestionService;

  TextEditingController suggestionController = TextEditingController();

  Future<void> sendSuggestion() async {
    final result = await _sendSuggestionService(
      suggestion: suggestionController.text,
    );

    result.fold(
      (failure) async => await Fluttertoast.showToast(
        msg: failure.message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.redAccent,
        textColor: Colors.black,
        fontSize: 12.0,
      ),
      (success) async {
        suggestionController.clear();
        return await Fluttertoast.showToast(
          msg: "Sugestão enviada com sucesso ✅",
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
