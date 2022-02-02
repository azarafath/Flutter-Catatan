import 'package:catatan/cubit/auth_cubit.dart';
import 'package:catatan/shared/theme.dart';
import 'package:catatan/ui/widgets/custom_button.dart';
import 'package:catatan/ui/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  AssetImage image = const AssetImage('assets/forgotpassword.gif');

  @override
  void initState() {
    super.initState();
    image = const AssetImage('assets/forgotpassword.gif');
  }

  @override
  void dispose() {
    image.evict();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.only(left: 12),
        width: double.infinity,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
              ),
            ),
          ],
        ),
      );
    }

    Widget body() {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
        child: Column(
          children: [
            Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: image,
                ),
              ),
            ),
            Text(
              'Lupa Password?',
              style: blackTextStyle.copyWith(fontSize: 18, fontWeight: black),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5, bottom: 20),
              child: Text(
                'Masukkan alamat email yang terdaftar untuk mereset passwordmu',
                style:
                    blackTextStyle.copyWith(fontSize: 14, fontWeight: regular),
                textAlign: TextAlign.center,
              ),
            ),
            CustomTextFormField(
                title: 'Email',
                hintText: 'Masukkan email anda',
                controller: _emailController),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthReset) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: kGreenColor,
                      content: const Text(
                          'Sukses Reset Password, silahkan cek email anda'),
                    ),
                  );
                } else if (state is AuthResetFailed) {
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
                  margin: const EdgeInsets.only(top: 10),
                  title: 'Kirim',
                  onPressed: () {
                    context
                        .read<AuthCubit>()
                        .resetPassword(_emailController.text);
                  },
                  color: kBlueColor,
                );
              },
            )
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: ListView(
        children: [
          header(),
          body(),
        ],
      ),
    );
  }
}
