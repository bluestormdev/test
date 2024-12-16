import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_auth/style.dart';
import 'package:test_auth/password_field.dart';

class AppEmailField extends StatefulWidget{
  const AppEmailField({super.key, });
  @override
  createState() => _AppFieldState();
}

class _AppFieldState extends State<AppEmailField>{
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormFieldState> _key = GlobalKey();

  bool get _hasError => _key.currentState?.hasError == true;
  final FocusNode _focusNode = FocusNode();
  bool _hasFocus = false;
  bool _errorReset = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
        setState(() {
          _hasFocus = _focusNode.hasFocus;
          if(_hasFocus){
            setState(() {
              _errorReset = true;
              _key.currentState!.validate();
            });
          }
        });
    });
  }


  String? _validate(String? value) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (value == null || value.isEmpty || !emailRegex.hasMatch(value)) {

      return '';
      return 'Enter a valid email address';
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
          cursorColor: const Color(0xFF4A4E71),
          cursorHeight: 19.36,
          cursorErrorColor: const Color(0xFF4A4E71),
          scrollPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14.5),
          onEditingComplete: () {
            FocusScope.of(context).nextFocus();
          },
          style: Style.text.copyWith(
            color: _hasError ? Style.fieldErrorColor: Style.fieldFocusColor ,
          ),
          keyboardType: TextInputType.emailAddress,
          autofillHints: const [AutofillHints.email],
          decoration: InputDecoration(
            filled: true,
            fillColor:
            _hasError ?  Style.fieldBgErrorColor:  Colors.white,
            isCollapsed: true,
            isDense: true,
            hintText: 'Email',
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 13.5),
            hintStyle: Style.fieldHint.copyWith(
              color: _hasFocus
                  ? Style.fieldFocusColor
                  : (_hasError ?  Style.fieldErrorColor:  Style.fieldNormalColor),
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
          validator: (String? val ) {
            final result = _errorReset ? null : _validate(val);

            setState(() {
              _errorReset = false;
            });
            return result;
          },
          onChanged: (String? val){
            // widget.onChanged(val);
          },
        ),
        if (_hasError)...[
          const SizedBox(height: 8),
          const Hint(message:  'Enter a valid email address', state: HintState.invalid)
        ]
      ],
    );
  }
}