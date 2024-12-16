import 'package:flutter/material.dart';
import 'package:test_auth/style.dart';

class AppPasswordField extends StatefulWidget {
  const AppPasswordField({super.key
  });
  @override
  State<AppPasswordField> createState() => _AppFieldState();
}

class _AppFieldState extends State<AppPasswordField> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _controller = TextEditingController();
  bool _errorReset = false;
  bool _hasFocus = false;
  bool _isPasswordVisible = false;
  bool get _hasError => _key.currentState?.hasError == true;
  final GlobalKey<FormFieldState> _key = GlobalKey();

  late List<HintData> _hints = _onPasswordChange(null);

  List<HintData> _onPasswordChange(String? value, {bool invalidate = false}) {
    return <HintData>[
      HintData(
        order: 0,
        state: (value == null || value.isEmpty || value.length < 8 || value.length > 64  ||
    !RegExp(r'^\S*$').hasMatch(value))
            ? (invalidate ? HintState.invalid : HintState.none)
            : HintState.valid,
        message: 'minimum 8 characters(no spaces), maximum 64 characters',
      ),
      HintData(
        order: 1,
        state: (value != null &&
                RegExp(r'[A-Z]').hasMatch(value) &&
                RegExp(r'[a-z]').hasMatch(value))
            ? HintState.valid
            : (invalidate ? HintState.invalid : HintState.none),
        message: 'Uppercase and lowercase letters',
      ),
      HintData(
        order: 2,
        state: (value != null && RegExp(r'\d').hasMatch(value))
            ? HintState.valid
            : (invalidate ? HintState.invalid : HintState.none),
        message: 'At least one digit',
      )
    ];
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        setState(() {
          _hasFocus = _focusNode.hasFocus;
          if (_hasFocus) {
            _errorReset = true;
            _key.currentState!.validate();
          }
        });
      });
    });
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return '';
    }
    if (value.length < 8) {
      return '';
    }
    if (value.length > 64) {
      return '';
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return '';
    } if (!RegExp(r'[a-z]').hasMatch(value)) {
      return '';
    }
    if (!RegExp(r'^\S*$').hasMatch(value)) {
      return '';
    }
    if (!RegExp(r'\d').hasMatch(value)) {
      return '';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          key: _key,
          focusNode: _focusNode,
          controller: _controller,
          autocorrect: false,
          cursorColor: Style.fieldFocusColor,
          cursorHeight: 19.36,
          cursorErrorColor: Style.fieldFocusColor,
          scrollPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 14.5),
          onEditingComplete: () {
            FocusScope.of(context).nextFocus();
          },
          style: Style.text.copyWith(
            color: _hasError == true ? Style.fieldErrorColor : Style.fieldFocusColor,
          ),
          keyboardType: TextInputType.emailAddress,
          autofillHints: const [AutofillHints.email],
          obscureText: !_isPasswordVisible,
          decoration: InputDecoration(
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                icon: Icon(
                  size: 20,
                  _isPasswordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color:  _hasError ? Style.fieldErrorColor: Style.fieldSuffixColor,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
            ),
            filled: true,
            fillColor:
                _hasError ? Style.fieldBgErrorColor: Colors.white,
            isCollapsed: true,
            isDense: true,
            hintText: 'Create password',
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 13.5),
            hintStyle: Style.fieldHint.copyWith(
              color: _hasFocus
                  ? Style.fieldFocusColor
                  : (_hasError ? Style.fieldErrorColor : Style.fieldNormalColor),
            ),
            border: Style.fieldBorder,
            enabledBorder: Style.fieldBorder,
            focusedBorder: Style.fieldFocusBorder,
            errorBorder: Style.fieldErrorBorder,
            focusedErrorBorder: Style.fieldFocusBorder,
            errorStyle: const TextStyle(
              height: 0,
              fontSize: 0,
            ),
          ),

          validator: (String? val) {
            final result = _errorReset ? null : _validatePassword(val);
            _hints = _onPasswordChange(val, invalidate: !_errorReset);

            setState(() {
              _errorReset = false;
            });
            return result;
          },
          onChanged: (String? val) {
            setState(() {
              _hints = _onPasswordChange(val);
            });
          },
        ),
        const SizedBox(height: 20),
        ..._hints.map((e) => Hint(message: e.message, state: e.state)),
      ],
    );
  }
}

class Hint extends StatelessWidget {
  const Hint({super.key, required this.message, required this.state});
  final String message;
  final HintState state;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, bottom: 4),
      child: Text(
        message,
        style: TextStyle(
            fontSize: 13,
            height: 18 / 13,
            fontWeight: FontWeight.w400,
            color: switch (state) {
              HintState.valid => Style.fieldValidityColor,
              HintState.invalid => Style.fieldErrorColor,
              HintState.none => Style.fieldFocusColor
            }),
      ),
    );
  }
}

enum HintState { valid, invalid, none }

class HintData {
  HintData({required this.message, required this.state, required this.order});

  final int order;
  final String message;
  HintState state;
}

enum HintType { minLength, caseSensitivity, minDigits }
