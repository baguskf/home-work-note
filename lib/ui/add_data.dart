import 'package:curd_flutter/colors/colors.dart';
import 'package:flutter/material.dart';

class AddData extends StatelessWidget {
  static const routeName = '/add_data';
  const AddData({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tambah Data',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primary700,
        iconTheme: const IconThemeData(
          color: Colors.white, // Ubah warna tombol back di sini
        ),
      ),
      body: const Center(
        child: Text('isi lah ntar'),
      ),
    );
  }
}
