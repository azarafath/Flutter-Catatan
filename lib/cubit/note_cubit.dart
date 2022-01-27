import 'package:bloc/bloc.dart';
import 'package:catatan/models/note_model.dart';
import 'package:catatan/services/note_service.dart';
import 'package:equatable/equatable.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit() : super(NoteInitial());

  void addNote(NoteModel note) async {
    try {
      emit(NoteLoading());
      await NoteServices().addNotes(note);
      emit(const NoteSuccess([]));
    } catch (e) {
      emit(NoteFailed(e.toString()));
    }
  }

  void updateNote(NoteModel note) async {
    try {
      emit(NoteLoading());
      await NoteServices().updateNotes(note);
      emit(const NoteSuccess([]));
    } catch (e) {
      emit(NoteFailed(e.toString()));
    }
  }

  void deleteNote(String id) async {
    try {
      emit(NoteLoading());
      await NoteServices().deleteNote(id);
      emit(NoteDeleted());
    } catch (e) {
      emit(NoteFailed(e.toString()));
    }
  }
}
