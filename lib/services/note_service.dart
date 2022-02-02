import 'package:catatan/models/note_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NoteServices {
  final CollectionReference _noteReference =
      FirebaseFirestore.instance.collection('notes');

  Future<void> addNotes(NoteModel note) async {
    try {
      _noteReference.add({
        'id': note.id,
        'title': note.title,
        'text': note.text,
        'color': note.color,
        'create_at': note.createAt,
        'update_at': note.updateAt,
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateNotes(NoteModel note) async {
    try {
      _noteReference.doc(note.id).update({
        'title': note.title,
        'text': note.text,
        'color': note.color,
        'create_at': note.createAt,
        'update_at': note.updateAt,
      });
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<NoteModel>> getNotes(String id) {
    try {
      return _noteReference
          .where('id', isEqualTo: id)
          .snapshots()
          .map((QuerySnapshot list) {
        var result = list.docs.map<NoteModel>((DocumentSnapshot notes) {
          return NoteModel.fromJson(
              notes.id, notes.data() as Map<String, dynamic>);
        }).toList();
        result.sort(
            (NoteModel a, NoteModel b) => b.createAt.compareTo(a.createAt));
        return result;
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteNote(String id) async {
    try {
      await _noteReference.doc(id).delete();
    } catch (e) {
      rethrow;
    }
  }
}
