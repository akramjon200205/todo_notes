import 'package:todo_notes/feature/list/data/models/list_model.dart';
import 'package:todo_notes/feature/list/domain/data/local/list_model_datasource.dart';
import 'package:objectbox/objectbox.dart';

class ListModelDatasourceImpl implements ListModelDatasource {
  final Store store;

  ListModelDatasourceImpl(this.store);

  @override
  Future<void> addList(ListModel listModel) async {
    final box = store.box<ListModel>();
    box.put(listModel); // id = 0 bo‘lsa yangi yozuv
  }

  @override
  Future<void> deleteListModel(int index) async {
    final box = store.box<ListModel>();
    final list = box.getAll();
    if (index >= 0 && index < list.length) {
      box.remove(list[index].id);
    }
  }

  @override
  Future<List<ListModel>> getAllListModel() async {
    final box = store.box<ListModel>();
    return box.getAll();
  }

  @override
  Future<ListModel> updateListModel(int index, ListModel listModel) async {
    final box = store.box<ListModel>();
    final list = box.getAll();

    if (index >= 0 && index < list.length) {
      final existing = list[index];
      listModel.id = existing.id; // mavjud yozuvni yangilash uchun
      box.put(listModel);
      return listModel;
    }

    throw Exception("Invalid index: $index");
  }
}
