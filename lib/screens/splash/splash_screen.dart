import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../common_export.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    UiSizeConfig().init(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: const Center(
        child: Text(
          "Movies Clicks",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  void shouldSkipOnboard() {
    SharedPrefs sharedPrefs = SharedPrefs.instance;
    final token = sharedPrefs.getShouldSkipOnboard();
    if (token) {
      return GoRouter.of(context).replace('/homepage');
    }
    return GoRouter.of(context).replace('/onboarding');
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), shouldSkipOnboard);
  }
}
