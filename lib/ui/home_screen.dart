import 'package:curd_flutter/colors/colors.dart';
import 'package:curd_flutter/firebase_controler.dart';
import 'package:curd_flutter/ui/add_data.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(15.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, AddData.routeName);
          },
          backgroundColor: primary700,
          shape: const CircleBorder(),
          child: const Icon(
            Icons.add,
            color: neutralWhite,
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
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Halo',
                        style: TextStyle(
                          color: neutralBlack,
                          fontSize: 30,
                          fontFamily: 'myfont',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
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
