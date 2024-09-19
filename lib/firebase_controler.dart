import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curd_flutter/ui/home_screen.dart';
import 'package:curd_flutter/ui/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaeControler extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<User?> get streamAuth => auth.authStateChanges();

  void register(String email, String password, String name) async {
    Get.dialog(
      const Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible:
          false, // Supaya tidak bisa ditutup selama proses berjalan
    );
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await firestore.collection('users').doc(userCredential.user!.uid).set(
        {
          'email': email,
          'name': name,
          'createdAt': FieldValue.serverTimestamp(),
        },
      );

      await auth.signOut();

      Get.dialog(
        AlertDialog(
          title: const Text('Berhasil'),
          content: const Text('Akun Berhasil Dibuat'),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
                Get.offAllNamed(LoginScreen.routeName);
              },
              child: const Text('OK'),
            ),
          ],
        ),
        barrierDismissible: true,
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage = _getErrorMessage(e.code);

      Get.dialog(
        AlertDialog(
          title: const Text('Regetrasi Gagal'),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('OK'),
            ),
          ],
        ),
        barrierDismissible: true,
      );
    }
  }

  void login(String email, String pass) async {
    Get.dialog(
      const Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible:
          false, // Supaya tidak bisa ditutup selama proses berjalan
    );
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
      Get.offAllNamed(HomeScreen.routeName);
    } on FirebaseAuthException catch (e) {
      String errorMessage = _getErrorMessage(e.code);

      Get.dialog(
        AlertDialog(
          title: const Text('Login Gagal'),
          content: Text(errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('OK'),
            ),
          ],
        ),
        barrierDismissible: true,
      );
    }
  }

  String _getErrorMessage(String errorCode) {
    final errorMessages = {
      'invalid-credential': 'Email dan Password salah',
      'channel-error': 'Masukan Semua Data!',
      'wrong-password': 'Password salah',
      'invalid-email': 'Email tidak valid',
      'weak-password': 'Password terlalu lemah',
      'email-already-in-use': 'Email sudah digunakan'
    };
    return errorMessages[errorCode] ?? 'Terjadi kesalahan: $errorCode';
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(LoginScreen.routeName);
  }
}
