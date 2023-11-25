import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new3/firepropets/homeLayout.dart';
import 'package:new3/lpgin.dart';
import 'package:new3/moudles/addScreen.dart';
import 'package:new3/moudles/homeScreen.dart';
import 'package:new3/moudles/singUp.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:new3/shared/constant/constants.dart';
import 'package:new3/shared/cubit/cubit.dart';

void main() async {
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getnew(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            appBarTheme: AppBarTheme(
                color: Colors.grey[200],
                titleTextStyle: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
                actionsIconTheme: const IconThemeData(color: Colors.black)),
            textTheme:
                const TextTheme(displayLarge: TextStyle(color: Colors.black38)),
            primarySwatch: Colors.deepOrange,
          ),
          home: const homelayput()
          // (FirebaseAuth.instance.currentUser != null &&
          //         FirebaseAuth.instance.currentUser!.emailVerified)
          //     ? const homelayput()
          //     : const login(),
          ,
          routes: {
            "addscraan": (context) => AddScraan(),
            "singind": (context) => const SingUp(),
            "email": (context) => const login(),
            "home": (context) => const homeScrren(),
            //"upScraan":(context) => upScraan(

            // ),
          }),
    );
  }
}
