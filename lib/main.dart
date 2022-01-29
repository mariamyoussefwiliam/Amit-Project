import 'package:amit_project/moduels/login%20and%20register/cubit/cubit.dart';
import 'package:amit_project/shared/component/constant.dart';
import 'package:amit_project/shared/component/observer.dart';
import 'package:amit_project/shared/cubit/cubit.dart';
import 'package:amit_project/shared/cubit/states.dart';
import 'package:amit_project/shared/network/local/cache_helper.dart';
import 'package:amit_project/shared/network/remote/dio-helper.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'layout/homeLayout.dart';
import 'moduels/login and register/loginScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();

  BlocOverrides.runZoned(() {
    runApp(const MyApp());
  }, blocObserver: MyBlocObserver());
  await CacheHelper.init();
  DioHelper.init();
  String? token = CacheHelper.get(key:"token");

  if (token!=null) {
    Token = token;
   email=  CacheHelper.get(key: "email");
    name=  CacheHelper.get(key: "user name");
  }
  print("jswnhbhnjmkjnhbgf $Token");
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit()
            ..getProductData()
            ..getCategoriesData(),
        ),
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
      ],
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: defaultColor,
            primarySwatch: Colors.red,
            textTheme: const TextTheme(
                bodyText1: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            )),
            //  primarySwatch: Colors.red,
            scaffoldBackgroundColor: HomeCubit.get(context).index == 3
                ? Colors.white
                : Colors.grey[300],
            appBarTheme: const AppBarTheme(
              iconTheme: IconThemeData(color: defaultColor),
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
              image: AssetImage("assets/images/orange.jpg"),
              width: 120,
              height: 25,
              fit: BoxFit.cover,
            ),
            nextScreen: HomeLayout(),
            splashTransition: SplashTransition.rotationTransition,
            backgroundColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
