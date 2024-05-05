import 'dart:developer';
// import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/domain/usecase/auth/change_password_usecase.dart';
import 'package:boilerplate/domain/usecase/auth/studenthub_login_usecase.dart';
import 'package:boilerplate/domain/usecase/profile/get_profile_uc.dart';
import 'package:boilerplate/presentation/home/store/theme/theme_store.dart';
import 'package:boilerplate/presentation/navigations/bottomNavigationBar.dart';
import 'package:boilerplate/presentation/signup/identity_signup/identity_signup.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/utils/strings/email_validate.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool _loginFail = false;
  String _loginFailText = '';

  bool _showOldPassword = false;
  bool _showNewPassword = false;
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();

  final StudentHubLoginUC _authRepository = getIt<StudentHubLoginUC>();
  final ChangePasswordUC _changePasswordUC = getIt<ChangePasswordUC>();
  //------
  final ThemeStore _themeStore = getIt<ThemeStore>();
  final _formKey = GlobalKey<FormState>();

  final GetProfileUseCase _getProfileUseCase = getIt<GetProfileUseCase>();

  Future<bool> handleChangePassword(
      String oldPassword, String newPassword) async {
    try {
      bool result = await _changePasswordUC.call(
          params: ChangePasswordParams(
              oldPassword: oldPassword, newPassword: newPassword));
      log(result.toString());

      return result;
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

  @override
  Widget build(BuildContext context) {
    print("Building ChangePassword");
    // print(_themeStore.darkMode);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)
            .translate('change_password_title_text')),
        // actions: [
        //   IconButton(
        //     icon: Icon(
        //         _themeStore.darkMode ? Icons.person_2 : Icons.person_2_rounded),
        //     onPressed: () {
        //       _themeStore.changeBrightnessToDark(!_themeStore.darkMode);
        //     },
        //   )
        // ],
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
                    .translate('add_your_old_password_and_new_text'),
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
                    bool result = await handleChangePassword(
                        _oldPasswordController.text,
                        _newPasswordController.text);
                    if (result) {
                      Navigator.of(context).pop();
                    }
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
            const SizedBox(height: 20.0),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
              child: Text(
                AppLocalizations.of(context).translate('old_password_text'),
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
              controller: _oldPasswordController,
              obscureText: !_showOldPassword,
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
                    .translate('enter_your_old_password_hint_text'),
                hintStyle: const TextStyle(
                  //fontFamily: "GGX88Reg_Light",

                  color: Color(0xFFc6c6c6),
                ),
                suffixIcon: IconButton(
                  // color: Color(0xFFc6c6c6),
                  icon: Icon(
                    _showOldPassword ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _showOldPassword = !_showOldPassword;
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
                      .translate('old_password_validator_empy_text');
                } else if (value.length < 8) {
                  return AppLocalizations.of(context)
                      .translate('old_password_validator_invalid_text');
                }
                return null;
              },
            ),
            SizedBox(
              height: 16.0,
            ),
            const SizedBox(height: 20.0),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
              child: Text(
                AppLocalizations.of(context).translate('new_password_text'),
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
              controller: _newPasswordController,
              obscureText: !_showNewPassword,
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
                    .translate('enter_your_new_password_hint_text'),
                hintStyle: const TextStyle(
                  //fontFamily: "GGX88Reg_Light",

                  color: Color(0xFFc6c6c6),
                ),
                suffixIcon: IconButton(
                  // color: Color(0xFFc6c6c6),
                  icon: Icon(
                    _showNewPassword ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _showNewPassword = !_showNewPassword;
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
                      .translate('new_password_validator_empy_text');
                } else if (value.length < 8) {
                  return AppLocalizations.of(context)
                      .translate('new_password_validator_invalid_text');
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
            AppLocalizations.of(context).translate('change_password_text'),
            style: TextStyle(
              fontSize: 16,
              //fontFamily: "GGX88Reg",
              fontWeight: FontWeight.w600,
              // color: Colors.black,
            ),
          ),
        ));
  }
}
