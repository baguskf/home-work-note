import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curd_flutter/colors/colors.dart';
import 'package:curd_flutter/controller/firebase_controler.dart';
import 'package:curd_flutter/ui/add_data.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home_screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final authController = Get.find<FirebaeControler>();
  final user = FirebaseAuth.instance.currentUser;
  String? userName;

  @override
  void initState() {
    super.initState();
    getCurrentUserName();
  }

  Future<void> getCurrentUserName() async {
    if (user != null) {
      try {
        DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user!.uid)
            .get();

        if (documentSnapshot.exists) {
          Map<String, dynamic>? data =
              documentSnapshot.data() as Map<String, dynamic>?;
          if (data != null) {
            setState(() {
              userName = data['name'];
            });
          }
        }
      } catch (e) {
        // ignore: avoid_print
        print('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(15.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                primary700,
                Color.fromARGB(255, 47, 0, 255),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(50),
          ),
          child: FloatingActionButton(
            backgroundColor: Colors.transparent,
            onPressed: () {
              Navigator.pushNamed(context, AddData.routeName,
                  arguments: user!.uid);
            },
            shape: const CircleBorder(),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: neutral500,
            ),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Halo, ',
                        style: TextStyle(
                          color: neutralBlack,
                          fontSize: 30,
                          fontFamily: 'myfont',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        userName != null ? '$userName' : '',
                        style: const TextStyle(
                          color: neutralBlack,
                          fontSize: 15,
                          fontFamily: 'myfont',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Jangan Lupa Dikerjakan!',
                        style: TextStyle(
                            color: neutralBlack,
                            fontSize: 20,
                            fontFamily: 'myfont',
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () => authController.logout(),
                    icon: const Icon(Icons.login_outlined),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
