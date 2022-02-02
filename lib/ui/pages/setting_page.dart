import 'package:catatan/ui/pages/edit_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:catatan/cubit/auth_cubit.dart';
import 'package:catatan/models/user_model.dart';
import 'package:catatan/services/pref_services.dart';
import 'package:catatan/shared/theme.dart';

class SettingPage extends StatelessWidget {
  final UserModel userModel;
  const SettingPage({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: const EdgeInsets.only(top: 25),
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
            Container(
              margin: const EdgeInsets.only(left: 60),
              child: Text(
                'Pengaturan',
                style: blackTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: semiBold,
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget akun() {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(left: 24, right: 24, top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Akun',
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfile(
                      userModel: userModel,
                    ),
                  ),
                );
              },
              child: Row(
                children: [
                  Image.asset(
                    'assets/profile.png',
                    width: 65,
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userModel.name,
                            style: blackTextStyle.copyWith(fontSize: 16),
                          ),
                          Text(
                            userModel.email,
                            style: greyTextStyle.copyWith(fontSize: 14),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 16,
                    height: 25,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/nexticon.png'),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
    }

    Widget pengaturan() {
      return Container(
        margin: const EdgeInsets.only(top: 25, left: 24, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pengaturan',
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
            const SizedBox(height: 15),
            // Column(
            //   children: [
            //     Row(
            //       children: [
            //         Image.asset(
            //           'assets/dark.png',
            //           width: 45,
            //         ),
            //         const SizedBox(width: 15),
            //         Text(
            //           'Dark Mode',
            //           style: blackTextStyle.copyWith(fontSize: 16),
            //         ),
            //         const Spacer(),
            //         // switch button dark mode
            //         Container(
            //           width: 50,
            //           height: 25,
            //           decoration: BoxDecoration(
            //             color: kGreyColor1,
            //             borderRadius: BorderRadius.circular(25),
            //           ),
            //           child: Container(
            //             margin:
            //                 const EdgeInsets.only(top: 5, bottom: 5, right: 25),
            //             width: 25,
            //             height: 25,
            //             decoration: BoxDecoration(
            //               shape: BoxShape.circle,
            //               color: kPrimaryColor,
            //             ),
            //           ),
            //         )
            //       ],
            //     ),
            //     const SizedBox(height: 15),
            //   ],
            // ),
            Row(
              children: [
                Image.asset(
                  'assets/language.png',
                  width: 45,
                ),
                const SizedBox(width: 15),
                Text(
                  'Bahasa',
                  style: blackTextStyle.copyWith(fontSize: 16),
                ),
                const Spacer(),
                Container(
                  width: 16,
                  height: 25,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/nexticon.png'),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Image.asset(
                  'assets/help.png',
                  width: 45,
                ),
                const SizedBox(width: 15),
                Text(
                  'Bantuan',
                  style: blackTextStyle.copyWith(fontSize: 16),
                ),
                const Spacer(),
                Container(
                  width: 16,
                  height: 25,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/nexticon.png'),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      );
    }

    Widget buttonKeluar() {
      return BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthInitial) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/sign-in', (route) => false);
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
          return Container(
            width: double.infinity,
            height: 55,
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
            decoration: BoxDecoration(
              color: kRedColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextButton(
              onPressed: () {
                PrefServices().deletePref();
                context.read<AuthCubit>().signOut();
              },
              child: Text(
                'Keluar',
                style:
                    whiteTextStyle.copyWith(fontSize: 18, fontWeight: medium),
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      body: Column(
        children: [
          header(),
          akun(),
          pengaturan(),
          buttonKeluar(),
        ],
      ),
    );
  }
}
