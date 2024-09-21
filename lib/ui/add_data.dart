import 'package:curd_flutter/colors/colors.dart';
import 'package:curd_flutter/controller/firebase_controler.dart';
import 'package:curd_flutter/controller/firestore_controller.dart';
import 'package:curd_flutter/ui/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';

class AddData extends StatelessWidget {
  static const routeName = '/add_data';
  const AddData({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF6200EE),
                Color.fromARGB(255, 47, 0, 255),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: AppBar(
            title: const Text(
              'Tambah Tugas',
              style: TextStyle(color: Colors.white, fontFamily: 'myfont'),
            ),
            backgroundColor: Colors.transparent,
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: InputField(),
      ),
    );
  }
}

class InputField extends StatefulWidget {
  const InputField({super.key});

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  DateTime? selectedDate;
  final _nameC = TextEditingController();
  final _dosenC = TextEditingController();
  final _notesC = TextEditingController();
  final _dateController = TextEditingController();

  final firestore = Get.put(FirestoreController());

  final String userId = Get.arguments as String;

  @override
  void dispose() {
    _nameC.dispose();
    _dosenC.dispose();
    _notesC.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(
        () {
          selectedDate = picked;
          _dateController.text = DateFormat('d MMM yyyy').format(selectedDate!);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                TextField(
                  controller: _nameC,
                  style: const TextStyle(fontFamily: 'myfont', fontSize: 20),
                  cursorColor: neutralBlack,
                  decoration: const InputDecoration(
                    labelText: 'Mata Pelajaran',
                    labelStyle: TextStyle(
                        fontFamily: 'myfont',
                        fontSize: 20,
                        color: neutralBlack),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: primary700),
                    ),
                  ),
                ),
                const Positioned(
                  right: 0,
                  top: 12, // Sesuaikan dengan posisi label
                  child: Text(
                    '*',
                    style: TextStyle(
                      color: Colors.red, // Atur warna sesuai kebutuhan
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Stack(
              children: [
                TextField(
                  controller: _dosenC,
                  style: const TextStyle(fontFamily: 'myfont', fontSize: 20),
                  cursorColor: neutralBlack,
                  decoration: const InputDecoration(
                    labelText: 'Nama Guru/Dosen',
                    labelStyle: TextStyle(
                        fontFamily: 'myfont',
                        fontSize: 20,
                        color: neutralBlack),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: primary700),
                    ),
                  ),
                ),
                const Positioned(
                  right: 0,
                  top: 12, // Sesuaikan dengan posisi label
                  child: Text(
                    '*',
                    style: TextStyle(
                      color: Colors.red, // Atur warna sesuai kebutuhan
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Stack(
              children: [
                TextField(
                  onTap: () => _selectDate(context),
                  controller: _dateController,
                  readOnly: true,
                  style: const TextStyle(fontFamily: 'myfont', fontSize: 20),
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () => _selectDate(context),
                      icon: const Icon(Icons.calendar_month_outlined),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: primary700),
                    ),
                    labelText: 'Batas Waktu',
                    labelStyle: const TextStyle(
                      fontFamily: 'myfont',
                      fontSize: 20,
                      color: neutralBlack,
                    ),
                  ),
                ),
                const Positioned(
                  right: 0,
                  top: 12, // Sesuaikan dengan posisi label
                  child: Text(
                    '*',
                    style: TextStyle(
                      color: Colors.red, // Atur warna sesuai kebutuhan
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Catatan (opsional)',
              style: TextStyle(
                fontFamily: 'myfont',
                fontSize: 20,
                color: neutralBlack,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: neutralBlack),
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _notesC,
                    maxLines: null,
                    style: const TextStyle(fontFamily: 'myfont', fontSize: 20),
                    cursorColor: neutralBlack,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelStyle: TextStyle(
                        fontFamily: 'myfont',
                        fontSize: 20,
                        color: neutralBlack,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const SelectFile(),
            const SizedBox(
              height: 25,
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    primary700,
                    Color.fromARGB(255, 47, 0, 255),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ElevatedButton(
                onPressed: () {
                  var name = _nameC.text.toString();
                  var guru = _dosenC.text.toString();
                  var date = _dateController.text.toString();

                  if (name.isEmpty && guru.isEmpty && date.isEmpty) {
                    Get.dialog(
                      AlertDialog(
                        title: const Text('Gagal Menyimpan'),
                        content: const Text('File Bertanda * Wajib Diisi!'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Get.back(); // Menutup dialog
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                      barrierDismissible:
                          false, // Tidak bisa ditutup dengan mengetuk di luar
                    );
                  } else {
                    firestore.upload(_nameC.text, _dosenC.text,
                        _dateController.text, _notesC.text, userId);
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.transparent,
                ),
                child: const Text(
                  'Simpan',
                  style: TextStyle(
                      color: Colors.white, fontSize: 15, fontFamily: 'myfont'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
