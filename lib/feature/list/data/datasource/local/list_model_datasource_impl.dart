import 'dart:developer';

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
    log(listModel.name ?? '');

    await listBox.add(listModel);
    log(listBox.values.toString());
  }

  @override
  Future<void> deleteListModel(int index) async {
    final Box<ListModel> listBox = await Hive.openBox<ListModel>(
      HiveBoxes.listBox,
    );
    await listBox.deleteAt(index);
  }

  @override
  Future<List<ListModel>> getAllListModel() async {
    final Box<ListModel> listBox = await Hive.openBox<ListModel>(
      HiveBoxes.listBox,
    );
    final listModel = listBox.values.toList();
    log(listModel.toString());
    return listModel;
  }

  @override
  Future<ListModel> updateListModel(int index, ListModel listModel) async {
    final Box<ListModel> listBox = await Hive.openBox<ListModel>(
      HiveBoxes.listBox,
    );
    await listBox.putAt(index, listModel);
    return listBox.getAt(index)!;
  }
}
