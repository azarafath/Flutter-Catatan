import 'package:catatan/cubit/auth_cubit.dart';
import 'package:catatan/ui/pages/forgot_password_page.dart';
import 'package:catatan/ui/pages/sign_in_page.dart';
import 'package:catatan/ui/pages/sign_up_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/note_cubit.dart';
import 'ui/pages/splash_screen_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => NoteCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (_) => const SplashScreenPage(),
          '/sign-up': (_) => SignUpPage(),
          '/sign-in': (_) => SignInPage(),
          '/forgot': (_) => const ForgotPasswordPage(),
        },
      ),
    );
  }
}
