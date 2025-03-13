import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthinfo_flutter_project/app/features/book_appointment/view_model/book_appointment_view_model.dart';
import 'package:intl/intl.dart';

@RoutePage()
class AppointmentBookingScreen extends ConsumerWidget {
  const AppointmentBookingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Book Appointment',
            maxLines: 2,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    'Doctor\'s name: ',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(ref
                      .watch(appointmentsController)
                      .getSelectedDoctorsData['name']),
                ],
              ),
              const SizedBox(height: 10,),
              InkWell(
                  onTap: () async{
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(Duration(days: 30))
                    );
                    if(pickedDate != null){
                      final TimeOfDay? time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),

                        initialEntryMode: TimePickerEntryMode.dial,
                        builder: (BuildContext context, Widget? child) {

                          final Widget mediaQueryWrapper = MediaQuery(
                            data: MediaQuery.of(context).copyWith(
                                alwaysUse24HourFormat: false,
                                platformBrightness: Brightness.dark),
                            child: child!,
                          );
                          if (Localizations.localeOf(context).languageCode == 'bn') {
                            return Localizations.override(
                              context: context,
                              locale: const Locale('en', 'US'),
                              child: mediaQueryWrapper,
                            );
                          }
                          return mediaQueryWrapper;
                        },
                      );
                      if (time != null) {
                        String formattedHour = time.hourOfPeriod.toString().padLeft(2, '0');
                        String formattedMinute = time.minute.toString().padLeft(2, '0');
                        String period = time.period == DayPeriod.am ? 'AM' : 'PM';

                        String dateTimeFormat = "${pickedDate.year}-${pickedDate.month}-${pickedDate.day} $formattedHour:$formattedMinute $period";

                        DateTime combinedDateTime = DateFormat('yyyy-MM-dd hh:mm a').parse(dateTimeFormat);

                        String formattedDate = DateFormat('yyyy-MM-dd hh:mm a').format(combinedDateTime);
                        ref.watch(appointmentsController).setSelectedDate(dateTime: "${formattedDate}");

                      }

                    }
                  },
                  child: TextFormField(
                    decoration:
                         InputDecoration(hintText: ref.watch(appointmentsController).getSelectedDateTime!= null? ref.watch(appointmentsController).getSelectedDateTime: 'Date & Time', enabled: false, disabledBorder: OutlineInputBorder()),
                  )),
              const SizedBox(height: 10,),
              MaterialButton(onPressed: (){
                ref.watch(appointmentsController).storeAppointment(context: context);

              }, child: const Text('Book Appointment', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),),),

              // StreamBuilder(
              //     stream: FirebaseFirestore.instance.collection('appointments').snapshots(),
              //     builder: (context, AsyncSnapshot snapshot) {
              //       return ListView.builder(shrinkWrap: true,itemBuilder: (context, index){
              //         return Text('ABc');
              //       });
              // }),

            ],
          ),
        ),
      ),
    );
  }
}
