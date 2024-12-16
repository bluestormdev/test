import 'package:flutter/material.dart';

class Style {
  static Color get fieldErrorColor => const Color(0xFFFF8080);
  static Color get fieldNormalColor => const Color(0xFF6F91BC);
  static Color get fieldFocusColor => const Color(0xFF4A4E71);
   static Color get fieldValidityColor => const Color(0xFF27B274);
   static Color get fieldBgErrorColor => const Color(0xFFFDEFEE);
   static Color get fieldSuffixColor => const Color(0xFF6F91BC);

  static TextStyle get text => const TextStyle(
    height: 19.36 / 16,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontFamily: 'Inter',
  );

   static TextStyle get fieldHint => const TextStyle(
    height: 19.36 / 16,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    fontFamily: 'Inter',
  );

  static InputBorder get fieldBorder => OutlineInputBorder(
    borderSide: const BorderSide(
      color: Colors.white,
    ),
    borderRadius: BorderRadius.circular(10),
  );

  static InputBorder get fieldFocusBorder => OutlineInputBorder(
    borderSide: BorderSide(color: Style.fieldNormalColor),
    borderRadius: BorderRadius.circular(10),
  );

  static InputBorder get fieldErrorBorder => OutlineInputBorder(
    borderSide: BorderSide(
      color: Style.fieldErrorColor,
    ),
    borderRadius: BorderRadius.circular(10),
  );
}