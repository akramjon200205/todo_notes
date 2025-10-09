part of 'list_bloc.dart';

sealed class ListEvent extends Equatable {
  const ListEvent();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class AddListEvent extends ListEvent {
  String name;
  Color? color;
  AddListEvent({this.color, required this.name});
}

// ignore: must_be_immutable
class UpdateListEvent extends ListEvent {
  String? name;
  Color? color;
  UpdateListEvent({this.color, this.name});
}

// ignore: must_be_immutable
class DeleteLisEvent extends ListEvent {
  int index;
  DeleteLisEvent(this.index);
}

class GetListEvent extends ListEvent {
  const GetListEvent();
}
