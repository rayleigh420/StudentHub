import 'package:boilerplate/presentation/alert/alert.dart';
import 'package:boilerplate/presentation/dashboard/dashboard.dart';
import 'package:boilerplate/presentation/home/home.dart';
import 'package:boilerplate/presentation/login/login.dart';
import 'package:boilerplate/presentation/message/message.dart';
import 'package:boilerplate/presentation/profile/profile.dart';
import 'package:boilerplate/presentation/project/project.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';

class AppBottomNavigationBar extends StatefulWidget {
  @override
  _AppBottomNavigationBarState createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  int _selectedIndex = 4;

  static List<Widget>   _widgetOptions = <Widget>[
    ProjectScreen(
      isNew: true,
    ),
    MessageScreen(),
    DashBoardScreen(),
    AlerttScreen(),
    ProfileScreen()
    // DashboardScreen(),
    // ProfileScreen(),
    // HomeScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text('StudentHub'),
      // actions: _buildActions(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
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
