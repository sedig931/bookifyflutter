import 'package:bookify_app/modal/sharedData.dart';
import 'package:bookify_app/screens/adminHome.dart';
import 'package:bookify_app/screens/loginScreen.dart';
import 'package:bookify_app/screens/registerScreen.dart';
import 'package:bookify_app/screens/userHome.dart';
import 'package:bookify_app/screens/welcomeScreen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // This is the last thing you need to add.
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<sharedData>(
        create: (context) => sharedData(),
    child:MaterialApp(
      title: 'booify-app',
        initialRoute: '/',
      routes: {
        '/':(context)=> WelcomeScreen(),
        '/login':(context)=> LoginScreen(),
        '/register':(context)=> RegisterScreen(),
        '/userHome':(context)=> UserHomeScreen(),
        '/adminHome':(context)=> AdminHomeScreen(),
      },
    ));
  }
}