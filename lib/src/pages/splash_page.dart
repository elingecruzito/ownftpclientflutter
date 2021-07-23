import 'dart:async';

import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 5), () => Navigator.pushReplacementNamed(context, 'home'));
    return Scaffold(
      body: Center(
        child: Container(
          child: Image(
            image: AssetImage('assets/logo-owncloud.png'),
          ),
        ),
      ),
    );
  }
}