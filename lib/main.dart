import 'package:flutter/material.dart';
import 'package:thanhmaihskchatbot/pages/landing_page.dart';
import 'package:thanhmaihskchatbot/widgets/image_button.dart';

import 'pages/chat_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: Scaffold(
        body: LandingPage(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
