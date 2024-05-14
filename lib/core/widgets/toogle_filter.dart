import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';

class FilterButtons extends StatefulWidget {
  @override
  _FilterButtonsState createState() => _FilterButtonsState();
}

class _FilterButtonsState extends State<FilterButtons> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ToggleButtonGroup(
      children: <Widget>[
        ToggleButton(
          text: AppLocalizations.of(context).translate('all_projects_text'),
          isSelected: _selectedIndex == 0,
          onPressed: () {
            setState(() {
              _selectedIndex = 0;
            });
          },
        ),
        ToggleButton(
          text: AppLocalizations.of(context).translate('working_text'),
          isSelected: _selectedIndex == 1,
          onPressed: () {
            setState(() {
              _selectedIndex = 1;
            });
          },
        ),
        ToggleButton(
          text: AppLocalizations.of(context).translate('archived_text'),
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
              borderRadius: BorderRadius.zero, // Loại bỏ border radius
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
