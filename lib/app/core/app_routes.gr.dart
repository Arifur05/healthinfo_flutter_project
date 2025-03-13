// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:healthinfo_flutter_project/app/features/book_appointment/views/appointment_book_screen.dart'
    as _i1;
import 'package:healthinfo_flutter_project/app/features/book_appointment/views/appointment_list_screen.dart'
    as _i2;
import 'package:healthinfo_flutter_project/app/features/home/views/home_screen.dart'
    as _i3;

/// generated route for
/// [_i1.AppointmentBookingScreen]
class AppointmentBookingRoute extends _i4.PageRouteInfo<void> {
  const AppointmentBookingRoute({List<_i4.PageRouteInfo>? children})
      : super(
          AppointmentBookingRoute.name,
          initialChildren: children,
        );

  static const String name = 'AppointmentBookingRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i1.AppointmentBookingScreen();
    },
  );
}

/// generated route for
/// [_i2.AppointmentListScreen]
class AppointmentListRoute extends _i4.PageRouteInfo<void> {
  const AppointmentListRoute({List<_i4.PageRouteInfo>? children})
      : super(
          AppointmentListRoute.name,
          initialChildren: children,
        );

  static const String name = 'AppointmentListRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i2.AppointmentListScreen();
    },
  );
}

/// generated route for
/// [_i3.HomeScreen]
class HomeRoute extends _i4.PageRouteInfo<void> {
  const HomeRoute({List<_i4.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i3.HomeScreen();
    },
  );
}
