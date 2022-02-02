import 'package:catatan/shared/theme.dart';
import 'package:catatan/ui/widgets/custom_button.dart';
import 'package:catatan/ui/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatelessWidget {
  EditProfile({Key? key}) : super(key: key);
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _pekerjaanController = TextEditingController();
  final TextEditingController _hobiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: const EdgeInsets.only(top: 25),
        padding: const EdgeInsets.only(left: 12, right: 12),
        width: double.infinity,
        child: Stack(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: Text(
                    'Edit Akun',
                    style: blackTextStyle.copyWith(
                      fontSize: 20,
                      fontWeight: semiBold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget body() {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(left: 24, right: 24, top: 20),
        child: Column(
          children: [
            Image.asset(
              'assets/profile.png',
              width: 120,
              height: 120,
            ),
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: Text(
                'Ubah Foto',
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            CustomTextFormField(
              title: 'Nama Lengkap',
              hintText: 'Masukkan Nama',
              controller: _namaController,
            ),
            CustomTextFormField(
              title: 'Pekerjaan',
              hintText: 'Masukkan Pekerjaan',
              controller: _pekerjaanController,
            ),
            CustomTextFormField(
              title: 'Hobi',
              hintText: 'Masukkan Hobi',
              controller: _hobiController,
            ),
            CustomButton(
              margin: const EdgeInsets.only(top: 16, bottom: 30),
              width: double.infinity,
              onPressed: () {},
              title: 'Simpan',
              color: kGreenColor,
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