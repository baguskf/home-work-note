// ignore_for_file: avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

class FirestoreController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  var selectedFiles = <File>[].obs;

  void upload(String matkul, String dosen, String tanggal, String note,
      String userId) async {
    Get.dialog(
      const Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );

    try {
      List<String> fileUrl = [];

      var fileID = const Uuid();
      for (File file in selectedFiles) {
        String fileName = path.basename(file.path);
        Reference ref = storage.ref().child('${fileID.v4()}_$fileName');

        await ref.putFile(file);

        String downloadUrl = await ref.getDownloadURL();
        fileUrl.add(downloadUrl);
      }

      Get.back();

      await firestore.collection('data').doc(userId).collection('dataUser').add(
        {
          "matkul": matkul,
          "dosen": dosen,
          "tanggal": tanggal,
          "note": note,
          "files": fileUrl,
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
      Get.back();
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

  // Fungsi untuk memilih dan meng-upload file
  void uploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'png'],
    );

    if (result != null) {
      // Pastikan untuk update menggunakan .value
      selectedFiles.value = result.paths.map((path) => File(path!)).toList();
    } else {
      print('gajadi');
    }
  }

  void clearFiles() {
    selectedFiles.clear(); // Menghapus semua file yang dipilih
  }

  // void uploadFile() async {
  //   FilePickerResult? result =
  //       await FilePicker.platform.pickFiles(allowMultiple: true);

  //   if (result != null) {
  //     result.files.forEach(
  //       (element) async {
  //         String name = element.name;
  //         File file = File(element.path!);
  //         try {
  //           await firebase_storage.FirebaseStorage.instance
  //               .ref(name)
  //               .putFile(file);
  //           print('berhasil');
  //         } on firebase_storage.FirebaseException catch (e) {
  //           print('eror upload');
  //         }
  //       },
  //     );
  //   } else {
  //     print('ga jadi');
  //   }
  // }

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
