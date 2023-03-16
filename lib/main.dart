import 'package:flutter/material.dart';
import 'routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SimplOnline',
      theme: ThemeData(primarySwatch: Colors.red),
      routes: Routes.routes,
      initialRoute: Routes.login,
    );
  }
}