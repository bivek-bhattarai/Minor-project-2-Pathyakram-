import 'package:flutter/material.dart';
import 'package:pathyakrama_app/Login%20Sign-up%20Screen/Login%20Screen/helper.dart';
import 'package:pathyakrama_app/Welcome%20Screen/welcome_screen.dart';
import 'Login Sign-up Screen/Login Screen/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Main Screen/main_screen.dart';
import 'Universities Screen/universities.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // initialRoute: WelcomeScreen.id,
      home: LoginHelper().handleAuthState(),
      routes: {
        WelcomeScreen.id: (context) => const WelcomeScreen(),
        Login.id: (context) => const Login(),
        Universities.id: (context) => const Universities(),
      },
      theme: ThemeData(
        fontFamily: 'artifica',
        backgroundColor: const Color(0xffF8FAFB),
        textTheme: const TextTheme(
          headline1: TextStyle(             // used in welcome screen (description, skip,) / also used in drawer email, mainScreen categories text eg (universities)
            color: Color(0xff858484),
            fontFamily: 'artifica',
            fontSize: 15.0,
          ),
          headline2: TextStyle(              // used in drawer items,
            color: Color(0xff0D81B2),
            fontFamily: 'lato',
            fontSize: 14.0,
          ),
          headline3: TextStyle(
            fontFamily: 'lato',
            fontSize: 20.0,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        primaryColor: const Color(0xff0D81B2),
        appBarTheme: const AppBarTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20.0),
            ),
          ),
          centerTitle: true,
          elevation: 6.0,
          toolbarHeight: 55.0,
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
            color: Color(0xff0D81B2),
            fontFamily: 'artifica',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(
            color: Colors.black,
            size: 30.0,
          ),
        ),
      ),
    );
  }
}
