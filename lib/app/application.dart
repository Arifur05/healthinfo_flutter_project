import 'package:flutter/material.dart';

import 'core/app_routes.dart';

class Application extends StatelessWidget{
   Application({super.key});
  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return  MaterialApp.router(
      routerConfig: _appRouter.config(),
      debugShowCheckedModeBanner: false,
    );
  }

}