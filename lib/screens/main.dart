import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'help_page.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'signup_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyASZEBEvX2aDClh2bOT1RDJzsaIIlUBm18",
      appId: "1:856927330532:web:e9636af063ec7a1a354cf1",
      messagingSenderId: "856927330532",
      projectId: "tugas-kedua-6971d",
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Two',
      theme: ThemeData(
          primaryColor: Colors.blue,
          hintColor: Colors.blueAccent,
          buttonTheme: const ButtonThemeData(
            buttonColor: Colors.blue,
            textTheme: ButtonTextTheme
                .primary,
          )),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
        '/home': (context) => const HomePage(),
        '/help': (context) => const HelpPage(),
      },
    );
  }
}
