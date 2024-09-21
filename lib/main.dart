import 'package:curd_flutter/ui/add_data.dart';
import 'package:curd_flutter/ui/home_screen.dart';
import 'package:curd_flutter/ui/login_screen.dart';
import 'package:curd_flutter/ui/register_screen.dart';
import 'package:curd_flutter/controller/firebase_controler.dart';
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
        if (snapshot.connectionState == ConnectionState.active) {
          return GetMaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(),
            initialRoute: snapshot.data != null
                ? AddData.routeName
                : LoginScreen.routeName,
            getPages: [
              GetPage(
                name: HomeScreen.routeName,
                page: () => const HomeScreen(),
              ),
              GetPage(
                name: LoginScreen.routeName,
                page: () => const LoginScreen(),
              ),
              GetPage(
                name: RegisterScreen.routeName,
                page: () => const RegisterScreen(),
              ),
              GetPage(
                name: AddData.routeName,
                page: () => const AddData(),
              ),
            ],
          );
        }
        return const MaterialApp(
          home: Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
