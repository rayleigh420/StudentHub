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
import 'package:boilerplate/presentation/browse_project/store/project_store.dart';
import 'package:boilerplate/presentation/chat/store/message_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'dart:async';

import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/network/socket_client.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/alert/alert.dart';
import 'package:boilerplate/presentation/browse_project/browse_project_main.dart';
import 'package:boilerplate/presentation/chat/message_list.dart';
import 'package:boilerplate/presentation/dashboard/dashboard_company.dart';
import 'package:boilerplate/presentation/dashboard/dashboard_student.dart';
import 'package:boilerplate/presentation/home/home.dart';
import 'package:boilerplate/presentation/input_login/input_login.dart';
import 'package:boilerplate/presentation/login/login.dart';
import 'package:boilerplate/presentation/meeting/meeting.dart';
import 'package:boilerplate/presentation/message/message.dart';
import 'package:boilerplate/presentation/notification/noti_list.dart';
import 'package:boilerplate/presentation/profile/profile.dart';
import 'package:boilerplate/presentation/profile/store/profile_store.dart';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBottomNavigationBar extends StatefulWidget {
  final int selectedIndex;

  AppBottomNavigationBar({required this.selectedIndex});
  @override
  _AppBottomNavigationBarState createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  int _selectedIndex = 0;
  final MessageStore _messageStore = getIt<MessageStore>();
  final ProfileStore _profileStore = getIt<ProfileStore>();
  final ProjectStore _projectStore = getIt<ProjectStore>();

  static List<Widget> _widgetOptions = <Widget>[
    BrowseProjectScreen(),
    MessageList(),
    DashboardStudentScreen(),
    NotiList(),
    ProfileScreen()
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkAuthToken();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_messageStore.loading == false) {
      _messageStore.getMessages();
    }
  }

  void checkAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? authToken = prefs.getString('authToken');
    if (authToken == null) {
      @override
      void run() {
        scheduleMicrotask(() {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => InputLogin()),
          );
        });
      }

      run();
    } else {
      final jwt = JWT.decode(authToken);
      // socketClient.setToken(authToken);
      // socketClient.connect(Endpoints.baseUrl, authToken);

      print('Payload: ${jwt.payload}');
      print('roles: ${jwt.payload['roles'][0]}');
      // return jwt.payload['roles'][0];
      int roleString = jwt.payload['roles'][0];
      // int role = int.parse(roleString);
      print(roleString);
      setState(() {
        _widgetOptions = <Widget>[
          BrowseProjectScreen(),
          MessageList(),
          roleString == 0 ? DashboardStudentScreen() : DashboardCompanyScreen(),
          NotiList(),
          ProfileScreen()
        ];
      });

      // if (_projectStore.loading == false) {
      //   _projectStore.getProjects();
      // }
      // if (_profileStore.loading == false) {
      //   _profileStore.getProfile();
      // }
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return !_messageStore.success
            ? Center(child: CupertinoActivityIndicator())
            : CupertinoTabScaffold(
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
        // return _messageStore.loading ||
        //         _profileStore.loading ||
        //         _projectStore.loading
        //     ? Center(child: CupertinoActivityIndicator())
        //     : CupertinoTabScaffold(
        //         // appBar: _buildAppBar(),
        //         tabBuilder: (BuildContext context, int index) {
        //           return CupertinoTabView(
        //             onGenerateRoute: (settings) {
        //               return MaterialPageRoute(
        //                 builder: (context) => _widgetOptions.elementAt(index),
        //               );
        //             },
        //             builder: (BuildContext context) {
        //               return SafeArea(
        //                 top: false,
        //                 bottom: false,
        //                 child: _widgetOptions.elementAt(index),
        //               );
        //             },
        //           );
        //         },
        //         tabBar: CupertinoTabBar(
        //           items: const <BottomNavigationBarItem>[
        //             BottomNavigationBarItem(
        //               icon: Icon(Icons.file_copy),
        //               label: 'Project',
        //             ),
        //             BottomNavigationBarItem(
        //               icon: Icon(Icons.message),
        //               label: 'Message',
        //             ),
        //             BottomNavigationBarItem(
        //               icon: Icon(Icons.dashboard),
        //               label: 'Dashboard',
        //             ),
        //             BottomNavigationBarItem(
        //               icon: Icon(Icons.notifications),
        //               label: 'Alert',
        //             ),
        //             BottomNavigationBarItem(
        //               icon: Icon(Icons.supervisor_account_outlined),
        //               label: 'Profile',
        //             ),
        //           ],
        //           currentIndex: _selectedIndex,
        //           // selectedItemColor: Colors.blue,
        //           onTap: _onItemTapped,
        //         ),
        //       );
      },
    );
  }
}
