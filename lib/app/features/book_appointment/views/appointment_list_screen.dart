import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthinfo_flutter_project/app/features/book_appointment/view_model/book_appointment_view_model.dart';

import '../../home/view_models/home_view_model.dart';

@RoutePage()
class AppointmentListScreen extends ConsumerWidget{
  const AppointmentListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar  (
        centerTitle: true,
        title: Text("Appointments", style:  TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
      ),

      body: Column(
        children: [
          const Card(
            color: Colors.white24,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: Text("Appointment ID", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),)),
                  Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: Text("Doctor\'s name", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),)),
                  Flexible(
                    flex: 2,
                    fit: FlexFit.tight,
                    child: Text('Appointment Date & Time', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                  ),
                ],
              ),
            ),
          ),
          StreamBuilder(
              stream: FirebaseFirestore.instance.collection('appointments').snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                            ref.watch(appointmentsController).setSelectedIndex(index: index);
                          },
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Flexible(
                                          flex: 2,
                                          fit: FlexFit.tight,
                                          child: Text(snapshot.data.docs[index]['id'].toString())),
                                      Flexible(
                                          flex: 2,
                                          fit: FlexFit.tight,
                                          child: Text(snapshot.data.docs[index]
                                          ['doctorName'])),
                                      Flexible(
                                        flex: 2,
                                        fit: FlexFit.tight,
                                        child: Text(snapshot.data.docs[index]
                                        ['dateTime']),
                                      ),
                                    ],
                                  ),
                                  ref.watch(appointmentsController).getSelectedIndex== index?
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      MaterialButton(
                                        color: Colors.red.withOpacity(.7),
                                        onPressed: (){

                                            ref.watch(appointmentsController).cancelAppointment(bookingId: snapshot.data.docs[index].id);
                                        },
                                        child: Text("Cancel Appointment"),)
                                    ],
                                  ): SizedBox()
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                } else {
                  return const Center(
                    child: Text('No Appointments Found'),
                  );
                }
              }),
        ],
      ),
    );
  }

}