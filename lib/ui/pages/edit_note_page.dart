import 'package:catatan/cubit/note_cubit.dart';
import 'package:catatan/models/note_model.dart';
import 'package:catatan/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class EditNote extends StatefulWidget {
  final NoteModel note;
  const EditNote({Key? key, required this.note}) : super(key: key);
  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  late Color _color;
  late String color;
  final TextEditingController _titleController =
      TextEditingController(text: '');

  final TextEditingController _contentController =
      TextEditingController(text: '');

  Widget pickerLayoutBuilder(
      BuildContext context, List<Color> colors, PickerItem child) {
    Orientation orientation = MediaQuery.of(context).orientation;

    return SizedBox(
      width: 300,
      height: 50,
      child: GridView.count(
        crossAxisCount: orientation == Orientation.portrait ? 5 : 5,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        children: [for (Color color in colors) child(color)],
      ),
    );
  }

  Widget pickerItemBuilder(
      Color color, bool isCurrentColor, void Function() changeColor) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [
          BoxShadow(
              color: color.withOpacity(0.8),
              offset: const Offset(1, 2),
              blurRadius: 5)
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: changeColor,
          borderRadius: BorderRadius.circular(50),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 250),
            opacity: isCurrentColor ? 1 : 0,
            child: Icon(
              Icons.done,
              size: 25,
              color: useWhiteForeground(color) ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    _color = colorFromHex(widget.note.color)!;
    _titleController.text = widget.note.title;
    _contentController.text = widget.note.text;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: const EdgeInsets.only(top: 25),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        width: double.infinity,
        child: Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 23,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            // delete button icon
            IconButton(
              icon: const Icon(
                Icons.delete,
                size: 23,
              ),
              onPressed: () {
                Navigator.pop(context);
                BlocProvider.of<NoteCubit>(context).deleteNote(widget.note.id);
              },
            ),
            const Spacer(),

            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Container(
                        width: 260,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: kBackgroundColor,
                        ),
                        child: BlockPicker(
                          pickerColor: _color,
                          onColorChanged: (Color color) {
                            setState(() {
                              _color = color;
                            });
                          },
                          availableColors: colors,
                          layoutBuilder: pickerLayoutBuilder,
                          itemBuilder: pickerItemBuilder,
                        ),
                      ),
                    );
                  },
                );
              },
              child: Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  color: _color,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(0, 2),
                      blurRadius: 10,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10),
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
              width: 70,
              height: 25,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: BlocConsumer<NoteCubit, NoteState>(
                listener: (context, state) {
                  if (state is NoteSuccess) {
                    Navigator.pop(context);
                  } else if (state is NoteFailed) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: kRedColor,
                        content: Text(state.error),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is NoteLoading) {
                    return const CircularProgressIndicator();
                  } else {
                    return GestureDetector(
                      onTap: () {
                        context.read<NoteCubit>().updateNote(
                              NoteModel(
                                id: widget.note.id,
                                title: _titleController.text,
                                text: _contentController.text,
                                color:
                                    colorToHex(_color, includeHashSign: true),
                                createAt: widget.note.createAt,
                                updateAt: DateTime.now().toString(),
                              ),
                            );
                      },
                      child: Center(
                        child: Text(
                          'Update',
                          style: blackTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: semiBold,
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            )
          ],
        ),
      );
    }

    Widget editItem() {
      return SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 5),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                style:
                    blackTextStyle.copyWith(fontSize: 27, fontWeight: semiBold),
                decoration: InputDecoration(
                  hintText: "Judul",
                  hintStyle: greyTextStyle.copyWith(
                    fontSize: 27,
                    fontWeight: semiBold,
                  ),
                  border: InputBorder.none,
                ),
              ),
              TextField(
                style: blackTextStyle.copyWith(fontSize: 22),
                controller: _contentController,
                decoration: InputDecoration(
                  hintText: "Tulis Catatanmu Disini",
                  hintStyle: greyTextStyle.copyWith(fontSize: 22),
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        flexibleSpace: header(),
      ),
      body: editItem(),
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
