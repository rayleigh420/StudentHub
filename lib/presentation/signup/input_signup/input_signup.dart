import 'dart:developer';

import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/domain/repository/auth/auth_repository.dart';
import 'package:boilerplate/domain/usecase/auth/studenthub_login_usecase.dart';
import 'package:boilerplate/domain/usecase/auth/studenthub_signup_usecase.dart';
import 'package:boilerplate/presentation/home/store/theme/theme_store.dart';
import 'package:boilerplate/presentation/navigations/bottomNavigationBar.dart';
import 'package:boilerplate/presentation/profile/profile_company_input.dart';
import 'package:boilerplate/presentation/profile_input/profile_input_1.dart';
import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:flutter/material.dart';

class InputSignUp extends StatefulWidget {
  const InputSignUp({super.key, required this.type});
  final int type;
  @override
  State<InputSignUp> createState() => _InputSignUpState();
}

class _InputSignUpState extends State<InputSignUp> {
  bool _showPassword = false;
  bool _agreeToApply = false;
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  Color textColor = Color(0xFF6C6C6C);
  Color textFieldColor = Color(0xFF6C6C6C);
  final ThemeStore _themeStore = getIt<ThemeStore>();
  final StudentHubSignupUC _authRepository = getIt<StudentHubSignupUC>();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    // _themeStore.changeBrightnessToDark(true);
    textColor = _themeStore.darkMode ? Colors.white : Color(0xFF6e6e6e);
  }

  Future<String> signUp(
      String email, String password, String fullName, int role) async {
    try {
      final response = await _authRepository.call(
          params: SignUpParams(
              email: email,
              password: password,
              fullName: fullName,
              role: role));
      log(response);
      return response;
    } catch (e) {
      log(e.toString());
      return e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    log('Building InputSignUp');
    log(widget.type.toString());
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('StudentHub'),
        actions: [
          IconButton(
            icon: Icon(
                _themeStore.darkMode ? Icons.person_2 : Icons.person_2_rounded),
            onPressed: () {
              _themeStore.changeBrightnessToDark(!_themeStore.darkMode);
            },
          )
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          height: DeviceUtils.getScaledHeight(context, 1),
          // padding: const EdgeInsets.all(20.0),
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              top: 20,
              left: 20,
              right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 17.0),
              Text(
                'Sign up as ${(widget.type == 1) ? 'Company' : 'Student'}',
                // textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold
                    //fontFamily: "GGX88Reg_Light",
                    // color: Color(0xFF626262)
                    ),
              ),
              const SizedBox(height: 20.0),
              // const SizedBox(height: 17.0),

              buildForm(context),
              const SizedBox(height: 30),
              buildLaunchButton(context, () async {
                log('Login pressed');
                try {
                  final token = await signUp(
                      _emailController.text,
                      _passwordController.text,
                      _fullNameController.text,
                      widget.type);
                  if (widget.type == 1) {
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: (context) {
                      return ProfileCompanyInput();
                      // return AppBottomNavigationBar(
                      //   selectedIndex: 0,
                      //   isStudent: false,
                      // );
                    }));
                  } else {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => ProfileInput1()));
                    ;
                  }
                } catch (e) {
                  throw Exception(e.toString());
                }
              }),
              // buildSignupSection(context)
            ],
          ),
        ),
      ),
    ));
  }

  Widget buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
            child: Text(
              'Full name',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                //fontFamily: "GGX88Reg_Light",
                // color: textColor
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          TextFormField(
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
            },
            controller: _fullNameController,
            keyboardType: TextInputType.name,
            style: TextStyle(
              color: textFieldColor,
            ),
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.all(16),
              enabledBorder: const OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 0.0),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 0.0),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red, width: 0.0),
              ),
              border: OutlineInputBorder(borderSide: BorderSide.none),
              hintText: 'Enter your email',
              hintStyle: TextStyle(
                //fontFamily: "GGX88Reg_Light",

                color: Color(0xFFc6c6c6),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
            child: Text(
              'Email',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                //fontFamily: "GGX88Reg_Light",
                // color: textColor
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          TextFormField(
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
            },
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: textFieldColor,
            ),
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.all(16),
              enabledBorder: const OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 0.0),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 0.0),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red, width: 0.0),
              ),
              border: OutlineInputBorder(borderSide: BorderSide.none),
              hintText: 'Enter your email',
              hintStyle: TextStyle(
                //fontFamily: "GGX88Reg_Light",
                color: Color(0xFFc6c6c6),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
            child: Text(
              'Password',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                //fontFamily: "GGX88Reg_Light",
                // color: textColor
              ),
            ),
          ),
          TextFormField(
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
            },
            controller: _passwordController,
            obscureText: !_showPassword,
            style: TextStyle(
              color: textFieldColor,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.all(16),
              enabledBorder: const OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 0.0),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 0.0),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red, width: 0.0),
              ),
              border: const OutlineInputBorder(borderSide: BorderSide.none),
              hintText: 'Enter your password (8 or more characters)',
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
          const SizedBox(height: 18.0),
          GestureDetector(
            onTap: () {
              setState(() {
                _agreeToApply = !_agreeToApply;
              });
            },
            child: Row(
              children: [
                SizedBox(
                  height: 24,
                  width: 24,
                  child: Checkbox(
                    value: _agreeToApply,
                    activeColor: const Color(0xFF4285F4),
                    checkColor: Colors.white,
                    onChanged: (value) {
                      setState(() {
                        _agreeToApply = value!;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Container(
                  width: DeviceUtils.getScaledWidth(context, 0.8),
                  child: Text(
                    'Yes, I understand and agree to StudentHub',
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      //fontFamily: "GGX88Reg_Light",
                      color: textColor,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
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
            backgroundColor: _themeStore.darkMode ? Colors.white : null,
            minimumSize: Size(MediaQuery.of(context).size.width * 1,
                MediaQuery.of(context).size.height * 0.06),
          ),
          onPressed: () {
            onPress();
          },
          child: const Text(
            'Create Account',
            style: TextStyle(
              fontSize: 16,
              //fontFamily: "GGX88Reg",
              fontWeight: FontWeight.w600,
              // color: Colors.white,
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
            child: Text("Looking for projects?"),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) {
                return InputSignUp(
                  type: (widget.type == 1) ? 2 : 1,
                );
              }));
            },
            child: Text(
              " Apply as ${(widget.type == 1) ? 'Student' : 'Company'}",
              style: const TextStyle(
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
