import 'dart:developer';
// import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/domain/usecase/auth/studenthub_login_usecase.dart';
import 'package:boilerplate/domain/usecase/profile/get_profile_uc.dart';
import 'package:boilerplate/presentation/home/store/theme/theme_store.dart';
import 'package:boilerplate/presentation/input_login/forgot_pwd_continue_screen.dart';
import 'package:boilerplate/presentation/input_login/input_login.dart';
import 'package:boilerplate/presentation/navigations/bottomNavigationBar.dart';
import 'package:boilerplate/presentation/profile_input/company/profile_company_input.dart';
import 'package:boilerplate/presentation/profile_input/student/profile_input_1.dart';
import 'package:boilerplate/presentation/signup/identity_signup/identity_signup.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/utils/strings/email_validate.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  bool _loginFail = false;
  String _loginFailText = '';

  final _emailController = TextEditingController();

  final DioClient _dioClient = getIt<DioClient>();
  //------
  final ThemeStore _themeStore = getIt<ThemeStore>();
  final _formKey = GlobalKey<FormState>();

  Future<void> handleLogin(String email) async {
    try {
      await _dioClient.dio
          .post(Endpoints.baseUrl + '/api/user/forgotPassword', data: {
        "email": email,
      });
    } catch (e) {
      setState(
        () {
          _loginFail = true;
          _loginFailText = e.toString();
        },
      );

      throw new Exception(e.toString());
    }
  }

  int handleRole(String token) {
    try {
      final jwt = JWT.decode(token);
      print('Payload: ${jwt.payload}');
      print('roles: ${jwt.payload['roles'][0]}');
      // return jwt.payload['roles'][0];
      int roleString = jwt.payload['roles'][0];
      // int role = int.parse(roleString);
      print(roleString);
      return roleString;
    } catch (e) {
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Building InputLogin");
    // print(_themeStore.darkMode);
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
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
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
                AppLocalizations.of(context)
                    .translate('retrieve_password_text'),
                // textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20.0),
              // const SizedBox(height: 17.0),
              buildForm(context),
              const SizedBox(height: 30),
              buildLaunchButton(context, () async {
                if (_formKey.currentState!.validate()) {
                  log("dcmm con cho");
                  try {
                    await handleLogin(_emailController.text);

                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => ForgotPasswordContScreen()));
                  } catch (e) {
                    throw e;
                  }
                }
              }),
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
                'Email',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  //fontFamily: "GGX88Reg_Light",
                  // color: _themeStore.darkMode
                  //     ? Colors.white
                  //     : Color(0xFF6e6e6e)
                ),
              ),
            ),
            TextFormField(
              onTapOutside: (event) {
                FocusScope.of(context).unfocus();
              },
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                //fontFamily: "GGX88Reg_Light",
                color: Color(0xFF6e6e6e),
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.all(16.0),
                enabledBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                ),
                errorBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red, width: 0.0),
                ),
                // border: _themeStore.darkMode == false
                //     ? OutlineInputBorder(
                //         borderSide: BorderSide(color: Colors.red))
                //     : OutlineInputBorder(borderSide: BorderSide.none),
                hintText: AppLocalizations.of(context)
                    .translate('enter_your_email_hint_text'),
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
                  return AppLocalizations.of(context)
                      .translate('email_validator_empy_text');
                } else if (!EmailValidate.isEmail(value)) {
                  return AppLocalizations.of(context)
                      .translate('email_validator_invalid_text');
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            _loginFail
                ? Container(
                    height: 20,
                    child: Text(
                      "${AppLocalizations.of(context).translate('error_text')}: ${_loginFailText}",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ))
                : Container()
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
          onPressed: () => onPress(),
          child: Text(
            AppLocalizations.of(context).translate('continue_text'),
            style: TextStyle(
              fontSize: 16,
              //fontFamily: "GGX88Reg",
              fontWeight: FontWeight.w600,
              // color: Colors.black,
            ),
          ),
        ));
  }

  Widget buildForgotPassword(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) {
              return const ForgotPasswordScreen();
            }));
          },
          child: Text(
            AppLocalizations.of(context).translate('forgot_password_text'),
            style: TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        )
      ],
    );
  }
}
