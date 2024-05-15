import 'package:boilerplate/presentation/input_login/input_login.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgotPasswordContScreen extends StatefulWidget {
  const ForgotPasswordContScreen({super.key});

  @override
  State<ForgotPasswordContScreen> createState() =>
      _ForgotPasswordContScreenState();
}

class _ForgotPasswordContScreenState extends State<ForgotPasswordContScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title:
            Text(AppLocalizations.of(context).translate('verify_email_text')),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                AppLocalizations.of(context)
                    .translate('please_check_email_text'),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                AppLocalizations.of(context)
                    .translate('please_check_email_description_text'),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 40,
              width: 300,
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.blueAccent),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                  ),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true)
                        .pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => InputLogin()),
                            (Route<dynamic> route) => false);
                  },
                  child: Text(
                    AppLocalizations.of(context)
                        .translate('redirect_to_gmail_text'),
                    style: TextStyle(color: Colors.white),
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 40,
              width: 300,
              child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: (context) {
                      return InputLogin();
                    }));
                  },
                  child: Text(AppLocalizations.of(context)
                      .translate('back_to_login_text'))),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    ));
  }
}
