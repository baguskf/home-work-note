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

  void reset(String email) async {
    if (email.isNotEmpty) {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

        Get.back();
        Get.snackbar(
          "Berhasil",
          "Link Reset Password Dikirim ke Email Anda",
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(20),
          borderRadius: 10,
        );
      } catch (e) {
        Get.back();
        Get.snackbar(
          "Error",
          "Format Email Salah",
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(20),
          borderRadius: 10,
        );
      }
    } else {
      Get.back();
      Get.snackbar(
        "Error",
        "Silahkan Masukkan Email",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(20),
        borderRadius: 10,
      );
    }
  }

  void register(String email, String password, String name) async {
    Get.dialog(
      const Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
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
      barrierDismissible: false,
    );
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);
      Get.back();
      Get.offAllNamed(HomeScreen.routeName);
    } on FirebaseAuthException catch (e) {
      Get.back();
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
      'email-already-in-use': 'Email sudah digunakan',
      'The email address is badly formatted': 'Format email salah'
    };
    return errorMessages[errorCode] ?? 'Terjadi kesalahan: $errorCode';
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(LoginScreen.routeName);
  }
}
