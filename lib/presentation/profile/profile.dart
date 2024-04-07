import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/profile/profile_company_input.dart';
import 'package:boilerplate/presentation/profile/store/profile_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileStore _profileStore = getIt<ProfileStore>();
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
          child: buildMainContent()),
    ));
  }

  Widget buildMainContent() {
    return Observer(
      builder: (context) {
        return _profileStore.loading
            ? Center(child: CircularProgressIndicator())
            : buildProfileContent();
      },
    );
  }

  Widget buildProfileContent() {
    return Column(
      children: [
        AccountSection(
            title: UserAva(
              name: _profileStore.profile!.fullname,
              company: _profileStore.profile!.student != null
                  ? 'Student'
                  : 'Company',
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
                'Account Setting'),
            children: [
              AccountItem(
                icon: Icons.manage_accounts_sharp,
                title: 'Profile',
                onTap: () {
                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (context) {
                    return const ProfileCompanyInput();
                  }));
                  // Xử lý khi người dùng nhấn vào Profile
                },
              ),
              AccountItem(
                icon: Icons.settings,
                title: 'Settings',
                onTap: () {
                  // Xử lý khi người dùng nhấn vào Settings
                },
              ),
              AccountItem(
                icon: Icons.logout,
                title: 'Logout',
                onTap: () {
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
