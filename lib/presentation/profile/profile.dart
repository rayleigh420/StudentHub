import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/domain/usecase/auth/studenthub_logout_usecase.dart';
import 'package:boilerplate/presentation/browse_project/store/project_company_store.dart';
import 'package:boilerplate/presentation/browse_project/store/project_store.dart';
import 'package:boilerplate/presentation/chat/store/current_message_store.dart';
import 'package:boilerplate/presentation/chat/store/message_store.dart';
import 'package:boilerplate/presentation/chat/store/notification_store.dart';
import 'package:boilerplate/presentation/home/store/language/language_store.dart';
import 'package:boilerplate/presentation/home/store/theme/theme_store.dart';
import 'package:boilerplate/presentation/input_login/input_login.dart';
import 'package:boilerplate/presentation/navigations/tab_store.dart';
import 'package:boilerplate/presentation/profile_input/company/profile_company_input.dart';
import 'package:boilerplate/presentation/profile/store/profile_store.dart';
import 'package:boilerplate/presentation/profile_input/student/profile_input_1.dart';
import 'package:boilerplate/presentation/user/change_password.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final StudentHubLogoutUC _studentHubLogoutUC = getIt<StudentHubLogoutUC>();
  final ProfileStore _profileStore = getIt<ProfileStore>();
  final TabStore _tabStore = getIt<TabStore>();
  final ProjectStore _projectStore = getIt<ProjectStore>();
  final MessageStore _messageStore = getIt<MessageStore>();
  final ProjectCompanyStore _projectCompanyStore = getIt<ProjectCompanyStore>();
  final NotificationStore _notificationStore = getIt<NotificationStore>();
  final CurrentMessageStore _currentMessageStore = getIt<CurrentMessageStore>();
  final LanguageStore _languageStore = getIt<LanguageStore>();
  final ThemeStore _themeStore = getIt<ThemeStore>();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // check to see if already called api
    if (!_profileStore.loading) {
      _profileStore.getProfile();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('StudentHub'),
      ),
      body: Container(
          padding: EdgeInsets.fromLTRB(18, 10, 20, 0),
          child: buildMainContent(context)),
    ));
  }

  Widget buildMainContent(BuildContext context) {
    return Observer(
      builder: (context) {
        return _profileStore.loading
            ? Center(child: CircularProgressIndicator())
            : buildProfileContent(context);
      },
    );
  }

  Widget buildProfileContent(BuildContext context) {
    return Column(
      children: [
        AccountSection(
            title: UserAva(
              name: _profileStore.profile!.fullname,
              company:
                  _profileStore.profile!.roles[0] == 0 ? 'Student' : 'Company',
            ),
            children: [
              // Container(
              //   margin: EdgeInsets.only(left: 20),
              //   child: UserAva(
              //     name: "Nhat Duy",
              //     company: 'Student',
              //   ),
              // ),
            ]),
        AccountSection(
            title: Text(
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                AppLocalizations.of(context)
                    .translate('account_settings_text')),
            children: [
              AccountItem(
                icon: Icons.manage_accounts_sharp,
                title: AppLocalizations.of(context).translate('profile_text'),
                onTap: () {
                  if (_profileStore.profile!.roles[0] == 1) {
                    Navigator.of(context, rootNavigator: false).push(
                        MaterialPageRoute(
                            builder: (context) => ProfileCompanyInput(),
                            maintainState: false));
                  } else {
                    Navigator.of(context, rootNavigator: false).push(
                        MaterialPageRoute(
                            builder: (context) => ProfileInput1(),
                            maintainState: false));
                  }

                  // Navigator.of(context)
                  //     .pushReplacement(MaterialPageRoute(builder: (context) {
                  //   return const ProfileCompanyInput();
                  // }));
                  // Xử lý khi người dùng nhấn vào Profile
                },
              ),
              AccountSection(
                  title: ListTile(
                    contentPadding: EdgeInsets.only(left: 3),
                    leading: Icon(
                      Icons.settings,
                      size: 25,
                    ),
                    title: Text(
                        style: TextStyle(fontSize: 16),
                        AppLocalizations.of(context)
                            .translate('settings_text')),
                    onTap: null,
                  ),
                  children: [
                    ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      onTap: () {
                        if (_languageStore.locale == "en") {
                          _languageStore.changeLanguage("vi");
                        } else {
                          _languageStore.changeLanguage("en");
                        }
                      },
                      title: Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 30),
                          child: Text(
                            "${AppLocalizations.of(context).translate("change_language_text")} ${_languageStore.locale == "en" ? AppLocalizations.of(context).translate("vietnamese_text") : AppLocalizations.of(context).translate("english_text")}",
                            style: TextStyle(fontSize: 16),
                          )),
                    ),
                    ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      onTap: () {
                        if (_themeStore.darkMode == true) {
                          _themeStore.changeBrightnessToDark(false);
                        } else {
                          _themeStore.changeBrightnessToDark(true);
                        }
                      },
                      title: Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 30),
                          child: Text(
                            "${AppLocalizations.of(context).translate("switch_to_text")} ${_themeStore.darkMode == true ? AppLocalizations.of(context).translate("light_mode_text") : AppLocalizations.of(context).translate("dark_mode_text")}",
                            style: TextStyle(fontSize: 16),
                          )),
                    )
                    // Container(
                    //   margin: EdgeInsets.only(left: 20),
                    //   child: UserAva(
                    //     name: "Nhat Duy",
                    //     company: 'Student',
                    //   ),
                    // ),
                  ]),
              AccountItem(
                icon: Icons.password,
                title: AppLocalizations.of(context)
                    .translate('change_password_text'),
                onTap: () {
                  Navigator.of(context, rootNavigator: false).push(
                      MaterialPageRoute(
                          builder: (context) => ChangePassword(),
                          maintainState: false));
                  ;
                  // Navigator.of(context, rootNavigator: true)
                  //     .pushReplacement(MaterialPageRoute(builder: (context) {
                  //   return InputLogin();
                  // }));
                  // Xử lý khi người dùng nhấn vào Logout
                },
              ),
              AccountItem(
                icon: Icons.logout,
                title: AppLocalizations.of(context).translate('logout_text'),
                onTap: () {
                  _studentHubLogoutUC.call(params: null);
                  _projectStore.clearStoreData();
                  _projectCompanyStore.clearStoreData();
                  _currentMessageStore.clearMessageListItem();
                  _messageStore.clearStoreData();
                  _notificationStore.clearStoreData();
                  _tabStore.setTabIndex(1);
                  Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => InputLogin()),
                      (Route<dynamic> route) => false);
                  ;
                  // Navigator.of(context, rootNavigator: true)
                  //     .pushReplacement(MaterialPageRoute(builder: (context) {
                  //   return InputLogin();
                  // }));
                  // Xử lý khi người dùng nhấn vào Logout
                },
              ),
            ])
      ],
    );
  }
}

class UserAva extends StatelessWidget {
  final String name;
  final String company;
  // final List<Widget> children;

  const UserAva({required this.name, required this.company});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.account_circle,
          size: 30,
        ),
        SizedBox(
          width: 15,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                this.name),
            Text(this.company)
          ],
        )
      ],
    );
  }
}

class AccountSection extends StatelessWidget {
  final Widget title;
  final List<Widget> children;

  const AccountSection({
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.only(left: 10),
      title: title,
      children: children,
      initiallyExpanded: true,
    );
  }
}

class AccountItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const AccountItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        size: 25,
      ),
      title: Text(style: TextStyle(fontSize: 16), title),
      onTap: onTap,
    );
  }
}
