import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final doctorsController =
ChangeNotifierProvider((ref) => DoctorsProvider());

class DoctorsProvider extends ChangeNotifier {

  int? _currentSelectedIndex;

  void setSelectedIndex({index}){
    _currentSelectedIndex= index;
    notifyListeners();
  }
  int? get getSelectedIndex => _currentSelectedIndex;

}