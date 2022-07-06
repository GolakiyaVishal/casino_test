import 'package:casino_test/src/presentation/screens/home/home_provider.dart';
import 'package:casino_test/src/presentation/screens/info/info_screen.dart';
import 'package:flutter/material.dart';
import 'package:casino_test/src/presentation/screens/home/home_screen.dart';
import 'package:provider/provider.dart';

class CasinoApp extends StatelessWidget {
  const CasinoApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Casino Test',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: <String, WidgetBuilder>{
        HomeScreen.route: (context) => const HomeScreen(title: 'Casino Test'),
        InfoScreen.route: (context) => const InfoScreen(),
      },
      home: ChangeNotifierProvider(
          create: (_) => HomeProvider(),
          builder: (_, child) => const HomeScreen(title: 'Casino Test')),
    );
  }
}
