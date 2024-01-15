import 'package:flutter/material.dart';
import 'package:flutter_pro/view/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Future.delayed( Duration(seconds: 3),()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomeScreen())));
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: size.height * .1,
              left: 0,
              right: 0,
              child: Image.asset('assets/images/logo.png')),
          Positioned(
              top: size.height * .45,
              left: size.width * .2,
              right: 0,
              child: Text('Welcome to ALFNR',style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700
              ),)),
          Positioned(
              top: size.height * .5,
              left: size.width * .015,
              right: 0,
              child: Text('Lorem ipsum dolor sit amet consectetur. Vitae vestibulum etiam ut sit amet commodo. Aenean lacus faucibus egestas fringilla sem.',
               textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14,
              ),)),


          Positioned(
            bottom: 0,
              child: Image.asset('assets/images/logoB.png')),
        ],
      ),
    );
  }
}
