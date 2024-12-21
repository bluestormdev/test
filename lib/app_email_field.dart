import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_auth/style.dart';
import './field_state.dart';
import './validators/validators.dart';
import './hint.dart';

class AppEmailField extends StatefulWidget {
  const AppEmailField({
    super.key,
  });
  @override
  createState() => _AppFieldState();
}

class _AppFieldState extends State<AppEmailField> {
  final fieldState = FieldStateNotifier(
    controller: TextEditingController(),
    focusNode: FocusNode(),
    fieldKey: GlobalKey(),
    validators: [
      EmailValidator(),
    ],
  );

  _listener() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fieldState.addListener(_listener);
  }

  @override
  void dispose() {
    fieldState.dispose();
    fieldState.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          key: fieldState.fieldKey,
          focusNode: fieldState.focusNode,
          controller: fieldState.controller,
          autocorrect: false,
          cursorColor: const Color(0xFF4A4E71),
          cursorHeight: 19.36,
          cursorErrorColor: const Color(0xFF4A4E71),
          scrollPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 14.5),
          onEditingComplete: () {
            FocusScope.of(context).nextFocus();
          },
          style: Style.text.copyWith(
            color: fieldState.state == AppFieldState.invalid
                ? Style.fieldErrorColor
                : Style.fieldFocusColor,
          ),
          keyboardType: TextInputType.emailAddress,
          autofillHints: const [AutofillHints.email],
          decoration: InputDecoration(
            filled: true,
            fillColor: fieldState.state == AppFieldState.invalid
                ? Style.fieldBgErrorColor
                : Colors.white,
            isCollapsed: true,
            isDense: true,
            hintText: 'Email',
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 13.5),
            hintStyle: Style.fieldHint.copyWith(
                color: switch (fieldState.state) {
              AppFieldState.normal => Style.fieldNormalColor,
              AppFieldState.invalid => Style.fieldErrorColor,
              _ => Style.fieldNormalColor
            }),
            border: Style.fieldBorder,
            enabledBorder: fieldState.state == AppFieldState.invalid ? Style.fieldErrorBorder: Style.fieldBorder,
            focusedBorder: Style.fieldFocusBorder,
          ),
        ),
        if (fieldState.error != null) ...[
          const SizedBox(height: 8),
          HintWidget(message: fieldState.error!, state: HintState.invalid)
        ]
      ],
    );
  }
}
