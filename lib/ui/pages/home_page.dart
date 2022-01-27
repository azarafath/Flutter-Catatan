import 'package:catatan/cubit/auth_cubit.dart';
import 'package:catatan/models/note_model.dart';
import 'package:catatan/services/note_service.dart';
import 'package:catatan/shared/theme.dart';
import 'package:catatan/ui/pages/edit_note_page.dart';
import 'package:catatan/ui/pages/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'add_note_page.dart';

class HomePage extends StatefulWidget {
  final String id;
  const HomePage({Key? key, required this.id}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isData = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: const EdgeInsets.only(left: 24, right: 24, top: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Catatan',
              style: TextStyle(
                fontSize: 20,
                fontWeight: semiBold,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingPage(),
                  ),
                );
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/profile.png',
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget catatanKosong() {
      return Container(
        margin: const EdgeInsets.only(top: 100),
        width: double.infinity,
        child: Column(
          children: [
            Container(
              width: 300,
              height: 300,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/catatanKosong.png'),
                ),
              ),
            ),
            Text(
              'Buat Catatan Pertamamu !',
              style: blackTextStyle.copyWith(fontWeight: medium),
            )
          ],
        ),
      );
    }

    Widget viewNotes(List<NoteModel> notes) {
      return Scrollbar(
        child: Container(
          padding: const EdgeInsets.only(
            top: 10,
            right: 20,
            left: 20,
          ),
          child: StaggeredGrid.count(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: notes.map((note) {
              return GestureDetector(
                onDoubleTap: () {
                  // show alert dialog yes or no
                },
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return EditNote(
                          note: note,
                        );
                      },
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: HexColor.fromHex(note.color),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        note.title,
                        style: whiteTextStyle.copyWith(
                            fontSize: 14, fontWeight: bold),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        note.text,
                        style: whiteTextStyle.copyWith(
                          fontSize: 12,
                          fontWeight: semiBold,
                        ),
                        maxLines: 6,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kBackgroundColor,
        flexibleSpace: header(),
        elevation: 0,
      ),
      body: ListView(
        children: [
          StreamBuilder<List<NoteModel>>(
            stream: NoteServices().getNotes(widget.id),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return viewNotes(snapshot.data!);
              } else {
                return catatanKosong();
              }
            },
          ),
        ],
      ),
      floatingActionButton: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccess) {
            return FloatingActionButton(
              backgroundColor: kBlueColor,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddNote(
                      id: state.user.id,
                    ),
                  ),
                );
              },
              child: const Icon(Icons.add),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
