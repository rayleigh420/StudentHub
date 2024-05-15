import 'dart:developer';

import 'package:boilerplate/di/service_locator.dart';

import 'package:boilerplate/domain/usecase/auth/studenthub_signup_usecase.dart';
import 'package:boilerplate/presentation/home/store/theme/theme_store.dart';
import 'package:boilerplate/presentation/signup/input_signup/verify_screen.dart';

import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/utils/strings/email_validate.dart';
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
  final _inputFormKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    // _themeStore.changeBrightnessToDark(true);
    textColor = _themeStore.darkMode ? Colors.white : Color(0xFF6e6e6e);
  }

  Future<bool> signUp(
      String email, String password, String fullName, int role) async {
    try {
      final response = await _authRepository.call(
          params: SignUpParams(
              email: email,
              password: password,
              fullName: fullName,
              role: role));
      log(response.toString());
      return response;
    } catch (e) {
      log(e.toString());
      throw e;
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
                '${AppLocalizations.of(context).translate('sign_up_as_text')} ${(widget.type == 1) ? AppLocalizations.of(context).translate('company_text') : AppLocalizations.of(context).translate('student_text')}',
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
                if (_inputFormKey.currentState!.validate() && _agreeToApply) {
                  try {
                    final res = await signUp(
                        _emailController.text,
                        _passwordController.text,
                        _fullNameController.text,
                        widget.type);
                    log(res.toString());
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: (context) {
                      return VerifyScreen();
                    }));
                  } catch (e) {
                    throw e;
                  }
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
      key: _inputFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
            child: Text(
              AppLocalizations.of(context).translate('full_name_text'),
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
              border: OutlineInputBorder(borderSide: BorderSide.none),
              hintText:
                  AppLocalizations.of(context).translate('full_name_hint_text'),
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
              border: OutlineInputBorder(borderSide: BorderSide.none),
              hintText: AppLocalizations.of(context)
                  .translate('enter_your_email_hint_text'),
              hintStyle: TextStyle(
                //fontFamily: "GGX88Reg_Light",
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
              hintText: AppLocalizations.of(context)
                  .translate('enter_your_password_hint_text'),
              hintStyle: const TextStyle(
                //fontFamily: "GGX88Reg_Light",
                color: Color(0xFFc6c6c6),
              ),
              errorStyle: TextStyle(
                // fontFamily: "GGX88Reg_Light",
                fontSize: 14,
                color: Color(0xFFD74638),
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
                    AppLocalizations.of(context).translate('compromise_text'),
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
          onPressed: () => onPress(),
          child: Text(
            AppLocalizations.of(context).translate('create_account_text'),
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
            child: Text(AppLocalizations.of(context)
                .translate('looking_for_project_text')),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) {
                return InputSignUp(
                  type: (widget.type == 1) ? 0 : 1,
                );
              }));
            },
            child: Text(
              " ${AppLocalizations.of(context).translate('apply_as_text')} ${(widget.type == 1) ? AppLocalizations.of(context).translate('company_text') : AppLocalizations.of(context).translate('student_text')}",
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
