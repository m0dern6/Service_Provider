import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, 'signup');
    });

    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Service Provider',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(width: 10),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
