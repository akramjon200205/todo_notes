import 'package:hive/hive.dart';
import 'package:todo_notes/core/hive_box/hive_box.dart';
import 'package:todo_notes/feature/list/data/models/list_model.dart';
import 'package:todo_notes/feature/list/domain/data/local/list_model_datasource.dart';

class ListModelDatasourceImpl implements ListModelDatasource {
  @override
  Future<void> addList(ListModel listModel) async {
    final Box<ListModel> listBox = await Hive.openBox<ListModel>(
      HiveBoxes.listBox,
    );
    await listBox.add(listModel);
    await listBox.close();
  }

  @override
  Future<void> deleteListModel(int index) async {
    final Box<ListModel> listBox = await Hive.openBox<ListModel>(
      HiveBoxes.listBox,
    );
    await listBox.deleteAt(index);
    await listBox.close();
  }

  @override
  Future<List<ListModel>> getAllListModel() async {
    final Box<ListModel> listBox = await Hive.openBox<ListModel>(
      HiveBoxes.listBox,
    );
    final listModel = listBox.values.toList();
    await listBox.close();
    return listModel;
  }

  @override
  Future<ListModel> updateListModel(int index, ListModel listModel) async {
    final Box<ListModel> listBox = await Hive.openBox<ListModel>(
      HiveBoxes.listBox,
    );
    await listBox.putAt(index, listModel);
    final updated = listBox.getAt(index)!;
    await listBox.close();
    return updated;
  }
}
