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
