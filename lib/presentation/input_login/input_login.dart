import 'dart:developer';

import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/home/store/theme/theme_store.dart';
import 'package:boilerplate/presentation/signup/identity_signup/identity_signup.dart';
import 'package:boilerplate/utils/strings/email_validate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputLogin extends StatefulWidget {
  const InputLogin({super.key});

  @override
  State<InputLogin> createState() => _InputLoginState();
}

class _InputLoginState extends State<InputLogin> {
  bool _showPassword = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  //------
  final ThemeStore _themeStore = getIt<ThemeStore>();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _themeStore.changeBrightnessToDark(true);
  }

  @override
  Widget build(BuildContext context) {
    print(_themeStore.darkMode);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'StudentHub',
              // textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24,
                  //fontFamily: "GGX88HV",
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 17.0),
            Text(
              'Add your email and password',
              // textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  //fontFamily: "GGX88Reg_Light",
                  color:
                      _themeStore.darkMode ? Colors.white : Color(0xFF6e6e6e)),
            ),
            const SizedBox(height: 17.0),
            const SizedBox(height: 17.0),
            buildForm(context),
            const SizedBox(height: 30),
            buildLaunchButton(context, () {
              if (_formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data')),
                );
              }
            }),
            buildSignupSection(context)
          ],
        ),
      ),
    );
  }

  Widget buildForm(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'YOUR EMAIL',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  //fontFamily: "GGX88Reg_Light",
                  color:
                      _themeStore.darkMode ? Colors.white : Color(0xFF6e6e6e)),
            ),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                //fontFamily: "GGX88Reg_Light",
                color: Color(0xFF6e6e6e),
              ),
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: const OutlineInputBorder(borderSide: BorderSide.none),
                hintText: 'Enter your email',
                hintStyle: TextStyle(
                  // //fontFamily: "GGX88Reg_Light",
                  color: Color(0xFFc6c6c6),
                ),
                errorStyle: TextStyle(
                  // fontFamily: "GGX88Reg_Light",
                  fontSize: 14,
                  color: Color(0xFFD74638),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                } else if (!EmailValidate.isEmail(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            Text(
              'YOUR PASSWORD',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  // //fontFamily: "GGX88Reg_Light",
                  color:
                      _themeStore.darkMode ? Colors.white : Color(0xFF6e6e6e)),
            ),
            TextFormField(
              controller: _passwordController,
              obscureText: !_showPassword,
              style: TextStyle(
                //fontFamily: "GGX88Reg_Light",
                color: Color(0xFF6e6e6e),
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: const OutlineInputBorder(borderSide: BorderSide.none),
                hintText: 'Enter your password',
                hintStyle: const TextStyle(
                  //fontFamily: "GGX88Reg_Light",
                  color: Color(0xFFc6c6c6),
                ),
                suffixIcon: IconButton(
                  color: Color(0xFFc6c6c6),
                  icon: Icon(
                    _showPassword ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _showPassword = !_showPassword;
                    });
                  },
                ),
                errorStyle: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFFD74638),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                } else if (value.length < 8) {
                  return 'Password must be at least 8 characters';
                }
                return null;
              },
            ),
          ],
        ));
  }

  Widget buildLaunchButton(BuildContext context, VoidCallback onPress) {
    return Container(
        alignment: Alignment.center,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: _themeStore.darkMode ? Colors.white : null,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            // backgroundColor: const Color(0xFFD74638),
            minimumSize: Size(MediaQuery.of(context).size.width * 1,
                MediaQuery.of(context).size.height * 0.06),
          ),
          onPressed: () {
            onPress();
          },
          child: const Text(
            'Sign In',
            style: TextStyle(
              fontSize: 16,
              //fontFamily: "GGX88Reg",
              fontWeight: FontWeight.w600,
              // color: Colors.black,
            ),
          ),
        ));
  }

  Widget buildSignupSection(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            child: Text("Dont have Student Hub account?"),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) {
                return const SignUpIdentity();
              }));
            },
            child: const Text(
              "Sign Up",
              style: TextStyle(
                color: Color(0xFF4285F4),
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
