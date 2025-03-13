import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthinfo_flutter_project/main.dart';

final appointmentsController =
ChangeNotifierProvider((ref) => AppointmentsProvider());

class AppointmentsProvider extends ChangeNotifier {

  int? _currentSelectedIndex;

  void setSelectedIndex({index}){
    _currentSelectedIndex= index;
    notifyListeners();
  }
  int? get getSelectedIndex => _currentSelectedIndex;

  dynamic _selectedDoctorsData;
  dynamic db= FirebaseFirestore.instance;

  void setSelectedDoctorsData({doctorsInfo}){
    _selectedDoctorsData= doctorsInfo;
    notifyListeners();
  }
  dynamic get getSelectedDoctorsData=>_selectedDoctorsData;

  dynamic _selectedDate;
  void setSelectedDate({dateTime}){
    _selectedDate= dateTime;
    notifyListeners();
  }

  dynamic get getSelectedDateTime=> _selectedDate;

  void storeAppointment({required BuildContext context})async{
    dynamic lastBookingID= await box.read("lastBooking_id");
    int bookingID = lastBookingID != null ? lastBookingID +1 : 1;
    dynamic appointmentData={
      'id':bookingID,
      'doctorId': _selectedDoctorsData['id'],
      'doctorName':_selectedDoctorsData['name'],
      'dateTime': _selectedDate
    };

    FirebaseFirestore.instance.collection('appointments').doc().set(appointmentData).then((_)async{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Booking Successfull')));
      await box.write('lastBooking_id', bookingID);
      AutoRouter.of(context).back();

    });
  }
  void cancelAppointment({required bookingId}) async{
    FirebaseFirestore.instance.collection('appointments').doc(bookingId).delete();
  }
}