import 'dart:async';

import 'package:catatan/services/pref_services.dart';
import 'package:catatan/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'home_page.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    PrefServices().getPref().then((id) => Timer(const Duration(seconds: 3), () {
          if (id != '') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(
                  id: id,
                ),
              ),
            );
          } else {
            Navigator.pushReplacementNamed(context, '/sign-up');
          }
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.all(0.0),
                width: 250,
                height: 250,
                child: Lottie.asset('assets/logo.json'),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 25),
                child: Text(
                  'Catatan',
                  style: blackTextStyle.copyWith(
                    fontSize: 30,
                    fontWeight: medium,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
