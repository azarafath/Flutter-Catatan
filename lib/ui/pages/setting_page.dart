import 'package:catatan/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:catatan/cubit/auth_cubit.dart';
import 'package:catatan/models/user_model.dart';
import 'package:catatan/services/pref_services.dart';
import 'package:catatan/shared/theme.dart';

import 'edit_profile_page.dart';

class SettingPage extends StatefulWidget {
  final String id;
  const SettingPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool isBlack = false;
  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: const EdgeInsets.only(top: 30),
        padding: const EdgeInsets.only(left: 12),
        width: double.infinity,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: isBlack ? Colors.white : Colors.black,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 60),
              child: Text(
                'Pengaturan',
                style: isBlack
                    ? whiteTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: semiBold,
                      )
                    : blackTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: semiBold,
                      ),
              ),
            ),
          ],
        ),
      );
    }

    Widget akun(UserModel user) {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(left: 24, right: 24, top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Akun',
              style: isBlack
                  ? whiteTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    )
                  : blackTextStyle.copyWith(
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
                      userModel: user,
                    ),
                  ),
                );
              },
              child: Row(
                children: [
                  Image.asset(
                    'assets/profile.png',
                    width: 60,
                    color: isBlack ? Colors.white : kBlueColor,
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.name,
                            style: isBlack
                                ? whiteTextStyle.copyWith(fontSize: 16)
                                : blackTextStyle.copyWith(fontSize: 16),
                          ),
                          Text(
                            user.email,
                            style: greyTextStyle.copyWith(fontSize: 14),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 5),
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
              style: isBlack
                  ? whiteTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    )
                  : blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
            ),
            const SizedBox(height: 15),
            Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/dark.png',
                      width: 45,
                    ),
                    const SizedBox(width: 15),
                    Text(
                      'Dark Mode',
                      style: isBlack
                          ? whiteTextStyle.copyWith(fontSize: 16)
                          : blackTextStyle.copyWith(fontSize: 16),
                    ),
                    const Spacer(),
                    // switch button dark mode
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isBlack = !isBlack;
                        });
                      },
                      child: Container(
                        width: 50,
                        height: 25,
                        decoration: BoxDecoration(
                          color: kGreyColor1,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: EdgeInsets.only(
                              top: 5,
                              bottom: 5,
                              right: (isBlack) ? 0 : 25,
                              left: isBlack ? 25 : 0),
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 15),
              ],
            ),
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: const Duration(seconds: 2),
                    backgroundColor: kBlueColor,
                    content: Text(
                      'Untuk sekarang baru ada satu bahasa.',
                      style: whiteTextStyle.copyWith(fontSize: 12),
                    ),
                  ),
                );
              },
              child: Row(
                children: [
                  Image.asset(
                    'assets/language.png',
                    width: 45,
                  ),
                  const SizedBox(width: 15),
                  Text(
                    'Bahasa',
                    style: isBlack
                        ? whiteTextStyle.copyWith(fontSize: 16)
                        : blackTextStyle.copyWith(fontSize: 16),
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
            ),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    duration: const Duration(seconds: 2),
                    backgroundColor: kBlueColor,
                    content: Text(
                      'Fitur ini belum tersedia',
                      style: whiteTextStyle.copyWith(fontSize: 12),
                    ),
                  ),
                );
              },
              child: Row(
                children: [
                  Image.asset(
                    'assets/help.png',
                    width: 45,
                  ),
                  const SizedBox(width: 15),
                  Text(
                    'Bantuan',
                    style: isBlack
                        ? whiteTextStyle.copyWith(fontSize: 16)
                        : blackTextStyle.copyWith(fontSize: 16),
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
      backgroundColor: isBlack ? Colors.black : kBackgroundColor,
      body: StreamBuilder<UserModel>(
        stream: UserService().stremUserbyID(widget.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                header(),
                akun(snapshot.data!),
                pengaturan(),
                buttonKeluar(),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
