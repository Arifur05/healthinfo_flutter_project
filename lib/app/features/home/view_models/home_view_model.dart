import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeScreenController =
ChangeNotifierProvider((ref) => homeScreenProvider());

class homeScreenProvider extends ChangeNotifier {

  int? _currentSelectedIndex;

  void setSelectedIndex({index}){
    _currentSelectedIndex= index;
    notifyListeners();
  }
  int? get getSelectedIndex => _currentSelectedIndex;

}