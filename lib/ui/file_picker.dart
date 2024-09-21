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
  List<String>? selectedFiles;
  final firestore = Get.find<FirestoreController>();

  Future<void> pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'png'],
      allowMultiple: true,
    );

    if (result != null) {
      setState(
        () {
          selectedFiles = result.paths.map((path) => path!).toList();
        },
      );
    }
  }

  void clearFiles() {
    setState(() {
      selectedFiles = null;
    });
  }

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
                  if (selectedFiles == null) ...[
                    const Text(
                      'Upload File (Opsional)',
                      style: TextStyle(fontFamily: 'myfont', fontSize: 15),
                    ),
                    const Text(
                      "'pdf', 'doc', 'docx', 'jpg', 'png'",
                      style: TextStyle(fontFamily: 'myfont', fontSize: 15),
                    ),
                  ] else ...[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: selectedFiles!
                          .map((file) => Text(
                                "* File: ${path.basename(file)}",
                                style: const TextStyle(
                                    fontFamily: 'myfont', fontSize: 15),
                              ))
                          .toList(),
                    ),
                    TextButton(
                      onPressed: clearFiles,
                      child: const Text(
                        'Clear Files',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                  TextButton(
                    onPressed: () => firestore.uploadFile(),
                    child: const Text(
                      'Upload',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
