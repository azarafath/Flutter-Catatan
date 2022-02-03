import 'package:catatan/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:catatan/models/user_model.dart';
import 'package:catatan/shared/theme.dart';
import 'package:catatan/ui/widgets/custom_button.dart';
import 'package:catatan/ui/widgets/custom_text_form_field.dart';

class EditProfile extends StatefulWidget {
  final UserModel userModel;
  const EditProfile({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _namaController = TextEditingController();

  final TextEditingController _pekerjaanController = TextEditingController();

  final TextEditingController _hobiController = TextEditingController();

  @override
  void initState() {
    _namaController.text = widget.userModel.name;
    _pekerjaanController.text = widget.userModel.job;
    _hobiController.text = widget.userModel.hobby;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        padding: const EdgeInsets.only(left: 12, right: 12, top: 5),
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
              child: Container(
                margin: const EdgeInsets.only(top: 8),
                child: Text(
                  'Ubah Foto',
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            CustomTextFormField(
              title: 'Nama Lengkap',
              hintText: 'Masukkan nama',
              controller: _namaController,
            ),
            CustomTextFormField(
              title: 'Pekerjaan',
              hintText: 'Masukkan pekerjaan',
              controller: _pekerjaanController,
            ),
            CustomTextFormField(
              title: 'Hobi',
              hintText: 'Masukkan hobi',
              controller: _hobiController,
            ),
            CustomButton(
              margin: const EdgeInsets.only(top: 16, bottom: 30),
              width: double.infinity,
              onPressed: () {
                UserService().updateUser(
                  widget.userModel.id,
                  widget.userModel.email,
                  _namaController.text,
                  _pekerjaanController.text,
                  _hobiController.text,
                );
                Navigator.pop(context);
              },
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
