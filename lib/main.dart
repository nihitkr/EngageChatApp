import 'package:engage_chat_app/helper/helper.dart';
import 'package:engage_chat_app/screens/homescreen.dart';
import 'package:engage_chat_app/screens/loginScreen.dart';
import 'package:engage_chat_app/screens/registrationScreen.dart';
import 'package:engage_chat_app/screens/search.dart';
import 'package:engage_chat_app/state_wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userIsLoggedIn = false;
  void initState() {
    getLoggedInState();
    super.initState();
  }

  getLoggedInState() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((value) {
      setState(() {
        userIsLoggedIn;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Email and Password Login",
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      // home: const StateWrapper(),
      home: userIsLoggedIn ? HomeScreen() : LoginScreen(),
    );
  }
}
