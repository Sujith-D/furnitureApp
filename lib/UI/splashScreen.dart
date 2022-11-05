import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:furniture/UI/homePage/homePage.dart';
import 'package:furniture/data/provider.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<FurnitureProvider>(context,listen: false).getRequest();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  AnimatedSplashScreen(
        splash: const Icon(Icons.table_restaurant_outlined,size: 50,),
        nextScreen: const homePage(),
        splashTransition: SplashTransition.sizeTransition,
        backgroundColor: Colors.amber,
        duration: 100,);
  }
}