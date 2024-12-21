import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import './validators/validators.dart';
class FieldStateNotifier extends ChangeNotifier {
  FieldStateNotifier({
    required this.controller,
    required this.focusNode,
    required this.fieldKey,
    this.validators = const [],
  }) {
    controller.addListener(fieldListener);
    focusNode.addListener(focusNodeListener);
    hints = validator.validators
        .map((v) => Hint(message: v.message, state: HintState.normal))
        .toList();
  }

  AppFieldState state = AppFieldState.normal;
  List<Hint> hints = [];
  String? error;
  late final validator = ValidatorAdapter( validators);
  final List<Validator> validators;
  bool isTouched = false;
  bool isFocused = false;
  bool isValid = false;
  TextEditingController controller;
  GlobalKey fieldKey;
  FocusNode focusNode;
  Function? focusListener;

  fieldListener() {
    print('field listeners works');
    if(controller.text.isNotEmpty){
      isTouched = true;
    }
    validate(value: controller.text);
  }

  focusNodeListener() {
    onFieldFocusChange(focusNode.hasFocus);
  }

  @override
  void dispose() {
    controller.removeListener(fieldListener);
    focusNode.removeListener(focusNodeListener);
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void onFieldFocusChange(bool hasFocus) {
    print('field is ${hasFocus}');
    isFocused = hasFocus;
    if (!hasFocus) {
      isTouched = true;
    }
    validate(value: controller.text, withError: false);
    notifyListeners();
  }

  validate({String? value, bool withError = false}) {
    final validation = validator.validate(value);
    final _hints = <Hint>[];
    String? _error;
    bool _isValid = true;
    for (final v in validation) {
      late final HintState hintState;
      if (isTouched) {
        if (v.isError) {
          hintState = HintState.invalid;
          _error ??= v.message;
        } else {
          hintState = HintState.valid;
        }
      } else {
        hintState = HintState.normal;
      }
      _isValid = _isValid && !v.isError;
      _hints.add(Hint(message: v.message, state: hintState));
    }

    ///TODO: change field state;
    this.hints = _hints;
    if (isTouched) {
      if (isFocused) {
        this.state = AppFieldState.normal;
        this.error = null;
      } else {
        if (withError) {
          this.error = _error;
        } else {
          this.error = null;
        }
        this.state = _isValid ? AppFieldState.valid : AppFieldState.invalid;
      }
    } else {
      this.error = null;
      this.state = AppFieldState.normal;
    }
    this.isValid = _isValid;
    notifyListeners();
  }
}

class Hint {
  Hint({required this.message, required this.state});
  final String message;
  final HintState state;
}

enum HintState {
  normal,
  valid,
  invalid,
}

enum AppFieldState {
  normal,
  valid,
  invalid,
}