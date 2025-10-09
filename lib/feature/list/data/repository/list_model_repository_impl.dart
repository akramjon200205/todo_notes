import 'package:todo_notes/feature/list/domain/data/list_model_datasource.dart';
import 'package:todo_notes/feature/list/domain/repository/list_model_repository.dart';

class ListModelRepositoryImpl implements ListModelRepository {
  ListModelDatasource listModelDatasource;
  ListModelRepositoryImpl({required this.listModelDatasource});
}
