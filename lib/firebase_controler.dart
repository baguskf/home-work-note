import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaeControler extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<User?> get streamAuth => auth.authStateChanges();

  void Register() {}
  void Login() {}
}
