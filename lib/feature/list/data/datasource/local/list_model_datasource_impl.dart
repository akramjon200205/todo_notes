import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:todo_notes/core/hive_ce_box/hive_ce_box.dart';
import 'package:todo_notes/feature/list/data/models/list_model.dart';
import 'package:todo_notes/feature/list/domain/data/local/list_model_datasource.dart';

class ListModelDatasourceImpl implements ListModelDatasource {
  ListModelDatasourceImpl();

  Box<ListModel> get box => Hive.box<ListModel>(HiveCeBox.listBox);
  @override
  Future<void> addList(ListModel listModel) async {
    final key = DateTime.now().millisecondsSinceEpoch.toString();
    final list = ListModel(
      name: listModel.name,
      color: listModel.color,
      key: key,
    );

    box.put(key, list); // id = 0 bo‘lsa yangi yozuv
  }

  @override
  Future<void> deleteListModel(String key) async {
    await box.delete(key);
  }

  @override
  Future<List<ListModel>> getAllListModel() async {
    return box.values.toList();
  }

  @override
  Future<void> updateListModel(String key, ListModel listModel) async {
    await box.put(key, listModel);
  }
}
