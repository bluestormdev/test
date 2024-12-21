import 'package:test_auth/field_state.dart';

class ValidatorAdapter {
  ValidatorAdapter(this.validators);
  final List<Validator> validators;
  List<Validation> validate(String? value) {
    final List<Validation> result = [];
    for (final validator in validators) {
      result.add(validator.validate(value));
    }
    return result;
  }
}

abstract class Validator {
  String get message;

  ///factory method to create a product
  Validation validate(String? value);
}

class LengthValidator extends Validator {
  LengthValidator({
    required this.min,
    required this.max,
    this.message = 'Minimum 8 characters(no spaces), maximum 64 characters',
  });

  final int min;
  final int max;
  final String message;

  @override
  Validation validate(String? value) {
    if (value?.length != null && value!.length >= min && value!.length <= 64) {
      return Validation( message: message, isError: false);
    } else {
      return Validation( message: message, isError: true);
    }
  }
}

class CaseSensitivityValidator extends Validator {
  CaseSensitivityValidator({
    this.message = 'Uppercase and lowercase letters',
  });

  final String message;

  @override
  Validation validate(String? value) {
    final isValid = (value != null &&
        RegExp(r'[A-Z]').hasMatch(value) &&
        RegExp(r'[a-z]').hasMatch(value));
    return Validation(message: message, isError: !isValid);
  }
}

class Validation {
  Validation(
      { required this.message, required this.isError});
  final String message;
  final bool isError;
}



class MinDigitsValidator extends Validator {
  MinDigitsValidator({this.min = 1, this.message = 'At least one digit'});
  final int min;

  @override
  String message;

  @override
  Validation validate(String? value) {
    final isValid = RegExp(r'\d').hasMatch(value??"");
    return Validation(message: message, isError: !isValid);
  }
}


class EmailValidator extends Validator{
  EmailValidator({this.message = 'Enter a valid email address'});
  final String message;

  @override
  Validation validate(String? value) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (value == null || value.isEmpty || !emailRegex.hasMatch(value)) {
      return Validation(message: message, isError: true);
    }
    return Validation(message: message, isError: false);
  }
}