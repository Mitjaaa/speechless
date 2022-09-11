import 'package:flutter/material.dart';

class NavigationIndex with ChangeNotifier {
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  void set(int newIndex) {
    _selectedIndex = newIndex;
    notifyListeners();
  }
}