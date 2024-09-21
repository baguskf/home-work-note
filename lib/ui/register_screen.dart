import 'package:curd_flutter/colors/colors.dart';
import 'package:curd_flutter/controller/firebase_controler.dart';
import 'package:curd_flutter/ui/login_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/register';
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _pass = TextEditingController();
  final _passconfirm = TextEditingController();

  bool _isObscure = true;
  bool _isObscureCpass = true;
  String? _errorCpass;
  String? _errorPass;
  String? _emailError;
  String? _nameError;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _pass.dispose();
    _passconfirm.dispose();
    super.dispose();
  }

  final authController = Get.find<FirebaeControler>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: SizedBox(
                    height: 200,
                    width: 200,
                    child: Image.asset('assets/images/buku.png'),
                  ),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Silahkan Daftar!',
                      style: TextStyle(
                        fontFamily: 'MyFont',
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                TextField(
                  style: const TextStyle(fontFamily: 'myfont'),
                  maxLength: 20,
                  controller: _name,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.person_outline,
                      color: neutralBlack,
                    ),
                    label: const Text(
                      'Nama',
                      style: TextStyle(fontFamily: 'myfont'),
                    ),
                    labelStyle: const TextStyle(color: neutralBlack),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: neutralBlack),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: primary700),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.red, width: 1.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.red, width: 1.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    errorText: _nameError,
                    counterText: '',
                  ),
                  onChanged: (value) {
                    setState(
                      () {
                        if (value.isEmpty) {
                          _nameError = 'Nama tidak boleh kosong';
                        } else {
                          _nameError = null;
                        }
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  style: const TextStyle(fontFamily: 'myfont'),
                  controller: _email,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      color: neutralBlack,
                    ),
                    label: const Text(
                      'Email',
                      style: TextStyle(fontFamily: 'myfont'),
                    ),
                    labelStyle: const TextStyle(color: neutralBlack),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: neutralBlack),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: primary700),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.red, width: 1.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.red, width: 1.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    errorText: _emailError,
                  ),
                  onChanged: (value) {
                    setState(
                      () {
                        if (value.isEmpty) {
                          _emailError = 'Email tidak boleh kosong';
                        } else if (!RegExp(
                                r'^[\w-\.]+@([\w-]+\.)+[a-zA-Z]{2,}$')
                            .hasMatch(value)) {
                          _emailError = 'Email tidak valid';
                        } else {
                          _emailError = null;
                        }
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  style: const TextStyle(fontFamily: 'myfont'),
                  controller: _pass,
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.password_outlined,
                      color: neutralBlack,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscure ? Icons.visibility_off : Icons.visibility,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    ),
                    label: const Text(
                      'Password',
                      style: TextStyle(fontFamily: 'myfont'),
                    ),
                    labelStyle: const TextStyle(color: neutralBlack),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: neutralBlack),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: primary700),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.red, width: 1.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.red, width: 1.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    errorText: _errorPass,
                  ),
                  onChanged: (value) {
                    setState(
                      () {
                        if (value.isEmpty) {
                          _errorPass = 'Password tidak boleh kosong';
                        } else if (value.length < 8) {
                          _errorPass =
                              'Password harus terdiri dari minimal 8 karakter';
                        } else {
                          _errorPass = null;
                        }
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  style: const TextStyle(fontFamily: 'myfont'),
                  controller: _passconfirm,
                  obscureText: _isObscureCpass,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.password_outlined,
                      color: neutralBlack,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscureCpass
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscureCpass = !_isObscureCpass;
                        });
                      },
                    ),
                    label: const Text(
                      'Konfirmasi Password',
                      style: TextStyle(fontFamily: 'myfont'),
                    ),
                    labelStyle: const TextStyle(color: neutralBlack),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: neutralBlack),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: primary700),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.red, width: 1.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.red, width: 1.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    errorText: _errorCpass,
                  ),
                  onChanged: (value) {
                    setState(
                      () {
                        if (value.isEmpty) {
                          _errorCpass = 'Password tidak boleh kosong';
                        } else if (value != _pass.text) {
                          _errorCpass = 'Pastikan Password Sama';
                        } else if (value.length < 8) {
                          _errorCpass =
                              'Password harus terdiri dari minimal 8 karakter';
                        } else {
                          _errorCpass = null;
                        }
                      },
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: "Sudah Punya Akun?",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'myfont',
                                fontSize: 12,
                              ),
                            ),
                            TextSpan(
                              text: ' Login',
                              style: const TextStyle(
                                color: Colors.blue,
                                fontFamily: 'myfont',
                                fontSize: 12,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(
                                      context, LoginScreen.routeName);
                                },
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
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
                      final name = _name.text.trim();
                      final email = _email.text.trim();
                      final pass = _pass.text.trim();
                      final cPass = _passconfirm.text.trim();
                      if (_errorPass != null ||
                          _nameError != null ||
                          _emailError != null ||
                          _errorCpass != null ||
                          name.isEmpty ||
                          email.isEmpty ||
                          pass.isEmpty ||
                          cPass.isEmpty) {
                        _showDialog();
                      } else {
                        authController.register(email, pass, name);
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
                      'Daftar',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'myfont'),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Register Gagal!'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Masukkan Semua Data Dengan Benar!',
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
