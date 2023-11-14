import 'package:arhome/pages/home.page.dart';
import 'package:arhome/pages/login.page.dart';
import 'package:arhome/pages/sign-up.page.dart';
import 'package:arhome/pages/splash.page.dart';
import 'package:arhome/providers/user.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Firebase imports
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';



import 'widgets/products-table.widget.dart';

/*const firebaseConfig = {
  apiKey: "AIzaSyB8-oR5FGaIgwqXmc-5WyMniz8b9vLRpMA",
  authDomain: "arhometest-cf0bc.firebaseapp.com",
  projectId: "arhometest-cf0bc",
  storageBucket: "arhometest-cf0bc.appspot.com",
  messagingSenderId: "1011775757111",
  appId: "1:1011775757111:web:f5d5ef9891e034055758b2",
  measurementId: "G-GDJT9NSS2D"
};*/

Future<void> main() async
{
  try
  {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: FirebaseOptions(apiKey: "AIzaSyB8-oR5FGaIgwqXmc-5WyMniz8b9vLRpMA", appId: "1:1011775757111:web:f5d5ef9891e034055758b2", messagingSenderId: "1011775757111", projectId: "arhometest-cf0bc")
    );
  }
  catch (errorMsg)
  {
    print("Error:: " + errorMsg.toString());
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
          '/': (context) => SplashScreen(
            // Here, you can decide whether to show the LoginPage or HomePage based on user authentication
            child: LoginPage(),
          ),
          '/login': (context) => LoginPage(),
          '/signUp': (context) => SignUpPage(),
          '/home': (context) => HomePage(),
        },
      ),
    );
  }
}
