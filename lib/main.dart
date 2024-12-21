// Import Flutter packages
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_auth/button.dart';
import 'package:test_auth/app_email_field.dart';
import 'package:test_auth/style.dart';
import 'package:test_auth/app_password_field.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        final currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthPage(),
      ),
    );
  }
}

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();

  void _submitForm() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            surfaceTintColor: const Color(0xFFF4f9ff),
            title: const Text('Sign up success'),
            titleTextStyle: const TextStyle(
              fontSize: 26.0,
              height: 1,
              fontWeight: FontWeight.bold,
              color:  Color(0xFF4A4E71), fontFamily: 'Inter'

            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK', style: TextStyle(
                    fontSize: 16.0,
                    height: 19.36/16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF4A4E71),
                    fontFamily: 'Inter'
                ),),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4f9ff),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFFF4F9FF),
              const Color(0xFFE0EDFB),
            ],
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                  top: 13,
                  // bottom: 36,
                  right: 60,
                  left: 70,
                  child: Image.asset('assets/images/bg_pattern.png', fit: BoxFit.fitHeight)),
              Form(
                key: _formKey,
                child: ListView(
                  children: [
                    const SizedBox(height: 94),
                    const Text(
                      'Sign up',
                      style: TextStyle(
                        fontSize: 28.0,
                        height: 1,
                        fontWeight: FontWeight.bold,
                        color:  Color(0xFF4A4E71),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40.0),
                    const AppEmailField(),
                    const SizedBox(height: 20),
                    const AppPasswordField(),
                    const SizedBox(height: 40.0),
                    Center(
                      child: AppButton(
                        label: 'Sign up',
                        onTap: (){
                          _submitForm();
                        },
                      )
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
