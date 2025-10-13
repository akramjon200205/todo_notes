import 'package:todo_notes/feature/list/data/models/list_model.dart';

abstract class ListModelDatasource {
  Future<List<ListModel>> getAllListModel();
  Future<void> addList(ListModel listModel);
  Future<ListModel> updateListModel(int index, ListModel listModel);
  Future<void> deleteListModel(int index);
}
