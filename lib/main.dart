import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:healthinfo_flutter_project/app/application.dart';

import 'firebase_options.dart';
late GetStorage box;

void main() async{
  await GetStorage.init();
  box = GetStorage();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( ProviderScope(child: Application()));
}

