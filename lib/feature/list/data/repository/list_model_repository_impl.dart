import 'package:dartz/dartz.dart';
import 'package:todo_notes/core/common/errors/failure.dart';
import 'package:todo_notes/feature/list/data/models/list_model.dart';
import 'package:todo_notes/feature/list/domain/data/local/list_model_datasource.dart';
import 'package:todo_notes/feature/list/domain/repository/list_model_repository.dart';

class ListModelRepositoryImpl implements ListModelRepository {
  ListModelDatasource listModelDatasource;
  ListModelRepositoryImpl({required this.listModelDatasource});

  @override
  Future<Either<Failure, ListModel>> addList(ListModel listModel) async {
    try {
      await listModelDatasource.addList(listModel);
      return Right(listModel);
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteList(int index) async {
    try {
      await listModelDatasource.deleteListModel(index);
      return const Right(true);
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ListModel>>> getAllLists() async {
    try {
      final results = await listModelDatasource.getAllListModel();
      return Right(results);
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ListModel>> updateList(
    int index,
    ListModel updateList,
  ) async {
    try {
      final updatedList = await listModelDatasource.updateListModel(
        index,
        updateList,
      );
      return Right(updatedList);
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
}
