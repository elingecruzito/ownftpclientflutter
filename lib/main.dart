import 'package:flutter/material.dart';
import 'package:ownftpclient/src/pages/home_page.dart';
import 'package:ownftpclient/src/pages/register_page.dart';
import 'package:ownftpclient/src/pages/splash_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Own FTP Client',
      debugShowCheckedModeBanner: false,
      initialRoute: 'register',
      routes: {
        'splash': (BuildContext context) => SplashPage(), 
        'home': (BuildContext context) => HomePage(),
        'register' : (BuildContext context) => RegisterPage(),
      },
      theme: ThemeData(
        primaryColor: Colors.blue[600]
      ),
    );
  }
}