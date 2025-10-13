part of 'list_bloc.dart';

sealed class ListEvent extends Equatable {
  const ListEvent();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class AddListEvent extends ListEvent {
  ListModel listModel;
  AddListEvent({required this.listModel});
}

// ignore: must_be_immutable
class UpdateListEvent extends ListEvent {
  int index;
  ListModel listModel;
  UpdateListEvent({required this.index, required this.listModel});
}

// ignore: must_be_immutable
class DeleteLisEvent extends ListEvent {
  int index;
  DeleteLisEvent(this.index);
}

class GetListEvent extends ListEvent {
  const GetListEvent();
}

// ignore: must_be_immutable
class ChangeColorEvent extends ListEvent {
  Color changeColor;
  ChangeColorEvent(this.changeColor);
}
