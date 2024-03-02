import 'dart:developer';

import 'package:boilerplate/presentation/input_login/input_login.dart';
import 'package:boilerplate/presentation/signup/input_signup/input_signup.dart';
import 'package:flutter/material.dart';

class SignUpIdentity extends StatefulWidget {
  const SignUpIdentity({super.key});

  @override
  State<SignUpIdentity> createState() => _SignUpIdentityState();
}

class _SignUpIdentityState extends State<SignUpIdentity> {
  int selected = 0;
  late double x;
  late double y;

  @override
  void initState() {
    super.initState();
    x = 50;
    y = 50;
  }

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
              'Join us as company or student',
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
            buildLaunchButton(
                context,
                (selected == 0)
                    ? null
                    : () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => InputSignUp(type: selected)));
                      }),
            const SizedBox(height: 30),
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
        checkBoxItem(
            image: Image.asset(
              '/images/playstore.png',
              height: x,
              width: y,
            ),
            boxValue: 1,
            text: "I am a company, find engineer for project"),
        checkBoxItem(
            image: Image.asset(
              '/images/playstore.png',
              height: x,
              width: y,
            ),
            boxValue: 2,
            text: "I am a student, find company for experience (money)"),
      ],
    );
  }

  Widget buildLaunchButton(BuildContext context, VoidCallback? onPress) {
    return Container(
        alignment: Alignment.center,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            backgroundColor: const Color(0xFFD74638),
            minimumSize: Size(MediaQuery.of(context).size.width * 0.5,
                MediaQuery.of(context).size.height * 0.1),
          ),
          onPressed: (selected == 0) ? null : onPress,
          child: const Text(
            'Create Account',
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
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            child: const Text("Already have a Student Hub account?"),
          ),
          const SizedBox(width: 5),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const InputLogin();
              }));
            },
            child: const Text(
              "Login",
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

  Widget checkBoxItem(
      {required Image image, required int boxValue, required String text}) {
    return InkWell(
      onTap: () => {
        if (selected == boxValue)
          {
            setState(() {
              selected = 0;
            })
          }
        else
          {
            setState(() {
              selected = boxValue;
            })
          }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: (selected == boxValue)!
                ? const Color(0xFFD74638)
                : const Color(0XFFd2d2d2), // Màu của border
            width: 2.0, // Độ dày của border
          ),
          borderRadius: BorderRadius.circular(8.0), // Độ cong của border
        ),
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween, // Đặt checkbox về đầu
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.75,
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  image,
                  const SizedBox(height: 10.0),
                  Container(
                      child: Text(
                    text,
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.clip,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,

                        //fontFamily: "GGX88Reg_Light",
                        color: Color(0xFF6e6e6e)),
                  ))
                  // Text(text,
                  //     overflow: TextOverflow.fade,
                  //     style: const TextStyle(
                  //         fontSize: 15,
                  //         fontWeight: FontWeight.normal,

                  //         //fontFamily: "GGX88Reg_Light",
                  //         color: Color(0xFF6e6e6e))),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Checkbox(
                activeColor: const Color(0xFFD74638),
                checkColor: Colors.white,
                value: selected == boxValue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                  side: const BorderSide(color: Colors.grey),
                ),
                onChanged: (bool? value) {
                  if (selected == boxValue) {
                    setState(() {
                      selected = 0;
                    });
                  } else {
                    setState(() {
                      selected = boxValue;
                    });
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
