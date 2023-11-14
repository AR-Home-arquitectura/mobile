import 'package:arhome/pages/home.page.dart';
import 'package:arhome/pages/login.page.dart';
import 'package:arhome/pages/sign-up.page.dart';
import 'package:arhome/pages/splash.page.dart';
import 'package:arhome/providers/user.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:firebase_core/firebase_core.dart';

Future<void> main() async
{
  try
  {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: const FirebaseOptions(apiKey: "AIzaSyB8-oR5FGaIgwqXmc-5WyMniz8b9vLRpMA", appId: "1:1011775757111:web:f5d5ef9891e034055758b2", messagingSenderId: "1011775757111", projectId: "arhometest-cf0bc")
    );
  }
  catch (errorMsg)
  {
    print("Error:: $errorMsg");
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget
{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider())
      ],
      child: MaterialApp(
        title: 'ARHome',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          useMaterial3: true
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const SplashScreen(
            // Here, you can decide whether to show the LoginPage or HomePage based on user authentication
            child: LoginPage(),
          ),
          '/login': (context) => const LoginPage(),
          '/signUp': (context) => const SignUpPage(),
          '/home': (context) => const HomePage(),
        },
      ),
    );
  }
}
