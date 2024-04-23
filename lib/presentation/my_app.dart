import 'package:boilerplate/constants/app_theme.dart';
import 'package:boilerplate/constants/strings.dart';
import 'package:boilerplate/presentation/browse_project/browse_project_main.dart';
import 'package:boilerplate/presentation/home/home.dart';
import 'package:boilerplate/presentation/home/store/language/language_store.dart';
import 'package:boilerplate/presentation/home/store/theme/theme_store.dart';
import 'package:boilerplate/presentation/input_login/input_login.dart';
import 'package:boilerplate/presentation/login/login.dart';
import 'package:boilerplate/presentation/login/store/login_store.dart';
import 'package:boilerplate/presentation/navigations/bottomNavigationBar.dart';
import 'package:boilerplate/presentation/profile/profile.dart';
import 'package:boilerplate/presentation/profile_input/student/profile_input_1.dart';
import 'package:boilerplate/presentation/profile_input/student/profile_input_2.dart';
import 'package:boilerplate/presentation/project/company/project_post_1.dart';
import 'package:boilerplate/presentation/project/company/project_post_2.dart';
import 'package:boilerplate/presentation/project/company/project_post_3.dart';
import 'package:boilerplate/presentation/project/company/project_post_4.dart';
import 'package:boilerplate/presentation/search_project_screen/search_project_screen.dart';
import 'package:boilerplate/presentation/signup/identity_signup/identity_signup.dart';
import 'package:boilerplate/presentation/signup/input_signup/input_signup.dart';
import 'package:boilerplate/presentation/signup/input_signup/verify_screen.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../di/service_locator.dart';
import 'package:boilerplate/presentation/profile_input/company/profile_company_input.dart';
import 'package:boilerplate/presentation/welcome/welcome_company.dart';
import 'package:boilerplate/presentation/profile_input/company/profile_company_input_account.dart';
import 'package:boilerplate/presentation/profile_input/student/resume_upload.dart';
// import 'package:boilerplate/presentation/companyReview/companyDashboard.dart';
import 'package:boilerplate/presentation/companyReview/project_detail.dart';
import 'package:boilerplate/presentation/companyReview/hire_offer.dart';
import 'package:boilerplate/presentation/chat/message_list.dart';
import 'package:boilerplate/presentation/chat/message_detail.dart';
import 'package:boilerplate/presentation/notification/noti_list.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // Create your store as a final variable in a base Widget. This works better
  // with Hot Reload than creating it directly in the `build` function.
  final ThemeStore _themeStore = getIt<ThemeStore>();
  final LanguageStore _languageStore = getIt<LanguageStore>();
  final UserStore _userStore = getIt<UserStore>();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: Strings.appName,
          // theme: AppThemeData.darkThemeData,
          theme: _themeStore.darkMode
              ? AppThemeData.darkThemeData
              : AppThemeData.lightThemeData,
          routes: Routes.routes,
          locale: Locale(_languageStore.locale),
          supportedLocales: _languageStore.supportedLanguages
              .map((language) => Locale(language.locale, language.code))
              .toList(),
          localizationsDelegates: [
            // A class which loads the translations from JSON files
            AppLocalizations.delegate,
            // Built-in localization of basic text for Material widgets
            GlobalMaterialLocalizations.delegate,
            // Built-in localization for text direction LTR/RTL
            GlobalWidgetsLocalizations.delegate,
            // Built-in localization of basic text for Cupertino widgets
            GlobalCupertinoLocalizations.delegate,
          ],
          home: AppBottomNavigationBar(
            selectedIndex: 1,
            // isStudent: true,
          ),
          
        );
      },
    );
  }
}
