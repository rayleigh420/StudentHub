// import 'package:boilerplate/presentation/alert/alert.dart';
// import 'package:boilerplate/presentation/browse_project/browse_project_main.dart';
// import 'package:boilerplate/presentation/dashboard/dashboard_company.dart';
// import 'package:boilerplate/presentation/dashboard/dashboard_student.dart';
// import 'package:boilerplate/presentation/home/home.dart';
// import 'package:boilerplate/presentation/login/login.dart';
// import 'package:boilerplate/presentation/message/message.dart';
// import 'package:boilerplate/presentation/profile/profile.dart';
// import 'package:boilerplate/presentation/project/project.dart';
// import 'package:boilerplate/utils/locale/app_localization.dart';
// import 'package:flutter/material.dart';

// class AppBottomNavigationBar extends StatefulWidget {
//   @override
//   _AppBottomNavigationBarState createState() => _AppBottomNavigationBarState();
// }

// class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
//   int _selectedIndex = 2;

//   static List<Widget> _widgetOptions = <Widget>[
//     ProjectScreen(),
//     MessageScreen(),
//     true ? DashboardStudentScreen() : DashboardCompanyScreen(),
//     AlerttScreen(),
//     ProfileScreen()
//     // DashboardScreen(),
//     // ProfileScreen(),
//     // HomeScreen(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   PreferredSizeWidget _buildAppBar() {
//     return AppBar(
//       title: Text('StudentHub'),
//       // actions: _buildActions(context),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: _buildAppBar(),
//       body: SafeArea(child: _widgetOptions.elementAt(_selectedIndex)),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.file_copy),
//             label: 'Project',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.message),
//             label: 'Message',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.dashboard),
//             label: 'Dashboard',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.notifications),
//             label: 'Alert',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.supervisor_account_outlined),
//             label: 'Profile',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         // selectedItemColor: Colors.blue,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }
import 'dart:developer';

import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/alert/alert.dart';
import 'package:boilerplate/presentation/browse_project/browse_project_main.dart';
import 'package:boilerplate/presentation/chat/message_list.dart';
import 'package:boilerplate/presentation/dashboard/dashboard_company.dart';
import 'package:boilerplate/presentation/dashboard/dashboard_student.dart';
import 'package:boilerplate/presentation/home/home.dart';
import 'package:boilerplate/presentation/login/login.dart';
import 'package:boilerplate/presentation/meeting/meeting.dart';
import 'package:boilerplate/presentation/message/message.dart';
import 'package:boilerplate/presentation/notification/noti_list.dart';
import 'package:boilerplate/presentation/profile/profile.dart';
import 'package:boilerplate/presentation/project/project.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBottomNavigationBar extends StatefulWidget {
  final int selectedIndex;
  final bool isStudent;

  AppBottomNavigationBar(
      {required this.selectedIndex, required this.isStudent});
  @override
  _AppBottomNavigationBarState createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  int _selectedIndex = 0;
  bool _isStudent = false;
  static List<Widget> _widgetOptions = [];

  @override
  void initState() {
    super.initState();
    // testRole();
    _isStudent = widget.isStudent;
    _selectedIndex = widget.selectedIndex;
    _widgetOptions = <Widget>[
      BrowseProjectScreen(),
      // MeetingScreen(),
      MessageList(),
      widget.isStudent ? DashboardStudentScreen() : DashboardCompanyScreen(),
      // DashboardStudentScreen(),
      NotiList(),
      ProfileScreen()
      // DashboardScreen(),
      // ProfileScreen(),
      // HomeScreen(),
    ];
  }

  // void testRole() async {
  //   List<int>? roles = await getIt<SharedPreferenceHelper>().roles;

  //   // int? currentCompanyId =
  //   //     await getIt<SharedPreferenceHelper>().currentCompanyId;

  //   int? currentStudentId =
  //       await getIt<SharedPreferenceHelper>().currentStudentId;

  //   print("roles from tab: ${roles![0]}");
  //   // print("currentCompanyId: $currentCompanyId");
  //   print("currentStudentId: $currentStudentId");
  // }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      // appBar: _buildAppBar(),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          onGenerateRoute: (settings) {
            return MaterialPageRoute(
              builder: (context) => _widgetOptions.elementAt(index),
            );
          },
          builder: (BuildContext context) {
            return SafeArea(
              top: false,
              bottom: false,
              child: _widgetOptions.elementAt(index),
            );
          },
        );
      },
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.file_copy),
            label: 'Project',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Message',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Alert',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.supervisor_account_outlined),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        // selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
