// ignore_for_file: avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirestoreController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<String> fileUrls = [];

  void upload(String matkul, String dosen, String tanggal, String note) async {
    CollectionReference data = firestore.collection('data');
    try {
      await data.add(
        {
          "matkul": matkul,
          "dosen": dosen,
          "tanggal": tanggal,
          "note": note,
        },
      );
      Get.dialog(
        AlertDialog(
          title: const Text('Berhasil disimpan'),
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
    } on FirebaseException catch (e) {
      String errorMessage = _getErrorMessage(e.code);
      Get.dialog(
        AlertDialog(
          title: const Text('Gagal disimpan'),
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

  void uploadFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      result.files.forEach(
        (element) async {
          String name = element.name;
          File file = File(element.path!);
          try {
            await firebase_storage.FirebaseStorage.instance
                .ref(name)
                .putFile(file);
            print('berhasil');
          } on firebase_storage.FirebaseException catch (e) {
            print('eror upload');
          }
        },
      );
    } else {
      print('ga jadi');
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
}
