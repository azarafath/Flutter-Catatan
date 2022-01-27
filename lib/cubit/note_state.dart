part of 'note_cubit.dart';

abstract class NoteState extends Equatable {
  const NoteState();

  @override
  List<Object> get props => [];

  get notes => null;
}

class NoteInitial extends NoteState {}

class NoteLoading extends NoteState {}

class NoteSuccess extends NoteState {
  @override
  final List<NoteModel> notes;

  const NoteSuccess(this.notes);

  @override
  List<Object> get props => [notes];
}

class NoteFailed extends NoteState {
  final String error;

  const NoteFailed(this.error);

  @override
  List<Object> get props => [error];
}

class NoteEmpty extends NoteState {}

class NoteDeleted extends NoteState {}
