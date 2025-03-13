import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healthinfo_flutter_project/app/core/app_routes.gr.dart';
import 'package:healthinfo_flutter_project/app/features/home/view_models/home_view_model.dart';

import '../../book_appointment/view_model/book_appointment_view_model.dart';

@RoutePage()
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar  (
          centerTitle: true,
          title:const Text("Doctors List", style:  TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
          actions: [
            Row(
              children: [

                InkWell(
                    onTap: (){

                      context.router.push(AppointmentListRoute());
                    },
                    child: Icon(Icons.list)),
              ],
            ),
          ],
        ),

        body: Column(
          children: [
            Card(
              color: Colors.white24,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: SizedBox()),
                    Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: Text("Name")),
                    Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: Text("Specialization")),
                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: Text('Availability'),
                    ),
                  ],
                ),
              ),
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance.collection('doctors').snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: (){ref.watch(homeScreenController).setSelectedIndex(index: index);},
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Flexible(
                                            flex: 1,
                                            fit: FlexFit.tight,
                                            child: Icon(Icons.person_2_rounded)),
                                        Flexible(
                                            flex: 2,
                                            fit: FlexFit.tight,
                                            child: Text(snapshot.data.docs[index]['name'])),
                                        Flexible(
                                            flex: 2,
                                            fit: FlexFit.tight,
                                            child: Text(snapshot.data.docs[index]
                                                ['specialization'])),
                                        Flexible(
                                          flex: 2,
                                          fit: FlexFit.tight,
                                          child: Text(snapshot.data.docs[index]
                                                      ['availability'] ==
                                                  false
                                              ? 'Not Available'
                                              : 'Available'),
                                        ),
                                      ],
                                    ),
                                    ref.watch(homeScreenController).getSelectedIndex== index?
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        MaterialButton(
                                          color: Colors.blue.withOpacity(.7),
                                          onPressed: (){
                                          ref.watch(appointmentsController).setSelectedDoctorsData(doctorsInfo:  snapshot.data.docs[index]);
                                          context.router.push(AppointmentBookingRoute());
                                        },
                                        child: Text("Book Appointment"),)
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
                      child: Text('No Doctors Found'),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
