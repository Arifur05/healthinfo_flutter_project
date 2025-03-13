import 'package:auto_route/auto_route.dart';
import 'package:healthinfo_flutter_project/app/features/book_appointment/views/appointment_book_screen.dart';
import 'package:healthinfo_flutter_project/app/features/book_appointment/views/appointment_list_screen.dart';

import 'app_routes.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Page|Screen,Route',
)
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes =>
      [
        CustomRoute(page: HomeRoute.page, path: '/', initial: true,),
        CustomRoute(page: AppointmentBookingRoute.page, path: '/appointment_book', ),
        CustomRoute(page: AppointmentListRoute.page, path: '/appointments', ),
      ];
}