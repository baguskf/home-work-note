import 'package:another_dashed_container/another_dashed_container.dart';

import 'package:curd_flutter/controller/firestore_controller.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:path/path.dart' as path;

class SelectFile extends StatefulWidget {
  const SelectFile({super.key});

  @override
  State<SelectFile> createState() => _SelectFileState();
}

class _SelectFileState extends State<SelectFile> {
  final firestore = Get.find<FirestoreController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DashedContainer(
          dashColor: Colors.black,
          borderRadius: 20.0,
          dashedLength: 5.0,
          blankLength: 10.0,
          strokeWidth: 2.0,
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Obx(
                    () {
                      if (firestore.selectedFiles.isEmpty) {
                        return Column(
                          children: [
                            const Text(
                              'Upload File (Opsional)',
                              style:
                                  TextStyle(fontFamily: 'myfont', fontSize: 15),
                            ),
                            const Text(
                              "'pdf', 'doc', 'docx', 'jpg', 'png'",
                              style:
                                  TextStyle(fontFamily: 'myfont', fontSize: 15),
                            ),
                            TextButton(
                              onPressed: () {
                                firestore
                                    .uploadFile(); // Memanggil fungsi uploadFile
                              },
                              child: const Text("Upload file"),
                            ),
                          ],
                        );
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ...firestore.selectedFiles.map(
                              (file) => Text(
                                "* File: ${path.basename(file.path)}",
                                style: const TextStyle(
                                    fontFamily: 'myfont', fontSize: 15),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                firestore
                                    .clearFiles(); // Memanggil fungsi uploadFile
                              },
                              child: const Text("Clear file"),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
