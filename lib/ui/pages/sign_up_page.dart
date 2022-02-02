import 'package:catatan/cubit/auth_cubit.dart';
import 'package:catatan/services/pref_services.dart';
import 'package:catatan/shared/theme.dart';
import 'package:catatan/ui/widgets/custom_button.dart';
import 'package:catatan/ui/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_page.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  final TextEditingController _namaController = TextEditingController(text: '');
  final TextEditingController _emailController =
      TextEditingController(text: '');
  final TextEditingController _passwordController =
      TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: const EdgeInsets.only(top: 70, left: 34),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selamat Datang 🖐',
              style: blackTextStyle.copyWith(
                fontSize: 24,
                fontWeight: semiBold,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              'Silakan mendaftar untuk melanjutkan',
              style: greyTextStyle.copyWith(
                fontSize: 14,
                fontWeight: medium,
              ),
            )
          ],
        ),
      );
    }

    Widget inputForm() {
      Widget namaInput() {
        return CustomTextFormField(
            title: 'Nama Lengkap',
            hintText: 'Masukkan nama anda',
            controller: _namaController);
      }

      Widget emailInput() {
        return CustomTextFormField(
            title: 'Email',
            hintText: 'Masukkan email anda',
            controller: _emailController);
      }

      Widget passwordInput() {
        return CustomTextFormField(
            title: 'Password',
            hintText: 'Masukkan password anda',
            obsecureText: true,
            controller: _passwordController);
      }

      Widget submitButton() {
        return BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              PrefServices().setPref(state.user.id);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(
                      id: state.user.id,
                    ),
                  ),
                  (route) => false);
            } else if (state is AuthFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: kRedColor,
                  content: Text(state.error),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return CustomButton(
                title: 'Mendaftar',
                onPressed: () {
                  context.read<AuthCubit>().signUp(
                      email: _emailController.text,
                      password: _passwordController.text,
                      name: _namaController.text);
                },
                color: kBlueColor);
          },
        );
      }

      return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(
          left: 24,
          right: 24,
          top: 47,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 30,
        ),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            namaInput(),
            emailInput(),
            passwordInput(),
            submitButton(),
          ],
        ),
      );
    }

    Widget textToLogin() {
      return Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(top: 40, bottom: 70),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Sudah punya akun ?', style: greyTextStyle),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/sign-in');
              },
              child: Text(
                ' Masuk',
                style: blackTextStyle.copyWith(
                  color: kBlueColor,
                  fontWeight: semiBold,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: ListView(
          children: [
            header(),
            inputForm(),
            textToLogin(),
          ],
        ),
      ),
    );
  }
}
