import 'package:flutter/material.dart';
import 'package:simplon_flutter/screens/dashboardBriefs.dart';
import 'package:simplon_flutter/screens/showBrief.dart';
import './screens/singin.dart';
import './screens/home.dart';
import './screens/dashboard.dart';
import './screens/addBrief.dart';
// import './screens/dashboardBriefs.dart';

class Routes {
  static const String login = '/login';
  static const String home = '/home';
  static const String dashboard = '/dashboard';
  static const String addBrief = '/add_brief';
  static const String dashboardBriefs = '/dashboard_briefs';
  static const String showBrief = '/show_brief';

  static final routes = <String, WidgetBuilder>{
    login: (BuildContext context) => LoginPage(),
    home: (BuildContext context) => const HomePage(),
    dashboard: (BuildContext context) => const DashboardPage(),
    addBrief: (BuildContext context) => const AddBrief(),
    dashboardBriefs: (BuildContext context) => const DashboardBriefsPage(),
    showBrief: (BuildContext context ) => const ShowBriefPage()
  };
}
