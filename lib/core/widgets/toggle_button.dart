import 'package:flutter/material.dart';

class ToggleButtonsCompany extends StatefulWidget {
  @override
  _ToggleButtonsCompanyState createState() => _ToggleButtonsCompanyState();
}

class _ToggleButtonsCompanyState extends State<ToggleButtonsCompany> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ToggleButtonGroup(
      children: <Widget>[
        ToggleButton(
          text: 'All Projects',
          isSelected: _selectedIndex == 0,
          onPressed: () {
            setState(() {
              _selectedIndex = 0;
            });
          },
        ),
        ToggleButton(
          text: 'Working',
          isSelected: _selectedIndex == 1,
          onPressed: () {
            setState(() {
              _selectedIndex = 1;
            });
          },
        ),
        ToggleButton(
          text: 'Archived',
          isSelected: _selectedIndex == 2,
          onPressed: () {
            setState(() {
              _selectedIndex = 2;
            });
          },
        ),
      ],
    );
  }
}

class ToggleButtonsCompanyDetail extends StatefulWidget {
  @override
  _ToggleButtonsCompanyDetail createState() => _ToggleButtonsCompanyDetail();
}

class _ToggleButtonsCompanyDetail extends State<ToggleButtonsCompanyDetail> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ToggleButtonGroup(
      children: <Widget>[
        ToggleButton(
          text: 'Proposals',
          isSelected: _selectedIndex == 0,
          onPressed: () {
             Navigator.pushNamed(context, '/hire_offer');
            setState(() {
              _selectedIndex = 0;
            });
            
          },
        ),
        ToggleButton(
          text: 'Detail',
          isSelected: _selectedIndex == 1,
          onPressed: () {
             Navigator.pushNamed(context, '/project_detail');
            setState(() {
              _selectedIndex = 1;
            });
            
          },
        ),
        ToggleButton(
          text: 'Message',
          isSelected: _selectedIndex == 2,
          onPressed: () {
            setState(() {
              _selectedIndex = 2;
            });
          },
        ),
        ToggleButton(
          text: 'Hired',
          isSelected: _selectedIndex == 3,
          onPressed: () {
            setState(() {
              _selectedIndex = 3;
            });
          },
        ),
      ],
    );
  }
}

class ToggleButtonGroup extends StatelessWidget {
  final List<Widget> children;

  ToggleButtonGroup({required this.children});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: children.map((child) => Expanded(child: child)).toList(),
    );
  }
}

class ToggleButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;

  ToggleButton(
      {required this.text, required this.isSelected, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      
      style: ButtonStyle(
          backgroundColor:
              isSelected ? MaterialStateProperty.all<Color>(Colors.blue) : null,
          shape: MaterialStateProperty.resolveWith(
            (states) => RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
              side: BorderSide(color: Colors.black, width: 1) // Loại bỏ border radius
            ),
          ),
          padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(3, 5, 5, 3))),
      child: Text(
        text,
        style: TextStyle(color: isSelected ? Colors.white : null),
      ),
    );
  }
}