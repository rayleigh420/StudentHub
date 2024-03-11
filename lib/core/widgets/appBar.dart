import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarItem extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('StudentHub'),
      // actions: _buildActions(context),
    );
  }
}
