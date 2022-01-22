import 'package:amit_project/shared/component/constant.dart';
import 'package:amit_project/shared/cubit/cubit.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'layout/homeLayout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: const TextTheme(
              bodyText1: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          )),
        //  primarySwatch: Colors.red,
          scaffoldBackgroundColor: Colors.grey[300],
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color:defaultColor),
            color: Colors.white,
            elevation: 0,
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.white,
            selectedItemColor: defaultColor,
          ),
        ),
        home: AnimatedSplashScreen(
          splash: const Image(
            image: AssetImage("assets/images/amit.jpg"),
            width: 120,
            height: 10,
          ),
          nextScreen: HomeLayout(),
          splashTransition: SplashTransition.rotationTransition,
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
