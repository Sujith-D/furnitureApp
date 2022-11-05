import 'package:flutter/material.dart';
import 'package:furniture/UI/splashScreen.dart';
import 'package:furniture/data/provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
      ChangeNotifierProvider(create: (_) => FurnitureProvider())
  ],child:const MyApp()));
    
}

class MyApp extends StatelessWidget { 

  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen()
    );
  }
}

