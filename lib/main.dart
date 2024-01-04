import 'package:flutter/material.dart';
import 'package:flutter_pro/controller/home_controller.dart';
import 'package:flutter_pro/view/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => HomeController())
        ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade50),
        appBarTheme: AppBarTheme(
            titleTextStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.blue),
            centerTitle: true,
            iconTheme: IconThemeData(color: Colors.white)
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    ),
    );
    
  }
}