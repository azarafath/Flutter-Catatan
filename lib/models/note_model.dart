import 'package:equatable/equatable.dart';

class NoteModel extends Equatable {
  final String id;
  final String title;
  final String text;
  final String color;
  final String createAt;
  final String updateAt;

  const NoteModel(
      {this.id = '',
      required this.title,
      required this.text,
      required this.color,
      required this.createAt,
      required this.updateAt});

  factory NoteModel.fromJson(String id, Map<String, dynamic> json) => NoteModel(
        id: id,
        title: json['title'],
        text: json['text'],
        color: json['color'],
        createAt: json['create_at'],
        updateAt: json['update_at'],
      );

  @override
  List<Object> get props {
    return [
      id,
      title,
      text,
      color,
      createAt,
      updateAt,
    ];
  }
}
