import 'dart:developer';
// import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/domain/usecase/auth/studenthub_login_usecase.dart';
import 'package:boilerplate/domain/usecase/profile/get_profile_uc.dart';
import 'package:boilerplate/presentation/home/store/theme/theme_store.dart';
import 'package:boilerplate/presentation/input_login/forgot_pwd_screen.dart';
import 'package:boilerplate/presentation/navigations/bottomNavigationBar.dart';
import 'package:boilerplate/presentation/profile_input/company/profile_company_input.dart';
import 'package:boilerplate/presentation/profile_input/student/profile_input_1.dart';
import 'package:boilerplate/presentation/signup/identity_signup/identity_signup.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/utils/strings/email_validate.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:flutter/material.dart';

class InputLogin extends StatefulWidget {
  const InputLogin({super.key});

  @override
  State<InputLogin> createState() => _InputLoginState();
}

class _InputLoginState extends State<InputLogin> {
  bool _loginFail = false;
  String _loginFailText = '';
  bool _showPassword = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final StudentHubLoginUC _authRepository = getIt<StudentHubLoginUC>();
  //------
  final ThemeStore _themeStore = getIt<ThemeStore>();
  final _formKey = GlobalKey<FormState>();

  final GetProfileUseCase _getProfileUseCase = getIt<GetProfileUseCase>();

  Future<String> handleLogin(String email, String password) async {
    try {
      String a = await _authRepository.call(
          params: LoginParams(username: email, password: password));
      log(a);

      return a;
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
                    .translate('add_your_email_and_password_text'),
                // textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  //fontFamily: "GGX88Reg_Light",
                  // color:
                  //     _themeStore.darkMode ? Colors.white : Color(0xFF6e6e6e)
                ),
              ),
              const SizedBox(height: 20.0),
              // const SizedBox(height: 17.0),
              buildForm(context),
              const SizedBox(height: 30),
              buildLaunchButton(context, () async {
                if (_formKey.currentState!.validate()) {
                  // DeviceUtils.hideKeyboard(context);
                  log("dcmm con cho");
                  try {
                    String token = await handleLogin(
                        _emailController.text, _passwordController.text);
                    log("token nè dcmm" + token);
                    // lnduy20@clc.fitus.edu.vn
                    // Password123

                    if (token.isNotEmpty) {
                      print("token: $token");

                      await _getProfileUseCase.call(params: null);

                      List<int>? roles =
                          await getIt<SharedPreferenceHelper>().roles;

                      int? currentCompanyId =
                          await getIt<SharedPreferenceHelper>()
                              .currentCompanyId;

                      int? currentStudentId =
                          await getIt<SharedPreferenceHelper>()
                              .currentStudentId;

                      print("roles from sign in: $roles");
                      print("currentCompanyId: $currentCompanyId");
                      print("currentStudentId: $currentStudentId");

                      if (currentStudentId == null &&
                          currentCompanyId == null) {
                        if (roles![0] == 0) {
                          Navigator.of(context, rootNavigator: true)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (context) => ProfileInput1(),
                                  maintainState: true));
                        } else if (roles![0] == 1) {
                          print("company");
                          Navigator.of(context, rootNavigator: true)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (context) => ProfileCompanyInput(),
                                  maintainState: true));
                        }
                      } else {
                        Navigator.of(context, rootNavigator: true)
                            .push(MaterialPageRoute(
                                builder: (context) => AppBottomNavigationBar(
                                      selectedIndex: 1,
                                    ),
                                maintainState: false));
                      }
                    }

                    // Navigator.of(context)
                    //     .pushReplacementNamed('/student_profile_input_1');

                    // Navigator.of(context)
                    //     .pushReplacement(MaterialPageRoute(builder: (context) {
                    //   return AppBottomNavigationBar(
                    //     isStudent: true,
                    //     selectedIndex: 0,
                    //   );
                    // }));

                    // log("123");
                    // log(token);
                    // int role = handleRole(token);
                    // print(role);
                    // if (role == 0) {
                    //   Navigator.of(context).pushReplacement(
                    //       MaterialPageRoute(builder: (context) {
                    //     return AppBottomNavigationBar(
                    //       isStudent: true,
                    //       selectedIndex: 4,
                    //     );
                    //   }));
                    // } else {
                    //   Navigator.of(context).pushReplacement(
                    //       MaterialPageRoute(builder: (context) {
                    //     return AppBottomNavigationBar(
                    //       isStudent: false,
                    //       selectedIndex: 4,
                    //     );
                    //   }));
                    // }
                    // log(token);
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   const SnackBar(content: Text('Processing Data')),
                    // );
                  } catch (e) {
                    throw e;
                  }
                }
              }),
              const SizedBox(height: 30),

              buildSignupSection(context),

              const SizedBox(height: 30),
              buildForgotPassword(context),
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
            const SizedBox(height: 20.0),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
              child: Text(
                'Password',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  // //fontFamily: "GGX88Reg_Light",
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
                hintText: AppLocalizations.of(context)
                    .translate('enter_your_password_hint_text'),
                hintStyle: const TextStyle(
                  //fontFamily: "GGX88Reg_Light",

                  color: Color(0xFFc6c6c6),
                ),
                suffixIcon: IconButton(
                  // color: Color(0xFFc6c6c6),
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
                  return AppLocalizations.of(context)
                      .translate('password_validator_empy_text');
                } else if (value.length < 8) {
                  return AppLocalizations.of(context)
                      .translate('password_validator_invalid_text');
                }
                return null;
              },
            ),
            SizedBox(
              height: 16.0,
            ),
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
            AppLocalizations.of(context).translate('sign_in_text'),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.bottomCenter,
          child: Text(
              AppLocalizations.of(context).translate('dont_have_account_text'),
              style: TextStyle(fontSize: 14)),
        ),
        const SizedBox(width: 5),
        GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) {
              return const SignUpIdentity();
            }));
          },
          child: Text(
            AppLocalizations.of(context).translate('sign_up_text'),
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

  Widget buildForgotPassword(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
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
