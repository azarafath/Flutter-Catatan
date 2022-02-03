import 'package:catatan/models/note_model.dart';
import 'package:catatan/models/user_model.dart';
import 'package:catatan/services/note_service.dart';
import 'package:catatan/services/user_service.dart';
import 'package:catatan/shared/theme.dart';
import 'package:catatan/ui/pages/edit_note_page.dart';
import 'package:catatan/ui/pages/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'add_note_page.dart';

class HomePage extends StatefulWidget {
  final String id;
  const HomePage({Key? key, required this.id}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final UserModel _usermodel;
  late AssetImage image;
  @override
  void initState() {
    image = const AssetImage('assets/catatankosongnew.gif');
    UserService().getUserById(widget.id).then((model) {
      setState(() {
        _usermodel = model;
      });
    });
    super.initState();
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
        margin: const EdgeInsets.only(left: 24, right: 24, top: 35),
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
                    builder: (context) => SettingPage(
                      id: _usermodel.id,
                    ),
                  ),
                );
              },
              child: Container(
                height: 35,
                width: 35,
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
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: image,
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
            top: 15,
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
                // jika data kosong
                if (snapshot.data == null) {
                  return catatanKosong();
                } else {
                  // jika data tidak kosong
                  // ignore: prefer_is_empty
                  if (snapshot.data?.length == 0) {
                    return catatanKosong();
                  } else {
                    return viewNotes(snapshot.data!);
                  }
                }
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: kBlueColor,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddNote(
                  id: widget.id,
                ),
              ),
            );
          },
          child: const Icon(Icons.add),
        ));
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
