import 'package:curd_flutter/colors/colors.dart';
import 'package:curd_flutter/controller/firebase_controler.dart';
import 'package:curd_flutter/ui/register_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login_screen';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    child: Image.asset(
                      'assets/images/catat.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Colors.black.withOpacity(1),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const Positioned(
                  bottom: 30,
                  left: 15,
                  right: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selamat Datang!',
                        style: TextStyle(
                          color: neutralWhite,
                          fontSize: 30,
                          fontFamily: 'myfont',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Catat PR, Capai Tujuanmu',
                        style: TextStyle(
                          color: neutralWhite,
                          fontSize: 20,
                          fontFamily: 'myfont',
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const LoginForm()
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        final keyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
        if (keyboardVisible) {
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
        }
      },
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _email = TextEditingController();
  final _pass = TextEditingController();
  final _dialog = TextEditingController();

  String? _errorMessage;
  String? _emailError;
  bool _isObscure = true;
  final authController = Get.find<FirebaeControler>();

  @override
  void dispose() {
    _email.dispose();
    _pass.dispose();
    _dialog.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Silahkan Login!',
                  style: TextStyle(
                    fontFamily: 'myfont',
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
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
                borderSide: const BorderSide(color: Colors.red, width: 1.5),
                borderRadius: BorderRadius.circular(20),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red, width: 1.5),
                borderRadius: BorderRadius.circular(20),
              ),
              errorText: _emailError,
            ),
            onChanged: (value) {
              setState(
                () {
                  if (value.isEmpty) {
                    _emailError = 'Email tidak boleh kosong';
                  } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[a-zA-Z]{2,}$')
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
                borderSide: const BorderSide(color: Colors.red, width: 1.5),
                borderRadius: BorderRadius.circular(20),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red, width: 1.5),
                borderRadius: BorderRadius.circular(20),
              ),
              errorText: _errorMessage,
            ),
            onChanged: (value) {
              setState(() {
                if (value.isEmpty) {
                  _errorMessage = 'Password tidak boleh kosong';
                } else if (value.length < 8) {
                  _errorMessage =
                      'Password harus terdiri dari minimal 8 karakter';
                } else {
                  _errorMessage = null;
                }
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              alignment: Alignment.centerRight,
              child: RichText(
                textAlign: TextAlign.right,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: ' Lupa Password?',
                      style: const TextStyle(
                        color: Colors.blue,
                        fontFamily: 'myfont',
                        fontSize: 12,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          _resetPassDialog();
                        },
                    ),
                  ],
                ),
              ),
            ),
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
              onPressed: () => authController.login(_email.text, _pass.text),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.transparent,
              ),
              child: const Text(
                'Login',
                style: TextStyle(
                    color: Colors.white, fontSize: 15, fontFamily: 'myfont'),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
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
                        text: "Belum Punya Akun?",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'myfont',
                          fontSize: 12,
                        ),
                      ),
                      TextSpan(
                        text: ' Daftar',
                        style: const TextStyle(
                          color: Colors.blue,
                          fontFamily: 'myfont',
                          fontSize: 12,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(
                                context, RegisterScreen.routeName);
                          },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  void _resetPassDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String? dialogMessage;
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text(
                'Masukan Email!',
                style: TextStyle(fontFamily: 'myfont'),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    style: const TextStyle(fontFamily: 'myfont'),
                    controller: _dialog,
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
                      errorText: dialogMessage,
                    ),
                    onChanged: (value) {
                      setState(() {
                        if (value.isEmpty) {
                          dialogMessage = 'Email tidak boleh kosong';
                        } else if (!RegExp(
                                r'^[\w-\.]+@([\w-]+\.)+[a-zA-Z]{2,}$')
                            .hasMatch(value)) {
                          dialogMessage = 'Email tidak valid';
                        } else {
                          dialogMessage = null;
                        }
                      });
                    },
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    authController.reset(_dialog.text);
                    _dialog.clear();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
