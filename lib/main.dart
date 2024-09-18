import 'package:curd_flutter/ui/home_screen.dart';
import 'package:curd_flutter/ui/login_screen.dart';
import 'package:curd_flutter/ui/register_screen.dart';
import 'package:curd_flutter/firebase_controler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final authController = Get.put(FirebaeControler(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: authController.streamAuth,
        builder: (context, snapshot) {
          // ignore: avoid_print
          print('ini : $snapshot');
          return GetMaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(),
            initialRoute: HomeScreen.routeName,
            routes: {
              HomeScreen.routeName: (context) => const HomeScreen(),
              LoginScreen.routeName: (context) => const LoginScreen(),
              RegisterScreen.routeName: (context) => const RegisterScreen(),
            },
          );
        });
  }
}
