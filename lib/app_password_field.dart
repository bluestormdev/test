import 'package:flutter/material.dart';
import 'package:test_auth/field_state.dart';
import 'package:test_auth/style.dart';
import './validators/validators.dart';
import './hint.dart';
class AppPasswordField extends StatefulWidget {
  const AppPasswordField({super.key});
  @override
  State<AppPasswordField> createState() => _AppPasswordField();
}

class _AppPasswordField extends State<AppPasswordField> {
  FieldStateNotifier? fieldState = FieldStateNotifier(
    controller: TextEditingController(),
    focusNode: FocusNode(),
    fieldKey: GlobalKey(),
    validators: [
      LengthValidator(min: 8, max: 64),
      CaseSensitivityValidator(),
      MinDigitsValidator()
    ],
  );
  bool get _hasError => fieldState?.state == AppFieldState.invalid;
  bool _isPasswordVisible = false;
  @override
  void dispose() {
    fieldState?.removeListener(_listener);
    fieldState?.dispose();
    fieldState = null;
    super.dispose();
  }

  _listener() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fieldState?.addListener(_listener);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          key: fieldState?.fieldKey,
          focusNode: fieldState?.focusNode,
          controller: fieldState?.controller,
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
            color: _hasError == true
                ? Style.fieldErrorColor
                : Style.fieldFocusColor,
          ),
          keyboardType: TextInputType.visiblePassword,
          autofillHints: const [AutofillHints.password],
          obscureText: !_isPasswordVisible,
          decoration: InputDecoration(
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                icon: Icon(
                  size: 20,
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: _hasError
                      ? Style.fieldErrorColor
                      : Style.fieldSuffixColor,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
            ),
            filled: true,
            fillColor: _hasError ? Style.fieldBgErrorColor : Colors.white,
            isCollapsed: true,
            isDense: true,
            hintText: 'Create password',
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 13.5),
            hintStyle: Style.fieldHint.copyWith(
              color: switch (fieldState?.state) {
                AppFieldState.normal => Style.fieldNormalColor,
                AppFieldState.invalid => Style.fieldErrorColor,
                AppFieldState.valid => Style.fieldNormalColor,
                _ => Style.fieldNormalColor,
              },
            ),
            border: _hasError ? Style.fieldErrorBorder : Style.fieldBorder,
            enabledBorder:
                _hasError ? Style.fieldErrorBorder : Style.fieldBorder,
            focusedBorder: Style.fieldFocusBorder,
           
          ),
       
        ),
        const SizedBox(height: 20),
        ...?fieldState?.hints
            .map((e) => HintWidget(message: e.message, state: e.state)),
      ],
    );
  }
}


