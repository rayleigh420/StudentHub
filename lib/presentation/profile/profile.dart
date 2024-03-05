import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(18, 10, 20, 0),
        child: Column(
          children: [
            AccountSection(
                title: UserAva(
                  name: "Duy Le",
                  company: 'Company',
                ),
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: UserAva(
                      name: "Nhat Duy",
                      company: 'Student',
                    ),
                  ),
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
        ));
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
