import 'package:flutter/material.dart';
import 'package:medicine_schedule/routers/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppConfig _appRouter = AppConfig();
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerDelegate: _appRouter.router.routerDelegate,
      routeInformationParser: _appRouter.router.routeInformationParser,
      routeInformationProvider: _appRouter.router.routeInformationProvider,
    );
  }
}
