import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_provider/WIDGETS/profile.dart';
import 'package:service_provider/WIDGETS/task.dart';
import 'package:service_provider/home.dart';
import 'package:service_provider/login-signup/login.dart';
import 'package:service_provider/login-signup/signup.dart';
import 'package:service_provider/provider/user_state_provider.dart';
import 'package:service_provider/splash-screen/splash_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserStateProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Consumer<UserStateProvider>(
          builder: (context, UserStateProvider, child) {
        if (UserStateProvider.user.isNotEmpty) {
          return Home(
            user: UserStateProvider.user,
          );
        } else {
          return const SplashScreen();
        }
      }),
      routes: {
        //'/': (context) => const SplashScreen(),
        'profile': (context) => const Profile(),
        'task': (context) => const Task(),
        'login': (context) => const Login(),
        'signup': (context) => Signup(),
      },
    );
  }
}
