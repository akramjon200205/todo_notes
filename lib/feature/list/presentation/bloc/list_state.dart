part of 'list_bloc.dart';

sealed class ListState extends Equatable {
  const ListState();

  @override
  List<Object> get props => [];
}

final class ListInitial extends ListState {
  const ListInitial();
  @override
  List<Object> get props => [];
}

class ListLoading extends ListState {
  const ListLoading();
}

class AddListState extends ListState {
  const AddListState();
}

class UpdateListState extends ListState {
  const UpdateListState();
}

class DeleteListState extends ListState {
  const DeleteListState();
}

// ignore: must_be_immutable
class GetListState extends ListState {
  List<ListModel> listModel;
  GetListState(this.listModel);
}

class ListError extends ListState {
  final String message;
  const ListError(this.message);

  @override
  List<Object> get props => [message];
}

// ignore: must_be_immutable
class ChangeColorState extends ListState {
  const ChangeColorState();
}
