import 'package:flutter/material.dart';
import 'package:test_auth/field_state.dart';
import 'package:test_auth/style.dart';
import './validators/validators.dart';

class HintWidget extends StatelessWidget {
  const HintWidget({super.key, required this.message, required this.state});
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
              HintState.normal => Style.fieldFocusColor
            }),
      ),
    );
  }
}