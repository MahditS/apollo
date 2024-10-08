import 'package:apollo/features/app/splash_screen/splash_screen.dart';
import 'package:apollo/features/presentation/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';

Future main() async {
  

  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Apollo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(child: HomePage(),),
    );
  }
}

