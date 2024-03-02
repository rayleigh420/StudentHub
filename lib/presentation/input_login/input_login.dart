import 'dart:developer';

import 'package:boilerplate/presentation/signup/identity_signup/identity_signup.dart';
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
  @override
  Widget build(BuildContext context) {
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
            const Text(
              'Add your email and password',
              // textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  //fontFamily: "GGX88Reg_Light",
                  color: Color(0xFF707070)),
            ),
            const SizedBox(height: 17.0),
            const SizedBox(height: 17.0),
            buildForm(context),
            const SizedBox(height: 30),
            buildLaunchButton(context, () {
              log('Login pressed');
            }),
            buildSignupSection(context)
          ],
        ),
      ),
    );
  }

  Widget buildForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'YOUR EMAIL',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              //fontFamily: "GGX88Reg_Light",
              color: Color(0xFF6e6e6e)),
        ),
        TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter your email',
            hintStyle: TextStyle(
              // //fontFamily: "GGX88Reg_Light",
              color: Color(0xFFc6c6c6),
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        const Text(
          'YOUR PASSWORD',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              // //fontFamily: "GGX88Reg_Light",
              color: Color(0xFF6e6e6e)),
        ),
        TextField(
          controller: _passwordController,
          obscureText: !_showPassword,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: 'Enter your password',
            hintStyle: const TextStyle(
              //fontFamily: "GGX88Reg_Light",
              color: Color(0xFFc6c6c6),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _showPassword ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: () {
                setState(() {
                  _showPassword = !_showPassword;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget buildLaunchButton(BuildContext context, VoidCallback onPress) {
    return Container(
        alignment: Alignment.center,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            backgroundColor: const Color(0xFFD74638),
            minimumSize: Size(MediaQuery.of(context).size.width * 0.5,
                MediaQuery.of(context).size.height * 0.08),
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
              color: Colors.white,
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
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                return const SignUpIdentity();
              }));
            },
            child: const Text(
              "Sign Up",
              style: TextStyle(
                color: Color(0xFFD74638),
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
